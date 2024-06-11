/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.FeedbackDAO;
import Model.Feedback;
import Model.Order;
import Model.Product;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "MarketingFeedbackController", urlPatterns = {"/marketing/feedback"})
public class MarketingFeedbackController extends HttpServlet {

    private FeedbackDAO feedbackDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        feedbackDAO = new FeedbackDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Pagination parameters
        int pageNumber = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        int pageSize = 5;

        // Filter parameters
        String searchComment = request.getParameter("searchComment");
        String searchName = request.getParameter("searchName");
        String searchFullName = request.getParameter("searchFullName");
        String rating = request.getParameter("rating");
        Boolean isDeleted = (request.getParameter("status") == null || request.getParameter("status").isEmpty()) ? null : Boolean.parseBoolean(request.getParameter("status"));

        // Perform filtering based on the provided parameters
        List<Feedback> filteredFeedbackList = feedbackDAO.getFilteredFeedbacks(searchComment, isDeleted, rating, pageNumber, pageSize);
        if (searchName != null && !searchName.isEmpty()) filteredFeedbackList = searchByProductName(filteredFeedbackList, searchName);
        if (searchFullName != null && !searchFullName.isEmpty()) filteredFeedbackList = searchByFullname(filteredFeedbackList, searchFullName);
        
        // Get total number of feedbacks matching the filter criteria
        List<Feedback> totalFeedbackList = feedbackDAO.getFilteredFeedbacks(searchComment, isDeleted, rating);
        if (searchName != null && !searchName.isEmpty()) totalFeedbackList = searchByProductName(totalFeedbackList, searchFullName);
        if (searchFullName != null && !searchFullName.isEmpty()) totalFeedbackList = searchByFullname(totalFeedbackList, searchFullName);
        int totalFeedbacks = totalFeedbackList.size();

        // Calculate total number of pages
        int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);

        // Forward the filtered feedback list and pagination parameters to the JSP
        request.setAttribute("feedbackList", filteredFeedbackList);
        
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);
        
        request.setAttribute("searchComment", searchComment);
        request.setAttribute("searchName", searchName);
        request.setAttribute("searchFullName", searchFullName);
        request.setAttribute("rating", rating);
        request.setAttribute("isDeleted", isDeleted);

        request.getRequestDispatcher("../marketing-feedback.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Determine action (add or update)
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "update":
                    updateFeedback(request, response);
                    break;
            }
        } else {
            // Handle missing action parameter
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void addFeedback(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve feedback data from request parameters
        int orderDetailId = Integer.parseInt(request.getParameter("orderDetailId")); // Assuming orderDetailId is required
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");
        boolean isDeleted = Boolean.parseBoolean(request.getParameter("isDeleted"));
        java.util.Date createdAt = new java.util.Date(); // Set current date as created date

        Feedback newFeedback = new Feedback();
        newFeedback.setOrderDetailId(orderDetailId);
        newFeedback.setRating(rating);
        newFeedback.setComment(comment);
        newFeedback.setIsDeleted(isDeleted);
        newFeedback.setCreatedAt(createdAt);

        boolean success = feedbackDAO.addFeedback(newFeedback);

        if (success) {
            // Redirect to feedback list page after successful addition
            response.sendRedirect("feedback?success");
        } else {
            response.sendRedirect("feedback?fail");
        }
    }

    private void updateFeedback(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve feedback data from request parameters
        int feedbackId = Integer.parseInt(request.getParameter("feedbackId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String comment = request.getParameter("comment");
        boolean isDeleted = Boolean.parseBoolean(request.getParameter("isDeleted"));

        // Create a Feedback object with the updated data
        Feedback feedback = feedbackDAO.getFeedbackById(feedbackId);
        feedback.setRating(rating);
        feedback.setComment(comment);
        feedback.setIsDeleted(isDeleted);

        // Update the feedback
        boolean success = feedbackDAO.updateFeedback(feedback);
        if (success) {
            // Redirect to feedback list page after successful update
            response.sendRedirect("feedback?success");
        } else {
            // Handle update failure
            response.sendRedirect("feedback?fail");
        }
    }
    
    private List<Feedback> searchByProductName(List<Feedback> list, String name) {
        if (name==null || name.isEmpty()) return list;
        name = name.toLowerCase();
        
        List<Feedback> results = new ArrayList<Feedback>();
        
        for (Feedback feedback : list) {
            Product product = feedback.getOrderDetail().getProductDetail().getProduct();
            
            if (product.getProductName().toLowerCase().contains(name)) {
                results.add(feedback);
            }
        }
        
        return results;
    }
    
    private List<Feedback> searchByFullname(List<Feedback> list, String name) {
        if (name==null || name.isEmpty()) return list;
        name = name.toLowerCase();
        
        List<Feedback> results = new ArrayList<Feedback>();
        
        for (Feedback feedback : list) {
            Order order = feedback.getOrderDetail().getOrder();
            
            if (order.getFullname().toLowerCase().contains(name)) {
                results.add(feedback);
            }
        }
        
        return results;
    }
}
