/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;

/**
 *
 * @author lvhn1
 */
@WebServlet(name = "AdminDashboard", urlPatterns = {"/admin/dashboard"})
public class AdminDashboard extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminDashboard</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDashboard at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get the start date and end date from request parameters
        String startDateStr = request.getParameter("start_date");
        String endDateStr = request.getParameter("end_date");

        // Set default values if start date or end date are null
        LocalDateTime startDate = startDateStr != null ? LocalDateTime.parse(startDateStr + "T00:00:00") : LocalDateTime.now().minusDays(7);
        LocalDateTime endDate = endDateStr != null ? LocalDateTime.parse(endDateStr + "T00:00:00") : LocalDateTime.now();

        // Retrieve order counts based on status and date range
//        request.setAttribute("order_success", new AdminDAO().getOrdersByStatus("Delivered").size());
//        request.setAttribute("order_cancel", new AdminDAO().getOrdersByStatus("Canceled").size());
//        request.setAttribute("order_pending", new AdminDAO().getOrdersByStatus("Pending").size());
//
//        request.setAttribute("order_success_filter", new AdminDAO().getOrdersByStatusAndDateRange("Delivered", startDate, endDate).size());
//        request.setAttribute("order_cancel_filter", new AdminDAO().getOrdersByStatusAndDateRange("Canceled", startDate, endDate).size());
//        request.setAttribute("order_pending_filter", new AdminDAO().getOrdersByStatusAndDateRange("Pending", startDate, endDate).size());
//
//        // Retrieve total cost of orders from previous years
//        request.setAttribute("total_now", new AdminDAO().getTotalCostOfPreviousNYears(0));
//        request.setAttribute("total_prev", new AdminDAO().getTotalCostOfPreviousNYears(1));
//
//        // Retrieve the count of users
//        request.setAttribute("user_count", new UserDAO().getAllUsers().size());
//
//        // Retrieve the count of feedbacks
//        request.setAttribute("feedback_count", new AdminDAO().countFeedback());

        // Set start and end dates
        request.setAttribute("startDate", startDate.toString().substring(0, 10));
        request.setAttribute("endDate", endDate.toString().substring(0, 10));

        // Forward the request to the JSP
        request.getRequestDispatcher("../admin-dashboard.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
