/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import Model.User;
import Utils.EmailService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "AdminUserControl", urlPatterns = {"/admin/user"})
public class AdminUserControl extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Pagination parameters
        int pageNumber = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        int pageSize = 5;

        // Filter parameters
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String gender = request.getParameter("gender");

        // Perform filtering based on the provided parameters
        List<User> filteredUserList = userDAO.getFilteredUsers(fullName, email, gender, pageNumber, pageSize);

        // Get total number of users matching the filter criteria
        int totalUsers = userDAO.getAllUsers(pageNumber, pageSize).size();

        // Calculate total number of pages
        int totalPages = (int) Math.ceil((double) totalUsers / pageSize);

        // Forward the filtered user list and pagination parameters to the JSP
        request.setAttribute("userList", filteredUserList);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("../user-list.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Determine action (add or update)
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    addUser(request, response);
                    break;
                case "update":
                    updateUser(request, response);
                    break;
            }
        } else {
            // Handle missing action parameter
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user data from request parameters
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        boolean success = false;

        User user = userDAO.getUserByEmail(email);

        if (user == null) {
            
            User registerUser = new User();
            registerUser.setFullname(fullName);
            registerUser.setEmail(email);
            registerUser.setPassword(password);
            registerUser.setGender(gender ? "Male" : "Female");
            registerUser.setAddress(address);
            registerUser.setPhone(phone);
            
            // Register the user
            success = userDAO.registerUser(registerUser);

            EmailService.sendEmail(email, "Account created", "Your password: " + password);
        }

        if (success) {
            // Redirect to user list page after successful addition
            response.sendRedirect("user?success");
        } else {
            response.sendRedirect("user?fail");
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve user data from request parameters
        int userId = Integer.parseInt(request.getParameter("userId"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        boolean gender = Boolean.parseBoolean(request.getParameter("gender"));
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        // Create a User object with the updated data
        User user = new User();
        user.setId(userId);
        user.setFullname(fullName);
        user.setEmail(email);
        user.setPassword(password);
        user.setGender(gender ? "Male" : "Female");
        user.setAddress(address);
        user.setPhone(phone);

        // Update the user
        boolean success = userDAO.updateUser(user);
        if (success) {
            // Redirect to user list page after successful update
            response.sendRedirect("user?success");
        } else {
            // Handle update failure
            response.sendRedirect("user?fail");
        }
    }

}
