package DAO;

import Model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public UserDAO() {
        try {
            // Initialize the connection in the constructor
            conn = new DBContext().getConnection();
        } catch (Exception ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Create (Register)
    public boolean registerUser(User user) {
        String query = "INSERT INTO [User] (Email, Password, Fullname, Gender, Address, Phone, CreatedBy) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getGender());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPhone());
            ps.setInt(7, user.getCreatedBy());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return false;
    }
    
    // Read (Get User by Id)
    public User getUserById(int id) {
        String query = "SELECT * FROM [User] WHERE ID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setFullname(rs.getString("Fullname"));
                user.setGender(rs.getString("Gender"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setIsDeleted(rs.getBoolean("IsDeleted"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                user.setCreatedBy(rs.getInt("CreatedBy"));
                return user;
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return null;
    }

    // Read (Get User by Email)
    public User getUserByEmail(String email) {
        String query = "SELECT * FROM [User] WHERE Email = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setFullname(rs.getString("Fullname"));
                user.setGender(rs.getString("Gender"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setIsDeleted(rs.getBoolean("IsDeleted"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                user.setCreatedBy(rs.getInt("CreatedBy"));
                return user;
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return null;
    }
    
    // Get all users with pagination
    public List<User> getAllUsers(int pageNumber, int pageSize) {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY ID) AS RowNum, * FROM [User]) AS SubQuery WHERE RowNum BETWEEN ? AND ?";
        int startIndex = (pageNumber - 1) * pageSize + 1;
        int endIndex = pageNumber * pageSize;
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, startIndex);
            ps.setInt(2, endIndex);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setFullname(rs.getString("Fullname"));
                user.setGender(rs.getString("Gender"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setIsDeleted(rs.getBoolean("IsDeleted"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                user.setCreatedBy(rs.getInt("CreatedBy"));
                userList.add(user);
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return userList;
    }
    
    public List<User> getAllPagination(int pageNumber, int pageSize) {
        List<User> userList = new ArrayList<>();
        String query = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY UserID) AS RowNum, * FROM Users) AS SubQuery WHERE RowNum BETWEEN ? AND ?";
        int startIndex = (pageNumber - 1) * pageSize + 1;
        int endIndex = pageNumber * pageSize;
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, startIndex);
            ps.setInt(2, endIndex);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setFullname(rs.getString("Fullname"));
                user.setGender(rs.getString("Gender"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setIsDeleted(rs.getBoolean("IsDeleted"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                user.setCreatedBy(rs.getInt("CreatedBy"));
                userList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return userList;
    }
    
    public List<User> getFilteredUsers(String fullName, String email, String role, String gender, int pageNumber, int pageSize) {
        List<User> filteredUserList = new ArrayList<>();
        String query = "SELECT * FROM (SELECT *, ROW_NUMBER() OVER (ORDER BY UserID) AS RowNum FROM Users WHERE 1=1";
        // Add filter conditions
        if (fullName != null && !fullName.isEmpty()) {
            query += " AND FullName LIKE '%" + fullName + "%'";
        }
        if (email != null && !email.isEmpty()) {
            query += " AND Email LIKE '%" + email + "%'";
        }
        if (role != null && !role.isEmpty()) {
            query += " AND Role = '" + role + "'";
        }
        if (gender != null && !gender.isEmpty()) {
            query += " AND Gender = " + Boolean.parseBoolean(gender);
        }
        // Add pagination
        query += ") AS SubQuery WHERE RowNum BETWEEN ? AND ?";
        int startIndex = (pageNumber - 1) * pageSize + 1;
        int endIndex = pageNumber * pageSize;
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, startIndex);
            ps.setInt(2, endIndex);
            rs = ps.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setFullname(rs.getString("Fullname"));
                user.setGender(rs.getString("Gender"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setIsDeleted(rs.getBoolean("IsDeleted"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                user.setCreatedBy(rs.getInt("CreatedBy"));
                filteredUserList.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return filteredUserList;
    }

    // Update (Update User)
    public boolean updateUser(User user) {
        String query = "UPDATE [User] SET Email=?, Password=?, Fullname=?, Gender=?, Address=?, Phone=?, IsDeleted=?, CreatedBy=? WHERE ID=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, user.getEmail());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFullname());
            ps.setString(4, user.getGender());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPhone());
            ps.setBoolean(7, user.isIsDeleted());
            ps.setInt(8, user.getCreatedBy());
            ps.setInt(9, user.getId());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return false;
    }

    // Delete (Delete User)
    public boolean deleteUser(int userID) {
        String query = "DELETE FROM [User] WHERE ID=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, userID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return false;
    }

    // Login
    public User loginUser(String email, String password) {
        String query = "SELECT * FROM [User] WHERE Email = ? AND Password = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));
                user.setFullname(rs.getString("Fullname"));
                user.setGender(rs.getString("Gender"));
                user.setAddress(rs.getString("Address"));
                user.setPhone(rs.getString("Phone"));
                user.setIsDeleted(rs.getBoolean("IsDeleted"));
                user.setCreatedAt(rs.getTimestamp("CreatedAt").toLocalDateTime());
                user.setCreatedBy(rs.getInt("CreatedBy"));
                return user;
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        } finally {
            closeResources();
        }
        return null;
    }

    private void closeResources() {
        try {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
    }
}
