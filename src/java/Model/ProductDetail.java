/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import java.sql.*;

/**
 *
 * @author Legion
 */
public class ProductDetail {
    private int productDetailId;
    private int productId;
    private String imageURL;
    private String size;
    private String color;
    private int stock;
    private double price;
    private int discount;
    private Timestamp createdAt;
    private int createdBy;
    private int orderDetailId;

    public void setOrderDetailId(int orderDetailId) {
        this.orderDetailId = orderDetailId;
    }

    public int getOrderDetailId() {
        return orderDetailId;
    }
    
    
    
    private int buyQuantity;
    
    public int getProductId() {
        return productId;
    }

    public int getBuyQuantity() {
        return buyQuantity;
    }

    public void setBuyQuantity(int buyQuantity) {
        this.buyQuantity = buyQuantity;
    }

    // Getters and setters
    public void setProductId(int productId) {    
        this.productId = productId;
    }

    public int getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(int createdBy) {
        this.createdBy = createdBy;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }
    
    public String getProductName() {
        return new ProductDAO().getProductById(productId).getProductName();
    }
    
    public String getCateogryName() {
        return new ProductDAO().getProductById(productId).getCategoryName();
    }
    
    public Product getProduct() {
        return new ProductDAO().getProductByIdDcm(productId);
    }

    @Override
    public String toString() {
        return "ProductDetail{" + "productDetailId=" + productDetailId + ", imageURL=" + imageURL + ", size=" + size + ", color=" + color + ", stock=" + stock + ", price=" + price + ", discount=" + discount + ", createdAt=" + createdAt + ", createdBy=" + createdBy + '}';
    }
    
    
}