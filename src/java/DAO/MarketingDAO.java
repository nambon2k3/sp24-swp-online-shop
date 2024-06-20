package DAO;

import Model.Order;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;

public class MarketingDAO {

    private Connection conn;
    private PreparedStatement ps;
    private ResultSet rs;

    public MarketingDAO() {
        try {
            // Initialize the connection in the constructor
            conn = new DBContext().getConnection();
        } catch (Exception ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getStatiticTrend(String table) {
        StringBuilder result = new StringBuilder();
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Calendar calendar = Calendar.getInstance();

        for (int i = 0; i < 7; i++) {
            Date currentDate = calendar.getTime();
            String formattedDate = dateFormat.format(currentDate);

            String query = "SELECT COUNT(*) AS Count FROM [" + table + "] WHERE CAST(CreatedAt AS DATE) = ?";
            try {
                ps = conn.prepareStatement(query);
                ps.setString(1, formattedDate);
                rs = ps.executeQuery();
                if (rs.next()) {
                    int userCount = rs.getInt("Count");
                    if (i > 0) {
                        result.append(",");
                    }
                    result.append(userCount);
                }
            } catch (SQLException e) {
                Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
            }

            // Move calendar to previous day
            calendar.add(Calendar.DATE, -1);
        }

        return result.toString();
    }

    public String getStatiticTrend(String table, Date startDate, Date endDate) {
        StringBuilder result = new StringBuilder();
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");

        // Calendar for iterating over dates
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(endDate); // Set the end date

        try {
            // Prepare SQL query
            String query = "SELECT COUNT(*) AS UserCount FROM [" + table + "] WHERE CAST(CreatedAt AS DATE) = ?";
            ps = conn.prepareStatement(query);

            // Iterate over dates from endDate to startDate
            while (!calendar.getTime().before(startDate)) {
                Date currentDate = calendar.getTime();
                String formattedDate = dateFormat.format(currentDate);

                // Set the formatted date parameter in the prepared statement
                ps.setString(1, formattedDate);
                rs = ps.executeQuery();

                if (rs.next()) {
                    int userCount = rs.getInt("Count");
                    if (result.length() > 0) {
                        result.append(",");
                    }
                    result.append(userCount);
                }

                // Move calendar to previous day
                calendar.add(Calendar.DATE, -1);
            }

        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return result.toString();
    }

}
