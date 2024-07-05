/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.CartDAO;
import DAO.PostDAO;
import DAO.ProductDAO;
import DAO.SettingDAO;
import Model.Cart;
import Model.Category;
import Model.Product;
import Model.Setting;
import Model.User;
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
@WebServlet(name="TranferCommitController", urlPatterns={"/public/tranfer-commit"})
public class TranferCommitController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        int userId = user.getId();
        int page = 1;
        int PAGE_SIZE = 5;
        String searchQuery = request.getParameter("searchQuery");
        String category = request.getParameter("category");

        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }

        CartDAO cartDAO = new CartDAO();
        ProductDAO productDAO = new ProductDAO();

        List<Cart> cartItemsFull = cartDAO.getAllCarts(userId);
        List<Cart> cartItems = cartDAO.getAllCarts(userId, page, PAGE_SIZE, searchQuery, category);
        List<Category> categories = new PostDAO().getUniqueCategories();
        List<Product> products = productDAO.getThreeLastestProducts();

        int totalCartItems = cartDAO.getCartCount(userId, searchQuery, category);
        int totalPages = (int) Math.ceil((double) totalCartItems / PAGE_SIZE);
        
        Setting setting = new SettingDAO().getSettingByID(3);
        if(setting.getIsDeleted()) {
            request.setAttribute("setting", setting);
        }
        request.setAttribute("cartItemsFull", cartItemsFull);
        request.setAttribute("setting", setting);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("isSuccess", request.getParameter("isSuccess"));
        request.getRequestDispatcher("/tranfer-commit.jsp").forward(request, response);
    } 

    

}
