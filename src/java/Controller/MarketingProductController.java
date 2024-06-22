package Controller;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import Model.Product;
import Model.ProductDetail;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "MarketingProductController", urlPatterns = {"/marketing/product"})
public class MarketingProductController extends HttpServlet  {
    
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Pagination parameters
        int pageNumber = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        int pageSize = 5;

        // Filter parameters
        String name = request.getParameter("name");
        int category = Integer.parseInt(request.getParameter("category"));
        String isDeletedString = request.getParameter("isDeleted");
        Boolean isDeleted = (isDeletedString == null || isDeletedString.isEmpty()) ? null : Boolean.valueOf(isDeletedString);

        // Perform filtering based on the provided parameters
        List<Product> filteredProductList = productDAO.getFilteredProducts(name, category, isDeleted, pageNumber, pageSize);
        int totalProducts = productDAO.getFilteredProducts(name, category, isDeleted);
        int totalPages = (int) Math.ceil((double) totalProducts / pageSize);

        // Forward the filtered product list and pagination parameters to the JSP
        request.setAttribute("productList", filteredProductList);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("name", name);
        request.setAttribute("category", category);
        request.setAttribute("isDeletedString", isDeletedString);
        request.setAttribute("categories", new CategoryDAO().getCategories());

        request.getRequestDispatcher("../marketing-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Determine action (add or update)
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    addProduct(request, response);
                    break;
                case "update":
                    updateProduct(request, response);
                    break;
            }
        } else {
            // Handle missing action parameter
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void addProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve product data from request parameters
        String productName = request.getParameter("productName");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        
        // Create a new Product object
        Product newProduct = new Product();
        newProduct.setProductName(productName);
        newProduct.setCategoryId(categoryId);
        newProduct.setDescription(description);
        newProduct.setCreatedBy(1);
        newProduct.setIsDeleted(Boolean.FALSE);

        // Add the product to the database
        int productId = productDAO.addProduct(newProduct);
        
        ProductDetail productDetail = new ProductDetail();
        productDetail.setProductId(productId);
        productDetail.setImageURL(imageUrl);
        
        new ProductDAO().addProductDetail(productDetail);

        if (productId != -1) {
            // Redirect to product list page after successful addition
            response.sendRedirect("product?success");
        } else {
            response.sendRedirect("product?fail");
        }
    }

    private void updateProduct(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve product data from request parameters
        int productId = Integer.parseInt(request.getParameter("productId"));
        String productName = request.getParameter("productName");
        String categoryName = request.getParameter("categoryName");
        String description = request.getParameter("description");
        boolean isDeleted = Boolean.parseBoolean(request.getParameter("isDeleted"));
        int createdBy = Integer.parseInt(request.getParameter("createdBy"));
        String imageUrl = request.getParameter("imageUrl");

        // Create a Product object with the updated data
        Product product = new Product();
        product.setProductId(productId);
        product.setProductName(productName);
        product.setCategoryName(categoryName);
        product.setDescription(description);
        product.setIsDeleted(isDeleted);
        
        ProductDetail productDetail = new ProductDAO().getProductDetailByProductId(productId);
        productDetail.setImageURL(imageUrl);
        new ProductDAO().updateProductDetail(productDetail);

        // Update the product in the database
        boolean success = productDAO.updateProduct(product);

        if (success) {
            // Redirect to product list page after successful update
            response.sendRedirect("product?success");
        } else {
            // Handle update failure
            response.sendRedirect("product?fail");
        }
    }
    
}
