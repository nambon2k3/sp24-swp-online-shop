/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.SliderDAO;
import Model.Slider;
import Utils.EmailService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author anhdu
 */
@WebServlet(name = "MarketingSliderController", urlPatterns = {"/marketing/slider"})
public class MarketingSliderController extends HttpServlet {

    private SliderDAO sliderDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        sliderDAO = new SliderDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Pagination parameters
        int pageNumber = request.getParameter("page") == null ? 1 : Integer.parseInt(request.getParameter("page"));
        int pageSize = 5;

        // Filter parameters
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        Boolean isDeleted = status==null ? null : (Boolean.parseBoolean(status));

        // Perform filtering based on the provided parameters
        List<Slider> filteredSliderList = sliderDAO.getFilteredSliders(search, isDeleted, pageNumber, pageSize);

        // Get total number of sliders matching the filter criteria
        int totalSliders = sliderDAO.getFilteredSliders(search, isDeleted).size();

        // Calculate total number of pages
        int totalPages = (int) Math.ceil((double) totalSliders / pageSize);

        // Forward the filtered slider list and pagination parameters to the JSP
        request.setAttribute("sliderList", filteredSliderList);
        request.setAttribute("currentPage", pageNumber);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("../marketing-slider.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Determine action (add or update)
        String action = request.getParameter("action");
        if (action != null) {
            switch (action) {
                case "add":
                    addSlider(request, response);
                    break;
                case "update":
                    updateSlider(request, response);
                    break;
            }
        } else {
            // Handle missing action parameter
            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
        }
    }

    private void addSlider(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve slider data from request parameters
        String imageUrl = request.getParameter("imageUrl");
        String title = request.getParameter("title");
        String backlink = request.getParameter("backlink");
        String notes = request.getParameter("notes");
        boolean isDeleted = Boolean.parseBoolean(request.getParameter("isDeleted"));
        java.util.Date createdAt = new java.util.Date(); // Set current date as created date
//        int createdBy = Integer.parseInt(request.getParameter("createdBy"));

        Slider newSlider = new Slider();
        newSlider.setTitle(title);
        newSlider.setBacklink(backlink);
        newSlider.setNotes(notes);
        newSlider.setImageUrl(imageUrl);
        newSlider.setIsDeleted(isDeleted);
        newSlider.setCreatedAt(createdAt);
//        newSlider.setCreatedBy(createdBy);

        boolean success = sliderDAO.addSlider(newSlider);

        if (success) {
            // Redirect to slider list page after successful addition
            response.sendRedirect("slider?success");
        } else {
            response.sendRedirect("slider?fail");
        }
    }

    private void updateSlider(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve slider data from request parameters
        String title = request.getParameter("title");
        String backlink = request.getParameter("backlink");
        String notes = request.getParameter("notes");
        int sliderId = Integer.parseInt(request.getParameter("sliderId"));
        String imageUrl = request.getParameter("imageUrl");
        boolean isDeleted = Boolean.parseBoolean(request.getParameter("isDeleted"));

        // Create a Slider object with the updated data
        Slider slider = sliderDAO.getSliderById(sliderId);
        slider.setImageUrl(imageUrl);
        slider.setIsDeleted(isDeleted);
        slider.setTitle(title);
        slider.setBacklink(backlink);
        slider.setNotes(notes);

        // Update the slider
        boolean success = sliderDAO.updateSlider(slider);
        if (success) {
            // Redirect to slider list page after successful update
            response.sendRedirect("slider?success");
        } else {
            // Handle update failure
            response.sendRedirect("slider?fail");
        }
    }

}
