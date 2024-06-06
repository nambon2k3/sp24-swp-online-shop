package DAO;

import Model.Feedback;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;


public class FeedbackDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public FeedbackDAO() {
        try {
            // Initialize the connection in the constructor
            conn = new DBContext().getConnection();
        } catch (Exception ex) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // Create (Add new Feedback)
    public boolean addFeedback(Feedback feedback) {
        String query = "INSERT INTO [Feedback] (OrderDetailId, Rating, Comment, IsDeleted, CreatedAt, CreatedBy) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, feedback.getOrderDetailId());
            ps.setInt(2, feedback.getRating());
            ps.setString(3, feedback.getComment());
            ps.setBoolean(4, feedback.isIsDeleted());
            ps.setDate(5, new java.sql.Date(feedback.getCreatedAt().getTime()));
            ps.setInt(6, feedback.getCreatedBy());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    // Read (Get Feedback by Id)
    public Feedback getFeedbackById(int id) {
        String query = "SELECT * FROM [Feedback] WHERE ID = ?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("ID"));
                feedback.setOrderDetailId(rs.getInt("OrderDetailId"));
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setIsDeleted(rs.getBoolean("IsDeleted"));
                feedback.setCreatedAt(rs.getDate("CreatedAt"));
                feedback.setCreatedBy(rs.getInt("CreatedBy"));
                return feedback;
            }
        } catch (SQLException e) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    // Read (Get all Feedbacks with pagination)
    public List<Feedback> getAllFeedbacks(int pageNumber, int pageSize) {
        List<Feedback> feedbackList = new ArrayList<>();
        String query = "SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY ID) AS RowNum, * FROM [Feedback]) AS SubQuery WHERE RowNum BETWEEN ? AND ?";
        int startIndex = (pageNumber - 1) * pageSize + 1;
        int endIndex = pageNumber * pageSize;
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, startIndex);
            ps.setInt(2, endIndex);
            rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("ID"));
                feedback.setOrderDetailId(rs.getInt("OrderDetailId"));
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setIsDeleted(rs.getBoolean("IsDeleted"));
                feedback.setCreatedAt(rs.getDate("CreatedAt"));
                feedback.setCreatedBy(rs.getInt("CreatedBy"));
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return feedbackList;
    }

    // Read (Get filtered Feedbacks with pagination)
    public List<Feedback> getFilteredFeedbacks(String comment, Boolean isDeleted, int pageNumber, int pageSize) {
        List<Feedback> feedbackList = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY ID) AS RowNum, * FROM [Feedback] WHERE 1=1");

        if (comment != null && !comment.isEmpty()) {
            queryBuilder.append(" AND Comment LIKE ?");
        }
        if (isDeleted != null) {
            queryBuilder.append(" AND IsDeleted = ?");
        }

        queryBuilder.append(") AS SubQuery WHERE RowNum BETWEEN ? AND ?");

        String query = queryBuilder.toString();
        int startIndex = (pageNumber - 1) * pageSize + 1;
        int endIndex = pageNumber * pageSize;
        try {
            ps = conn.prepareStatement(query);
            int paramIndex = 1;
            if (comment != null && !comment.isEmpty()) {
                ps.setString(paramIndex++, "%" + comment + "%");
            }
            if (isDeleted != null) {
                ps.setBoolean(paramIndex++, isDeleted);
            }
            ps.setInt(paramIndex++, startIndex);
            ps.setInt(paramIndex, endIndex);
            rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("ID"));
                feedback.setOrderDetailId(rs.getInt("OrderDetailId"));
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setIsDeleted(rs.getBoolean("IsDeleted"));
                feedback.setCreatedAt(rs.getDate("CreatedAt"));
                feedback.setCreatedBy(rs.getInt("CreatedBy"));
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return feedbackList;
    }
    
    public List<Feedback> getFilteredFeedbacks(String comment, Boolean isDeleted) {
        List<Feedback> feedbackList = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder("SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY ID) AS RowNum, * FROM [Feedback] WHERE 1=1");

        if (comment != null && !comment.isEmpty()) {
            queryBuilder.append(" AND Comment LIKE ?");
        }
        if (isDeleted != null) {
            queryBuilder.append(" AND IsDeleted = ?");
        }

        queryBuilder.append(") AS SubQuery");

        String query = queryBuilder.toString();
        try {
            ps = conn.prepareStatement(query);
            int paramIndex = 1;
            if (comment != null && !comment.isEmpty()) {
                ps.setString(paramIndex++, "%" + comment + "%");
            }
            if (isDeleted != null) {
                ps.setBoolean(paramIndex++, isDeleted);
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setId(rs.getInt("ID"));
                feedback.setOrderDetailId(rs.getInt("OrderDetailId"));
                feedback.setRating(rs.getInt("Rating"));
                feedback.setComment(rs.getString("Comment"));
                feedback.setIsDeleted(rs.getBoolean("IsDeleted"));
                feedback.setCreatedAt(rs.getDate("CreatedAt"));
                feedback.setCreatedBy(rs.getInt("CreatedBy"));
                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return feedbackList;
    }

    // Update (Update Feedback)
    public boolean updateFeedback(Feedback feedback) {
        String query = "UPDATE [Feedback] SET OrderDetailId=?, Rating=?, Comment=?, IsDeleted=?, CreatedAt=?, CreatedBy=? WHERE ID=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, feedback.getOrderDetailId());
            ps.setInt(2, feedback.getRating());
            ps.setString(3, feedback.getComment());
            ps.setBoolean(4, feedback.isIsDeleted());
            ps.setDate(5, new java.sql.Date(feedback.getCreatedAt().getTime()));
            ps.setInt(6, feedback.getCreatedBy());
            ps.setInt(7, feedback.getId());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }

    // Delete (Delete Feedback)
    public boolean deleteFeedback(int feedbackID) {
        String query = "DELETE FROM [Feedback] WHERE ID=?";
        try {
            ps = conn.prepareStatement(query);
            ps.setInt(1, feedbackID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(FeedbackDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return false;
    }
}
