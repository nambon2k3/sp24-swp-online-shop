/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Product;
import Model.ProductDetail;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

/**
 *
 * @author Legion
 */
public class ProductDAO extends DBContext {

    private Connection connection;

    public ProductDAO() {
        try {
            this.connection = getConnection();
        } catch (Exception e) {
            System.out.println("Connect failed");
        }
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT "
                + "p.ID AS ProductID, "
                + "p.Name AS ProductName, "
                + "c.Name AS CategoryName, "
                + "pd.ID AS ProductDetailID, "
                + "pd.ImageURL, "
                + "pd.Size, "
                + "pd.Color, "
                + "pd.Stock, "
                + "pd.price AS price, "
                + "pd.discount AS discount, "
                + "pd.CreatedAt AS ProductDetailCreatedAt, "
                + "pd.CreatedBy AS ProductDetailCreatedBy "
                + "FROM Product p "
                + "INNER JOIN Category c ON p.CategoryID = c.ID "
                + "INNER JOIN ProductDetail pd ON p.ID = pd.ProductID "
                + "WHERE p.IsDeleted = 0 AND pd.IsDeleted = 0 "
                + "ORDER BY p.ID ASC";

        try (PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setCategoryName(resultSet.getString("CategoryName"));

                ProductDetail productDetail = new ProductDetail();
                productDetail.setProductDetailId(resultSet.getInt("ProductDetailID"));
                productDetail.setImageURL(resultSet.getString("ImageURL"));
                productDetail.setSize(resultSet.getString("Size"));
                productDetail.setColor(resultSet.getString("Color"));
                productDetail.setStock(resultSet.getInt("Stock"));
                productDetail.setCreatedAt(resultSet.getTimestamp("ProductDetailCreatedAt"));
                productDetail.setCreatedBy(resultSet.getInt("ProductDetailCreatedBy"));
                productDetail.setPrice(resultSet.getDouble("price"));
                productDetail.setDiscount(resultSet.getInt("discount"));

                product.setProductDetail(productDetail);

                products.add(product);
            }
        } catch (SQLException ex) {
            System.out.println("getAllProducts: " + ex.getMessage());
        }

