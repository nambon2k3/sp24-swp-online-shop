/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import Model.Product;
import Model.ProductDetail;
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
    
    // Method to get orders with pagination
    public List<Order> getOrdersByPage(int currentPage, int ordersPerPage, int userId) {
        List<Order> orders = new ArrayList<>();
        int start = (currentPage - 1) * ordersPerPage;

        try {
            String sql = "SELECT * FROM [dbo].[Order] WHERE [UserID] = ? ORDER BY createdAt OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            statement.setInt(2, start);
            statement.setInt(3, ordersPerPage);
            
            rs = statement.executeQuery();
            while (rs.next()) {
                // Extract data from ResultSet
                int id = rs.getInt("ID");
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    // Method to get the total number of orders
    public int getTotalOrderCount(int userId) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM [dbo].[Order] WHERE [UserID] = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, userId);
            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    // Method to fetch order details by order ID
    public Order getOrderById(int orderId) {
        Order order = null;
        try  {
            String sql = "SELECT * FROM [Order] WHERE ID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);

            rs = statement.executeQuery();
            if (rs.next()) {
                order = new Order();
                order.setId(rs.getInt("ID"));
                order.setUserId(rs.getInt("userId"));
                order.setFullname(rs.getString("fullname"));
                order.setAddress(rs.getString("address"));
                order.setPhone(rs.getString("phone"));
                order.setStatus(rs.getString("status"));
                order.setCreatedAt(rs.getDate("createdAt"));
                order.setTotalCost(getTotal(orderId));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }
    
    // Method to fetch ordered products by order ID
    public List<ProductDetail> getOrderedProductsByOrderId(int orderId) {
        List<ProductDetail> orderedProducts = new ArrayList<>();
        try {
            String sql = "SELECT [ProductDetailID], [quantity] " +
                         "FROM [OrderDetail] od " +
                         "WHERE od.OrderID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ProductDetail orderedProduct = new ProductDAO().getProductDetailById(rs.getInt(1));
                orderedProduct.setBuyQuantity(rs.getInt(2));
                orderedProducts.add(orderedProduct);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderedProducts;
    }
    
     // Method to cancel an order
    public boolean cancelOrder(int orderId) {
        boolean isCanceled = false;
        try {
            String sql = "UPDATE [Order] SET status = 'Canceled' WHERE ID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);

            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                isCanceled = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isCanceled;
    }
    
}
