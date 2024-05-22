/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Category;
import Model.Post;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

/**
 *
 * @author Legion
 */
public class PostDAO extends DBContext {

    Connection connection;

    public PostDAO() {
        try {
            connection = getConnection();
        } catch (Exception ex) {
            System.out.println("Connect failed");
        }
    }

    public List<Post> getPosts(int page, int pageSize, String category, String author, String status, String search, String sortBy, String sortOrder) {
        List<Post> posts = new ArrayList<>();
        int offset = (page - 1) * pageSize;
        StringBuilder query = new StringBuilder("SELECT po.ID, po.[CategoryId], po.Title, po.Content, po.IsDeleted, po.CreatedAt, po.imgURL, u.Fullname as AuthorName "
                + "FROM [dbo].[Post] po "
                + "JOIN [dbo].[User] u ON po.CreatedBy = u.ID "
                + "JOIN [dbo].[Category] c ON po.CategoryId = c.ID "
                + "WHERE 1=1");

        if (category != null && !category.isEmpty()) {
            query.append(" AND c.Name = ?");
        }
        if (author != null && !author.isEmpty()) {
            query.append(" AND u.Fullname = ?");
        }
        if (status != null && !status.isEmpty()) {
            query.append(" AND po.IsDeleted = ?");
        }
        if (search != null && !search.isEmpty()) {
            query.append(" AND po.Title LIKE ?");
        }
        if (sortBy != null && !sortBy.isEmpty()) {
            query.append(" ORDER BY ").append(sortBy).append(" ").append(sortOrder);
        } else {
            query.append(" ORDER BY po.CreatedAt DESC");
        }
        query.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (category != null && !category.isEmpty()) {
                stmt.setString(paramIndex++, category);
            }
            if (author != null && !author.isEmpty()) {
                stmt.setString(paramIndex++, author);
            }
            if (status != null && !status.isEmpty()) {
                stmt.setBoolean(paramIndex++, !"show".equalsIgnoreCase(status));
            }
            if (search != null && !search.isEmpty()) {
                stmt.setString(paramIndex++, "%" + search + "%");
            }
            stmt.setInt(paramIndex++, offset);
            stmt.setInt(paramIndex, pageSize);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("ID");
                int categoryId = rs.getInt("categoryId");
                String title = rs.getString("Title");
                String content = rs.getString("Content");
                boolean isDeleted = rs.getBoolean("IsDeleted");
                Timestamp createdAt = rs.getTimestamp("CreatedAt");
                String authorName = rs.getString("AuthorName");
                Post post = new Post(id, categoryId, title, content, isDeleted, createdAt, authorName);
                post.setImgURL(rs.getString("imgURL"));
                posts.add(post);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return posts;
    }

    public int getTotalPosts(String category, String author, String status, String search) {
        int totalPosts = 0;
        StringBuilder query = new StringBuilder("SELECT COUNT(*) as Total "
                + "FROM [dbo].[Post] po "
                + "JOIN [dbo].[User] u ON po.CreatedBy = u.ID "
                + "JOIN [dbo].[Category] c ON po.CategoryId = c.ID "
                + "WHERE 1=1");

        if (category != null && !category.isEmpty()) {
            query.append(" AND c.Name = ?");
        }
        if (author != null && !author.isEmpty()) {
            query.append(" AND u.Fullname = ?");
        }
        if (status != null && !status.isEmpty()) {
            query.append(" AND po.IsDeleted = ?");
        }
        if (search != null && !search.isEmpty()) {
            query.append(" AND po.Title LIKE ?");
        }

        try (PreparedStatement stmt = connection.prepareStatement(query.toString())) {
            int paramIndex = 1;
            if (category != null && !category.isEmpty()) {
                stmt.setString(paramIndex++, category);
            }
            if (author != null && !author.isEmpty()) {
                stmt.setString(paramIndex++, author);
            }
            if (status != null && !status.isEmpty()) {
                stmt.setBoolean(paramIndex++, !"show".equalsIgnoreCase(status));
            }
            if (search != null && !search.isEmpty()) {
                stmt.setString(paramIndex++, "%" + search + "%");
            }

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                totalPosts = rs.getInt("Total");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalPosts;
    }

    public List<Category> getUniqueCategories() {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT DISTINCT c.ID, c.Name "
                + "FROM [dbo].[Category] c "
                + "WHERE c.IsDeleted = 0";

        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Category category = new Category();
                category.setID(rs.getInt("ID"));
                category.setCategoryName(rs.getString("Name"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }

    public List<String> getUniqueAuthors() {
        List<String> authors = new ArrayList<>();
        String query = "SELECT DISTINCT u.Fullname FROM [dbo].[Post] po JOIN [dbo].[User] u ON po.CreatedBy = u.ID";

        try (PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                authors.add(rs.getString("Fullname"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return authors;
    }

    public boolean createPost(String title, String content, String category, int createdBy, String imgURL) {
        String query = "INSERT INTO [dbo].[Post] (Title, Content, categoryid, IsDeleted, CreatedAt, CreatedBy, imgURL) VALUES (?, ?, ?, 0, GETDATE(), ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query);) {
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setInt(3, Integer.parseInt(category));
            stmt.setInt(4, createdBy);
            stmt.setString(5, imgURL);

            int rowsInserted = stmt.executeUpdate();
            if (rowsInserted > 0) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Method to retrieve a post by its ID
    public Post getPostById(int postId) {
        Post post = new Post();
        // SQL query to retrieve post by ID
        String query = "SELECT po.ID as PostID, CategoryId, Title, Content, po.IsDeleted, po.CreatedAt, po.CreatedBy, u.Fullname as AuthorName "
                + "FROM [dbo].[Post] po "
                + "JOIN [dbo].[User] u ON po.CreatedBy = u.ID "
                + "WHERE po.ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query);) {
            stmt.setInt(1, postId);
            // Execute the query
            ResultSet rs = stmt.executeQuery();
            // Check if result set is not empty
            if (rs.next()) {

                int categoryId = rs.getInt("CategoryId");
                String title = rs.getString("Title");
                String content = rs.getString("Content");
                boolean isDeleted = rs.getBoolean("IsDeleted");
                Timestamp createdAt = rs.getTimestamp("CreatedAt");
                int createdBy = rs.getInt("CreatedBy");
                String authorName = rs.getString("AuthorName");

                // Create Post object
                post = new Post(postId, categoryId, title, content, isDeleted, createdAt, createdBy);
                post.setAuthorName(authorName);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle SQLException
        }

        return post;
    }
    
    
    public boolean updatePost(int postId, String title, String content, int categoryId, String imgURL) {
        // SQL query to update the post
            String query = "UPDATE [dbo].[Post] SET Title = ?, Content = ?, CategoryId = ?, imgURL = ? WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query);){
            stmt.setString(1, title);
            stmt.setString(2, content);
            stmt.setInt(3, categoryId);
            stmt.setString(3, imgURL);
            stmt.setInt(5, postId);

            // Execute the update query
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                return true;
            } 
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updatePost(int postId, int isDeleted) {
        // SQL query to update the post
            String query = "UPDATE [dbo].[Post] SET isDeleted = ? WHERE ID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query);){

            stmt.setInt(1, isDeleted);
            stmt.setInt(2, postId);

            // Execute the update query
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                return true;
            } 
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
