/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.FeedbackDAO;
import Model.Feedback;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
        Boolean isDeleted = request.getParameter("status") == null ? null : Boolean.parseBoolean(request.getParameter("status"));

        // Perform filtering based on the provided parameters
        List<Feedback> filteredFeedbackList = feedbackDAO.getFilteredFeedbacks(searchComment, isDeleted, pageNumber, pageSize);

        // Get total number of feedbacks matching the filter criteria
        int totalFeedbacks = feedbackDAO.getFilteredFeedbacks(searchComment, isDeleted).size();

        // Calculate total number of pages
        int totalPages = (int) Math.ceil((double) totalFeedbacks / pageSize);

        // Forward the filtered feedback list and pagination parameters to the JSP
        request.setAttribute("feedbackList", filteredFeedbackList);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("../marketing-feedback.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Determine action (add or update)
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    addFeedback(request, response);
                    break;
                case "update":
                    updateFeedback(request, response);
                    break;
                case "delete":
                    // TODO: Implement logic for deleting feedback
                    response.sendError(HttpServletResponse.SC_NOT_IMPLEMENTED, "Feedback deletion not implemented yet.");
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
}
