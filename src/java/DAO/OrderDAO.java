/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Order;
import Model.OrderDetail;
import Model.ProductDetail;
import Model.Staff;
import Model.User;
import jakarta.servlet.ServletException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.sql.Statement;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
        String sql = "SELECT SUM(pd.price * (100 - pd.discount)/100 * od.quantity) AS total_cost "
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
    public List<Order> getOrdersByPage(int currentPage, int ordersPerPage, int userId, String orderDate, String orderTime, String orderStatus) {
        List<Order> orders = new ArrayList<>();
        int start = (currentPage - 1) * ordersPerPage;

        try {
            String sql = "SELECT * FROM [dbo].[Order] WHERE 1=1 ";

            if (orderDate != null && !orderDate.isEmpty()) {
                sql += " AND CONVERT(date, [CreatedAt]) = ?";
            }
            if (orderTime != null && !orderTime.isEmpty()) {
                sql += " AND CONVERT(time, [CreatedAt]) >= ?";
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                sql += " AND status = ?";
            }

            sql += " AND [UserID] = ? ORDER BY createdAt OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

            PreparedStatement statement = connection.prepareStatement(sql);
            int index = 1;
            if (orderDate != null && !orderDate.isEmpty()) {
                statement.setString(index++, orderDate);
            }
            if (orderTime != null && !orderTime.isEmpty()) {
                statement.setString(index++, orderTime);
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                statement.setString(index++, orderStatus);
            }
            statement.setInt(index++, userId);
            statement.setInt(index++, start);
            statement.setInt(index, ordersPerPage);

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

    public boolean autoCanceled() {
        try {
            String UPDATE_ORDER_STATUS_SQL
                    = "UPDATE [dbo].[Order] "
                    + "SET [Status] = 'canceled' "
                    + "WHERE [Status] == 'Not yet' "
                    + "AND [CreatedAt] < DATEADD(DAY, -1, GETDATE())";
            // Execute the update statement
            PreparedStatement pstmt = connection.prepareStatement(UPDATE_ORDER_STATUS_SQL);
            int rowsUpdated = pstmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println("autoCanceled: " + e.getMessage());
        } 
        return false;
    }

    // Method to get the total number of orders
    public int getTotalOrderCount(int userId, String orderDate, String orderTime, String orderStatus) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM [dbo].[Order] WHERE [UserID] = ?";
            if (orderDate != null && !orderDate.isEmpty()) {
                sql += " AND CONVERT(date, [CreatedAt]) = ?";
            }
            if (orderTime != null && !orderTime.isEmpty()) {
                sql += " AND CONVERT(time, [CreatedAt]) >= ?";
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                sql += " AND status = ?";
            }

            PreparedStatement statement = connection.prepareStatement(sql);
            int index = 2;
            statement.setInt(1, userId);
            if (orderDate != null && !orderDate.isEmpty()) {
                statement.setString(index++, orderDate);
            }
            if (orderTime != null && !orderTime.isEmpty()) {
                statement.setString(index++, orderTime);
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                statement.setString(index++, orderStatus);
            }

            ResultSet rs = statement.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    public List<Order> getOrdersByPage(int currentPage, int ordersPerPage, String startDate, String endDate, String salesperson, String orderStatus, Staff staff) {
        List<Order> orders = new ArrayList<>();
        int start = (currentPage - 1) * ordersPerPage;

        try {
            StringBuilder query = new StringBuilder(
                    "SELECT * "
                    + "FROM [Order] o "
                    + "JOIN Staff s on s.ID = o.CreatedBy"
                    + " WHERE o.CreatedAt BETWEEN ? AND ?");

            if (staff.getRole() == 3) {
                query.append(" AND o.CreatedBy = ");
                query.append(String.valueOf(staff.getId()));
            }

            if (staff.getRole() == 6) {
                query.append(" AND o.Status IN  ");
                query.append(String.valueOf("('Approved', 'Shipping', 'Failed')"));
            }

            if (salesperson != null && !salesperson.isEmpty()) {
                String condition = " AND s.[fullname] LIKE '%" + salesperson + "%' ";
                query.append(condition);
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                query.append(" AND o.Status = ?");
            }

            query.append(" ORDER BY o.CreatedAt DESC "
                    + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

            PreparedStatement stmt = connection.prepareStatement(query.toString());
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);

            int paramIndex = 3;
            if (orderStatus != null && !orderStatus.isEmpty()) {
                stmt.setString(paramIndex++, orderStatus);
            }

            stmt.setInt(paramIndex++, start);
            stmt.setInt(paramIndex++, ordersPerPage);

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Extract data from ResultSet
                int id = rs.getInt("ID");
                int userId = rs.getInt("userId");
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
        } catch (SQLException ex) {
            System.out.println("getOrdersByPage: " + ex.getMessage());
        }

        return orders;
    }

    public int getTotalOrderCount(String startDate, String endDate, String salesperson, String orderStatus, Staff staff) {
        int totalOrders = 0;

        try {
            StringBuilder query = new StringBuilder(
                    "SELECT COUNT(*) as totalOrders "
                    + "FROM [Order] o "
                    + "JOIN Staff s on s.ID = o.CreatedBy"
                    + " WHERE o.CreatedAt BETWEEN ? AND ?");

            if (staff.getRole() != 4) {
                query.append(" AND o.CreatedBy = ");
                query.append(String.valueOf(staff.getId()));
            }

            if (salesperson != null && !salesperson.isEmpty()) {
                String condition = " AND s.[fullname] LIKE '%" + salesperson + "%' ";
                query.append(condition);
            }
            if (orderStatus != null && !orderStatus.isEmpty()) {
                query.append(" AND o.Status = ?");
            }

            PreparedStatement stmt = connection.prepareStatement(query.toString());
            stmt.setString(1, startDate);
            stmt.setString(2, endDate);

            int paramIndex = 3;
            if (orderStatus != null && !orderStatus.isEmpty()) {
                stmt.setString(paramIndex++, orderStatus);
            }

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                totalOrders = rs.getInt("totalOrders");
            }
        } catch (SQLException ex) {
            System.out.println("getTotalOrderCount: " + ex.getMessage());
        }

        return totalOrders;
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
                order.setStatus(rs.getString("Status"));
                order.setCreatedAt(rs.getDate("createdAt"));
                order.setCreatedBy(rs.getInt("createdBy"));
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
            String sql = "UPDATE [Order] SET status = 'Request cancel' WHERE ID = ?";
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

    public boolean shippingOrder(int orderId, String status) {
        boolean isCanceled = false;
        try {
            String sql = "UPDATE [Order] SET status = ? WHERE ID = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1, status);
            statement.setInt(2, orderId);

            int rowsUpdated = statement.executeUpdate();
            if (rowsUpdated > 0) {
                isCanceled = true;
            }
        } catch (SQLException e) {
            System.out.println("shippingOrder: " + e.getMessage());
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

    public int getSaleIdWithLeastOrder() {
        String SQL = "WITH StaffOrderCounts AS (\n"
                + "    SELECT \n"
                + "        s.ID AS StaffID,\n"
                + "        s.Fullname,\n"
                + "        s.Email,\n"
                + "        COUNT(o.ID) AS OrderCount\n"
                + "    FROM \n"
                + "        [swp-online-shop].[dbo].[Staff] s\n"
                + "    LEFT JOIN \n"
                + "        [swp-online-shop].[dbo].[Order] o\n"
                + "    ON \n"
                + "        s.ID = o.CreatedBy\n"
                + "    WHERE \n"
                + "        s.Role = 3\n"
                + "    GROUP BY \n"
                + "        s.ID, s.Fullname, s.Email\n"
                + ")\n"
                + "SELECT TOP 1\n"
                + "    StaffID,\n"
                + "    Fullname,\n"
                + "    Email,\n"
                + "    OrderCount\n"
                + "FROM \n"
                + "    StaffOrderCounts\n"
                + "ORDER BY \n"
                + "    OrderCount ASC;";
        try {
            PreparedStatement ps = connection.prepareStatement(SQL);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("getSaleIdWithLeastOrder: " + e.getMessage());
        }
        return 4;
    }

    public int createOrder(Order order) {
        int orderId = 0;
        String INSERT_ORDER_SQL = "INSERT INTO [Order] (userId, fullname, address, phone, status, isDeleted, createdBy, notes) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ORDER_SQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, order.getUserId());
            preparedStatement.setString(2, order.getFullname());
            preparedStatement.setString(3, order.getAddress());
            preparedStatement.setString(4, order.getPhone());
            preparedStatement.setString(5, order.getStatus());
            preparedStatement.setBoolean(6, false);
            preparedStatement.setInt(7, getSaleIdWithLeastOrder());
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
            if (status.equalsIgnoreCase("Submitted")) {
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

    public boolean updateOrderStatus(String status, int orderId) {
        String UPDATE_ORDER_SQL = "UPDATE [Order] SET status = ? WHERE id = ?";
        boolean isSuccess = false;
        try (
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_SQL)) {

            preparedStatement.setString(1, status);
            preparedStatement.setInt(2, orderId);

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            System.out.println("updateOrderStatus: " + e.getMessage());
        }

        return isSuccess;
    }

    public boolean updateOrderStatus(String status, int orderId, String notes, String saleId) {
        String UPDATE_ORDER_SQL = "UPDATE [Order] SET status = ?, notes = ?, createdBy = ? WHERE id = ?";
        boolean isSuccess = false;
        try (
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_SQL)) {

            preparedStatement.setString(1, status);
            preparedStatement.setString(2, notes);
            preparedStatement.setString(3, saleId);
            preparedStatement.setInt(4, orderId);

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            System.out.println("updateOrderStatus: " + e.getMessage());
        }

        return isSuccess;
    }

    public boolean updateOrderSale(String saleId, int orderId) {
        String UPDATE_ORDER_SQL = "UPDATE [Order] SET [CreatedBy] = ? WHERE id = ?";
        boolean isSuccess = false;
        try (
                PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ORDER_SQL)) {

            preparedStatement.setString(1, saleId);
            preparedStatement.setInt(2, orderId);

            int affectedRows = preparedStatement.executeUpdate();

            if (affectedRows > 0) {
                isSuccess = true;
            }
        } catch (SQLException e) {
            System.out.println("updateOrderStatus: " + e.getMessage());
        }

        return isSuccess;
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
    
    public boolean isFeedbacked(int orderId, int productDetailId) {
        String GET_ORDER_DETAILS_NOT_FEEDBACKED_SQL
                = "SELECT *\n" +
"                 FROM [swp-online-shop].[dbo].[OrderDetail] od \n" +
"                 LEFT JOIN [swp-online-shop].[dbo].[Feedback] fb ON od.ID = fb.OrderDetailID \n" +
"                 WHERE fb.OrderDetailID IS NULL \n" +
"                 AND od.OrderID = ? and od.ProductDetailID = ?\n" +
"                 AND od.IsDeleted = 0";
        try (
                PreparedStatement preparedStatement = connection.prepareStatement(GET_ORDER_DETAILS_NOT_FEEDBACKED_SQL)) {

            preparedStatement.setInt(1, orderId);
            preparedStatement.setInt(2, productDetailId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    return true;
                }
            }
        } catch (SQLException e) {
            System.out.println("getOrderDetailsNotFeedbackedByUserId: " + e.getMessage());
        }

        return false;
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

    public Map<String, Object> getOrderTrends(String startDate, String endDate, String salesperson) {
        Map<String, Integer> totalOrders = new HashMap<>();
        Map<String, Integer> successfulOrders = new HashMap<>();
        Map<String, Double> revenue = new HashMap<>();

        try {
            String orderQuery = "SELECT o.CreatedAt, o.Status, od.quantity, p.price "
                    + "FROM [Order] o "
                    + "JOIN [OrderDetail] od ON o.ID = od.OrderID "
                    + "JOIN [ProductDetail] p ON od.ProductDetailID = p.ID "
                    + "WHERE o.CreatedAt BETWEEN ? AND ?";

            if (salesperson != null && !salesperson.isEmpty()) {
                orderQuery += " AND o.CreatedBy = ?";
            }

            PreparedStatement orderStmt = connection.prepareStatement(orderQuery);
            orderStmt.setString(1, startDate);
            orderStmt.setString(2, endDate);

            if (salesperson != null && !salesperson.isEmpty()) {
                orderStmt.setString(3, salesperson);
            }

            ResultSet rs = orderStmt.executeQuery();

            while (rs.next()) {
                String date = rs.getString("CreatedAt").split(" ")[0];
                boolean isSuccess = rs.getString("Status").equalsIgnoreCase("Success");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");

                totalOrders.put(date, totalOrders.getOrDefault(date, 0) + 1);
                if (isSuccess) {
                    successfulOrders.put(date, successfulOrders.getOrDefault(date, 0) + 1);
                }
                revenue.put(date, revenue.getOrDefault(date, 0.0) + (quantity * price));
            }
        } catch (SQLException ex) {
            System.out.println("getOrderTrends: " + ex.getMessage());
        }

        Map<String, Object> trends = new HashMap<>();
        System.out.println(totalOrders);
        System.out.println(successfulOrders);
        System.out.println(revenue);
        trends.put("totalOrders", totalOrders);
        trends.put("successfulOrders", successfulOrders);
        trends.put("revenue", revenue);

        return trends;
    }

    public List<Staff> getAllSale() {
        String sql = "select distinct [ID] from [dbo].[Staff] where role = 3";

        List<Staff> staffs = new ArrayList<>();
        try {
            stmt = connection.prepareStatement(sql);
            rs = stmt.executeQuery();
            while (rs.next()) {
                Staff staff = new StaffDAO().getStaffById(rs.getInt(1));
                staffs.add(staff);
            }
        } catch (SQLException e) {
            System.out.println("getAllSale: " + e.getMessage());
        }
        return staffs;
    }

}