        return products;
    }

    public List<Product> getProductsByPage(int pageNumber, int pageSize) {
        List<Product> products = new ArrayList<>();
        int offset = (pageNumber - 1) * pageSize;

        String sql = "SELECT distinct\n"
                + "p.ID AS ProductID,\n"
                + "p.Name AS ProductName,\n"
                + "c.Name AS CategoryName\n"
                + "FROM Product p\n"
                + "INNER JOIN Category c ON p.CategoryID = c.ID\n"
                + "WHERE p.IsDeleted = 0\n"
                + "ORDER BY p.ID ASC\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, offset);
            statement.setInt(2, pageSize);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setCategoryName(resultSet.getString("CategoryName"));

                ProductDetail productDetail = getProductDetailByProductId(product.getProductId());
                product.setProductDetail(productDetail);
                products.add(product);
            }
        } catch (SQLException ex) {
            System.out.println("getProductsByPage: " + ex.getMessage());
        }

        return products;
    }

    public ProductDetail getProductDetailByProductId(int productId) {

        String sql = "SELECT "
                + "pd.ID AS ProductDetailID, "
                + "pd.ImageURL, "
                + "pd.Size, "
                + "pd.Color, "
                + "pd.Stock, "
                + "pd.price, "
                + "pd.discount, "
                + "pd.CreatedAt, "
                + "pd.CreatedBy "
                + "FROM ProductDetail pd "
                + "WHERE pd.ProductID = ? AND pd.IsDeleted = 0";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                ProductDetail productDetail = new ProductDetail();
                productDetail.setProductDetailId(resultSet.getInt("ProductDetailID"));
                productDetail.setImageURL(resultSet.getString("ImageURL"));
                productDetail.setSize(resultSet.getString("Size"));
                productDetail.setColor(resultSet.getString("Color"));
                productDetail.setStock(resultSet.getInt("Stock"));
                productDetail.setPrice(resultSet.getDouble("price"));
                productDetail.setDiscount(resultSet.getInt("discount"));
                productDetail.setCreatedAt(resultSet.getTimestamp("CreatedAt"));
                productDetail.setCreatedBy(resultSet.getInt("CreatedBy"));
                return productDetail;
            }
        } catch (SQLException ex) {
            System.out.println("getProductDetailsByProductId: " + ex.getMessage());
        }

        return new ProductDetail();
    }

    public int countTotalProducts() {
        int totalProducts = 0;

        String sql = "SELECT COUNT(*) AS TotalProducts FROM Product WHERE IsDeleted = 0";

        try (PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {

            if (resultSet.next()) {
                totalProducts = resultSet.getInt("TotalProducts");
            }
        } catch (SQLException ex) {
            System.out.println("countTotalProducts: " + ex.getMessage());
        }

        return totalProducts;
    }

    public List<ProductDetail> getProductDetailsByProductId(int productId) {
        List<ProductDetail> productDetails = new ArrayList<>();

        String sql = "SELECT "
                + "pd.ID AS ProductDetailID, "
                + "pd.ImageURL, "
                + "pd.Size, "
                + "pd.Color, "
                + "pd.Stock, "
                + "pd.price, "
                + "pd.discount, "
                + "pd.CreatedAt, "
                + "pd.CreatedBy "
                + "FROM ProductDetail pd "
                + "WHERE pd.ProductID = ? AND pd.IsDeleted = 0";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, productId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                ProductDetail productDetail = new ProductDetail();
                productDetail.setProductDetailId(resultSet.getInt("ProductDetailID"));
                productDetail.setImageURL(resultSet.getString("ImageURL"));
                productDetail.setSize(resultSet.getString("Size"));
                productDetail.setColor(resultSet.getString("Color"));
                productDetail.setStock(resultSet.getInt("Stock"));
                productDetail.setPrice(resultSet.getDouble("price"));
                productDetail.setDiscount(resultSet.getInt("discount"));
                productDetail.setCreatedAt(resultSet.getTimestamp("CreatedAt"));
                productDetail.setCreatedBy(resultSet.getInt("CreatedBy"));

                productDetails.add(productDetail);
            }
        } catch (SQLException ex) {
            System.out.println("getProductDetailsByProductId: " + ex.getMessage());
        }

        return productDetails;
    }

    public Product getProductById(int productId) {
        Product product = null;

        String productSql = "SELECT "
                + "p.ID AS ProductID, "
                + "p.Name AS ProductName, "
                + "c.Name AS CategoryName, "
                + "p.CreatedAt AS ProductCreatedAt, "
                + "p.description AS description, "
                + "p.CreatedBy AS ProductCreatedBy "
                + "FROM Product p "
                + "INNER JOIN Category c ON p.CategoryID = c.ID "
                + "WHERE p.ID = ? AND p.IsDeleted = 0";

        try (PreparedStatement productStatement = connection.prepareStatement(productSql)) {
            productStatement.setInt(1, productId);

            try (ResultSet resultSet = productStatement.executeQuery()) {
                if (resultSet.next()) {
                    product = new Product();
                    product.setProductId(resultSet.getInt("ProductID"));
                    product.setProductName(resultSet.getString("ProductName"));
                    product.setCategoryName(resultSet.getString("CategoryName"));
                    product.setCreatedAt(resultSet.getTimestamp("ProductCreatedAt"));
                    product.setCreatedBy(resultSet.getInt("ProductCreatedBy"));
                    product.setDescription(resultSet.getString("description"));
                    product.setProductDetail(getProductDetailByProductId(productId));
                }
            }
        } catch (SQLException ex) {
            System.out.println("getProductById: " + ex.getMessage());
        }

        return product;
    }

    public ProductDetail getProductDetailById(int productDetailId) {
        ProductDetail productDetail = null;

        String sql = "SELECT "
                + "ID AS ProductDetailID, "
                + "ProductID, "
                + "ImageURL, "
                + "Size, "
                + "Color, "
                + "price, "
                + "discount, "
                + "Stock, "
                + "CreatedAt, "
                + "CreatedBy "
                + "FROM ProductDetail "
                + "WHERE ID = ? AND IsDeleted = 0";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, productDetailId);

            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    productDetail = new ProductDetail();
                    productDetail.setProductDetailId(resultSet.getInt("ProductDetailID"));
                    productDetail.setProductId(resultSet.getInt("ProductID"));
                    productDetail.setImageURL(resultSet.getString("ImageURL"));
                    productDetail.setSize(resultSet.getString("Size"));
                    productDetail.setColor(resultSet.getString("Color"));
                    productDetail.setStock(resultSet.getInt("Stock"));
                    productDetail.setPrice(resultSet.getDouble("price"));
                    productDetail.setDiscount(resultSet.getInt("discount"));
                    productDetail.setCreatedAt(resultSet.getTimestamp("CreatedAt"));
                    productDetail.setCreatedBy(resultSet.getInt("CreatedBy"));
                }
            }
        } catch (SQLException ex) {
            System.out.println("getProductDetailById: " + ex.getMessage());
        }

        return productDetail;
    }

    public List<Product> getProductsByPage(int pageNumber, int pageSize, String searchQuery, String categoryId) {
        List<Product> products = new ArrayList<>();
        int offset = (pageNumber - 1) * pageSize;
        String sql = "SELECT p.ID as productId, p.Name as productName, p.CategoryID, c.Name as categoryName, "
                + "p.IsDeleted, p.CreatedAt, p.CreatedBy, p.description "
                + "FROM Product p "
                + "JOIN Category c ON p.CategoryID = c.ID "
                + "WHERE p.IsDeleted = 0 AND c.IsDeleted = 0 "
                + "AND (p.Name LIKE ? OR ? IS NULL) "
                + "AND (p.CategoryID = ? OR ? IS NULL) Order by p.ID "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(2, searchQuery != null && !searchQuery.isBlank() ? "%" + searchQuery + "%" : null);
            statement.setString(1, "%" + searchQuery + "%");
            statement.setString(4, categoryId != null && !categoryId.isBlank() ? categoryId : null);
            statement.setString(3, categoryId);
            statement.setInt(6, pageSize);
            statement.setInt(5, offset);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Product product = new Product();
                    product.setProductId(resultSet.getInt("ProductID"));
                    product.setProductName(resultSet.getString("ProductName"));
                    product.setCategoryName(resultSet.getString("CategoryName"));
                    product.setCreatedAt(resultSet.getTimestamp("CreatedAt"));
                    product.setCreatedBy(resultSet.getInt("CreatedBy"));
                    product.setDescription(resultSet.getString("description"));
                    product.setProductDetail(getProductDetailByProductId(product.getProductId()));
                    product.setProductDetail(getProductDetailByProductId(product.getProductId()));
                    product.setListProductDetail(getListProductDetailsByProductId(product.getProductId()));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public List<ProductDetail> getListProductDetailsByProductId(int productId) {
        List<ProductDetail> productDetails = new ArrayList<>();
        String query = "SELECT [ID], [ProductID], [ImageURL], [Size], [Color], [Stock], [IsDeleted], [CreatedAt], [CreatedBy], [price], [discount] "
                + "FROM [swp-online-shop].[dbo].[ProductDetail] WHERE [ProductID] = ? and IsDeleted != 1";

        try (
                PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, productId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductDetail productDetail = new ProductDetail();
                    productDetail.setProductDetailId(rs.getInt("ID"));
                    productDetail.setProductId(rs.getInt("ProductID"));
                    productDetail.setImageURL(rs.getString("ImageURL"));
                    productDetail.setSize(rs.getString("Size"));
                    productDetail.setColor(rs.getString("Color"));
                    productDetail.setStock(rs.getInt("Stock"));
                    productDetail.setCreatedAt(rs.getTimestamp("CreatedAt"));
                    productDetail.setCreatedBy(rs.getInt("CreatedBy"));
                    productDetail.setPrice(rs.getDouble("price"));
                    productDetail.setDiscount(rs.getInt("discount"));
                    productDetails.add(productDetail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productDetails;
    }

    public int countTotalProducts(String searchQuery, String categoryId) {
        int total = 0;
        String sql = "SELECT COUNT(*) FROM Product p "
                + "JOIN Category c ON p.CategoryID = c.ID "
                + "WHERE p.IsDeleted = 0 AND c.IsDeleted = 0 "
                + "AND (p.Name LIKE ? OR ? IS NULL) "
                + "AND (p.CategoryID = ? OR ? IS NULL);";

        try (PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(2, searchQuery != null && !searchQuery.isBlank() ? "%" + searchQuery + "%" : null);
            statement.setString(1, "%" + searchQuery + "%");
            statement.setString(4, categoryId != null && !categoryId.isBlank() ? categoryId : null);
            statement.setString(3, categoryId);

            try (ResultSet rs = statement.executeQuery()) {
                if (rs.next()) {
                    total = rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return total;
    }

    public List<Product> getThreeLastestProducts() {
        List<Product> products = new ArrayList<>();

        String sql = "SELECT TOP 3 "
                + "p.ID AS ProductID, "
                + "p.Name AS ProductName, "
                + "c.Name AS CategoryName, "
                + "pd.ID AS ProductDetailID, "
                + "pd.ImageURL, "
                + "pd.Size, "
                + "pd.Color, "
                + "pd.Stock, "
                + "pd.price AS price, "
                + "pd.discount AS discount, "
                + "pd.CreatedAt AS ProductDetailCreatedAt, "
                + "pd.CreatedBy AS ProductDetailCreatedBy "
                + "FROM Product p "
                + "INNER JOIN Category c ON p.CategoryID = c.ID "
                + "INNER JOIN ProductDetail pd ON p.ID = pd.ProductID "
                + "WHERE p.IsDeleted = 0 AND pd.IsDeleted = 0 "
                + "ORDER BY p.CreatedAt ASC";

        try (PreparedStatement statement = connection.prepareStatement(sql); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("ProductID"));
                product.setProductName(resultSet.getString("ProductName"));
                product.setCategoryName(resultSet.getString("CategoryName"));

                ProductDetail productDetail = new ProductDetail();
                productDetail.setProductDetailId(resultSet.getInt("ProductDetailID"));
                productDetail.setImageURL(resultSet.getString("ImageURL"));
                productDetail.setSize(resultSet.getString("Size"));
                productDetail.setColor(resultSet.getString("Color"));
                productDetail.setStock(resultSet.getInt("Stock"));
                productDetail.setCreatedAt(resultSet.getTimestamp("ProductDetailCreatedAt"));
                productDetail.setCreatedBy(resultSet.getInt("ProductDetailCreatedBy"));
                productDetail.setPrice(resultSet.getDouble("price"));
                productDetail.setDiscount(resultSet.getInt("discount"));

                product.setProductDetail(productDetail);

                products.add(product);
            }
        } catch (SQLException ex) {
            System.out.println("getAllProducts: " + ex.getMessage());
        }

        return products;
    }

    public void updateQuantity(int orderId, int mode) {
        String GET_PRODUCT_DETAIL_IDS_BY_ORDER_ID_SQL
                = "SELECT ProductDetailID, [quantity] "
                + "FROM [swp-online-shop].[dbo].[OrderDetail] "
                + "WHERE OrderID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(GET_PRODUCT_DETAIL_IDS_BY_ORDER_ID_SQL)) {

            preparedStatement.setInt(1, orderId);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    updateProductDetailQuantity(resultSet.getInt(1), resultSet.getInt(2) * mode);
                }
            }
        } catch (SQLException e) {
            System.out.println("getProductDetailIDsByOrderID: " + e.getMessage());
        }

    }
    
    public void updateProductDetailQuantity(int productDetailId, int quantity) {
        String UPDATE_PRODUCT_DETAIL_QUANTITY_SQL = 
        "UPDATE ProductDetail " +
        "SET [Stock] = [Stock] - ? " +
        "WHERE ID = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PRODUCT_DETAIL_QUANTITY_SQL)) {

            preparedStatement.setInt(1, quantity);
            preparedStatement.setInt(2, productDetailId);

            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            System.out.println("updateProductDetailQuantity: " + e.getMessage());
        }
    }
    
}
