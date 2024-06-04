/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Legion
 */
public class OrderDAO {
    private Connection connection;
    private PreparedStatement stmt;
    private ResultSet rs;

    public OrderDAO() {
        try {
            // Initialize the connection in the constructor
            connection = new DBContext().getConnection();
        } catch (Exception ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public List<Order> getAllOrders(){
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM [swp-online-shop].[dbo].[Order]";

        try {
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                // Extract data from ResultSet
                int id = rs.getInt("ID");
                int userId = rs.getInt("UserID");
                String fullName = rs.getString("Fullname");
                String address = rs.getString("Address");
                String phone = rs.getString("Phone");
                String status = rs.getString("Status");
                boolean isDeleted = rs.getBoolean("IsDeleted");
                Timestamp createdAt = rs.getTimestamp("CreatedAt");
                int createdBy = rs.getInt("CreatedBy");

                // Create an Order object with extracted data
                Order order = new Order(id, userId, fullName, address, phone, status, isDeleted, createdAt, createdBy);
                orders.add(order);
            }

            return orders;
        } catch (SQLException ex) {
            System.out.println("getAllOrders: " +ex.getMessage());
        } 
        return orders;
    }
    
    public double getTotal(int orderId) {
        String sql = "SELECT SUM(pd.price * od.quantity) AS total_cost " +
                     "FROM [swp-online-shop].[dbo].[Order] o " +
                     "INNER JOIN [swp-online-shop].[dbo].[OrderDetail] od ON o.ID = od.OrderID " +
                     "INNER JOIN [swp-online-shop].[dbo].[ProductDetail] pd ON od.[ProductDetailID] = pd.ID " +
                     "WHERE o.ID = ? " +
                     "GROUP BY o.ID";

        try {
            stmt = connection.prepareStatement(sql);
            stmt.setInt(1, orderId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getDouble("total_cost");
            } 
        } catch (SQLException ex) {
            System.out.println("getTotal: " + ex.getMessage());
        }
        return 0;
    }
    
}
