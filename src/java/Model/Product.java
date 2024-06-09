/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Timestamp;
import java.util.List;

public class Product {
    private int productId;
    private String productName;
    private String categoryName;
    private String description;
    private ProductDetail productDetail;
    private Timestamp createdAt;
    private int createdBy;
    private List<ProductDetail> listProductDetail;
    // Getters and setters
    public int getProductId() {
        return productId;
    }

    public List<ProductDetail> getListProductDetail() {
        return listProductDetail;
    }

    public void setListProductDetail(List<ProductDetail> listProductDetail) {
        this.listProductDetail = listProductDetail;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public ProductDetail getProductDetail() {
        return productDetail;
    }

    public void setProductDetail(ProductDetail productDetail) {
        this.productDetail = productDetail;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "Product{" + "productId=" + productId + ", productName=" + productName + ", categoryName=" + categoryName + ", description=" + description + ", productDetail=" + productDetail + ", createdAt=" + createdAt + ", createdBy=" + createdBy + '}';
    }
    
    

  
}
