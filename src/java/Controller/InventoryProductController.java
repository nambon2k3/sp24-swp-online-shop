/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CategoryDAO;
import DAO.ProductDAO;
import Model.Category;
import Model.Product;
import Model.ProductDetail;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Legion
 */
@WebServlet(name="InventoryProductController", urlPatterns={"/inventory/list-product"})
public class InventoryProductController extends HttpServlet {
   
    private ProductDAO productDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Pagination parameters
        String pageParam = request.getParameter("page");
        String searchQuery = request.getParameter("searchQuery");
        String categoryId = request.getParameter("categoryId");
        String minPriceParam = request.getParameter("minPrice");
        String maxPriceParam = request.getParameter("maxPrice");
        String color = request.getParameter("color");
        String size = request.getParameter("size");

        int pageNumber = pageParam == null ? 1 : Integer.parseInt(pageParam);
        int pageSize = 12;

        Double minPrice = minPriceParam == null || minPriceParam.isEmpty() ? null : Double.parseDouble(minPriceParam);
        Double maxPrice = maxPriceParam == null || maxPriceParam.isEmpty() ? null : Double.parseDouble(maxPriceParam);

        List<Product> products = new ProductDAO().getProductsByPage(pageNumber, pageSize, searchQuery, categoryId, minPrice, maxPrice, color, size);
        int total = new ProductDAO().countTotalProducts(searchQuery, categoryId, minPrice, maxPrice, color, size);

        int endPage = total % pageSize == 0 ? total / pageSize : total / pageSize + 1;
        List<Category> categories = new CategoryDAO().getCategories();
        List<String> colors = new ProductDAO().getAvailableColors();
        List<String> sizes = new ProductDAO().getAvailableSizes();

        // Forward the filtered product list and pagination parameters to the JSP
        request.setAttribute("productList", products);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("categories", categories);
        request.setAttribute("totalPages", endPage);
        request.setAttribute("colors", colors);
        request.setAttribute("sizes", sizes);
        request.setAttribute("searchQuery", searchQuery);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("minPrice", minPrice);
        request.setAttribute("maxPrice", maxPrice);
        request.setAttribute("selectedColor", color);
        request.setAttribute("selectedSize", size);
        request.setAttribute("categories", new CategoryDAO().getCategories());

        request.getRequestDispatcher("../inventory-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve product data from request parameters
        int productDetailId = Integer.parseInt(request.getParameter("productDetailId"));
        int hold = Integer.parseInt(request.getParameter("hold"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        float importPrice = Float.parseFloat(request.getParameter("importPrice"));

        
        ProductDetail productDetail = new ProductDetail();
        productDetail.setProductDetailId(productDetailId);
        productDetail.setHold(hold);
        productDetail.setImportPrice(importPrice);
        productDetail.setStock(quantity);
        
        boolean success= new ProductDAO().updateProductDetailInventory(productDetail);
        System.out.println(success);
        if (success) {
            // Redirect to product list page after successful update
            response.sendRedirect("list-product?success");
        } else {
            // Handle update failure
            response.sendRedirect("list-product?fail");
        }
    }

}
