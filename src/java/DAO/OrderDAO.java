/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import Model.OrderDetail;
import Model.ProductDetail;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.Statement;
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

    public List<Order> getAllOrders() {
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
                order.setNotes(rs.getString("notes"));
                orders.add(order);
            }

            return orders;
        } catch (SQLException ex) {
            System.out.println("getAllOrders: " + ex.getMessage());
        }
        return orders;
    }

    public double getTotal(int orderId) {
        String sql = "SELECT SUM(pd.price * od.quantity) AS total_cost "
                + "FROM [swp-online-shop].[dbo].[Order] o "
                + "INNER JOIN [swp-online-shop].[dbo].[OrderDetail] od ON o.ID = od.OrderID "
                + "INNER JOIN [swp-online-shop].[dbo].[ProductDetail] pd ON od.[ProductDetailID] = pd.ID "
                + "WHERE o.ID = ? "
                + "GROUP BY o.ID";

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
                order.setNotes(rs.getString("notes"));
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
        try {
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
                order.setNotes(rs.getString("notes"));
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
            String sql = "SELECT [ProductDetailID], [quantity], [ID] "
                    + "FROM [OrderDetail] od "
                    + "WHERE od.OrderID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, orderId);

            ResultSet rs = statement.executeQuery();
            while (rs.next()) {
                ProductDetail orderedProduct = new ProductDAO().getProductDetailById(rs.getInt(1));
                orderedProduct.setBuyQuantity(rs.getInt(2));
                orderedProduct.setOrderDetailId(rs.getInt(3));
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
                new ProductDAO().updateQuantity(orderId, -1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return isCanceled;
    }

    public boolean confirmOrder(int orderId) {
        boolean isCanceled = false;
        try {
            String sql = "UPDATE [Order] SET status = 'Received' WHERE ID = ?";
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

    public int createOrder(Order order) {
        int orderId = 0;
        String INSERT_ORDER_SQL = "INSERT INTO [Order] (userId, fullname, address, phone, status, isDeleted, createdBy, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER_SQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setString(2, order.getFullname());
            preparedStatement.setString(3, order.getAddress());
            preparedStatement.setString(4, order.getPhone());
            preparedStatement.setString(5, "Created");
            preparedStatement.setBoolean(6, false);
            preparedStatement.setInt(7, order.getUserId());
            preparedStatement.setString(8, order.getNotes());
            preparedStatement.executeUpdate();

            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    orderId = generatedKeys.getInt(1);
                }
            }

        } catch (SQLException e) {
            System.out.println("createOrder: " + e.getMessage());
        }
        return orderId;
    }

    public void createOrderDetail(OrderDetail orderDetail) {
        String INSERT_ORDER_DETAIL_SQL = "INSERT INTO [OrderDetail] (orderId, [ProductDetailID], quantity, [CreatedBy]) VALUES (?, ?, ?, ?)";
        try (
                PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER_DETAIL_SQL)) {
            preparedStatement.setInt(1, orderDetail.getOrderId());
            preparedStatement.setInt(2, orderDetail.getProductDetailId());
            preparedStatement.setInt(3, orderDetail.getQuantity());
            preparedStatement.setInt(4, orderDetail.getCreatedBy());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("createOrderDetail: " + e.getMessage());
        }
    }

    public void updateOrder(String status, int orderId) throws SQLException {
        String UPDATE_ORDER_SQL = "UPDATE [Order] SET status = ? WHERE id = ?";
        try (
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_SQL)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, orderId);
            if(status.equalsIgnoreCase("Paided")) {
                new ProductDAO().updateQuantity(orderId, 1);
            }

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows == 0) {
                throw new SQLException("Updating order failed, no rows affected.");
            }
        } catch (SQLException e) {
            throw new SQLException("Error while updating the order", e);
        }
    }

    

    public List<OrderDetail> getOrderDetailsNotFeedbackedByUserId(int userId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String GET_ORDER_DETAILS_NOT_FEEDBACKED_SQL
                = "SELECT od.ID, od.OrderID, od.ProductDetailID, od.IsDeleted, od.CreatedAt, od.CreatedBy, od.quantity "
                + "FROM [swp-online-shop].[dbo].[OrderDetail] od "
                + "LEFT JOIN [swp-online-shop].[dbo].[Feedback] fb ON od.ID = fb.OrderDetailID "
                + "WHERE fb.OrderDetailID IS NULL "
                + "AND od.OrderID IN (SELECT o.ID FROM [swp-online-shop].[dbo].[Order] o WHERE o.UserID = ?) "
                + "AND od.IsDeleted = 0";
        try (
                PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_DETAILS_NOT_FEEDBACKED_SQL)) {

            preparedStatement.setInt(1, userId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setId(resultSet.getInt("ID"));
                    orderDetail.setOrderId(resultSet.getInt("OrderID"));
                    orderDetail.setProductDetailId(resultSet.getInt("ProductDetailID"));
                    orderDetail.setIsDeleted(resultSet.getBoolean("IsDeleted"));
                    orderDetail.setCreatedAt(resultSet.getDate("CreatedAt"));
                    orderDetail.setCreatedBy(resultSet.getInt("CreatedBy"));
                    orderDetail.setQuantity(resultSet.getInt("quantity"));
                    orderDetail.setProductDetail(new ProductDAO().getProductDetailById(orderDetail.getProductDetailId()));
                    orderDetails.add(orderDetail);
                }
            }
        } catch (SQLException e) {
            System.out.println("getOrderDetailsNotFeedbackedByUserId: " + e.getMessage());
        }

        return orderDetails;
    }

    public OrderDetail getOrderDetailById(int id) {
        OrderDetail orderDetail = null;
        String GET_ORDER_DETAIL_BY_ID_SQL
                = "SELECT ID, OrderID, ProductDetailID, IsDeleted, CreatedAt, CreatedBy, quantity "
                + "FROM [swp-online-shop].[dbo].[OrderDetail] WHERE ID = ?";
        try (
                PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_DETAIL_BY_ID_SQL)) {

            preparedStatement.setInt(1, id);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    orderDetail = new OrderDetail();
                    orderDetail.setId(resultSet.getInt("ID"));
                    orderDetail.setOrderId(resultSet.getInt("OrderID"));
                    orderDetail.setProductDetailId(resultSet.getInt("ProductDetailID"));
                    orderDetail.setIsDeleted(resultSet.getBoolean("IsDeleted"));
                    orderDetail.setCreatedAt(resultSet.getDate("CreatedAt"));
                    orderDetail.setCreatedBy(resultSet.getInt("CreatedBy"));
                    orderDetail.setQuantity(resultSet.getInt("quantity"));
                    orderDetail.setProductDetail(new ProductDAO().getProductDetailById(orderDetail.getProductDetailId()));
                }
            }
        } catch (SQLException e) {
            System.out.println("getOrderDetailById: " + e.getMessage());
        }

        return orderDetail;
    }

}
