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
}
