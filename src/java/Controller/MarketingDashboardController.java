/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.MarketingDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.text.ParseException;


@WebServlet(name = "MarketingDashboardController", urlPatterns = {"/marketing/dashboard"})
public class MarketingDashboardController extends HttpServlet {



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String startDateParam = request.getParameter("startDate");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date startDate = null;
        
        if (startDateParam != null) {
            try {
                startDate = sdf.parse(startDateParam);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        } else {
            startDate = new Date(); // Default to current date if no startDate provided
        }
        
        MarketingDAO dao = new MarketingDAO();
        
        request.setAttribute("post", dao.getStatisticTrend("Post", startDate));
        request.setAttribute("product", dao.getStatisticTrend("Product", startDate));
        request.setAttribute("user", dao.getStatisticTrend("User", startDate));
        request.setAttribute("feedback", dao.getStatisticTrend("Feedback", startDate));
        
        request.getRequestDispatcher("../marketing-dashboard.jsp").forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }


}
