<%-- 
    Document   : orderTrends
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Order Trends</title>
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>
        <div class="container-fluid">
            <div class="row d-flex bg-light border justify-content-between align-items-center vh-6">
                <div class="col-1">
                    <span>Marketing</span>
                </div>
                <div class="dropdown col-1" style="text-align: right;">
                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class='bx bxs-user'></i>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item border-bottom d-flex justify-content-start align-items-center" href="#">
                                <i class='bx bxs-user' style="margin-right: 20px;"></i><span>User Profile</span></a></li>
                        <li><a class="dropdown-item d-flex justify-content-start align-items-center" href="login.html"><i
                                    class='bx bx-log-in' style="margin-right: 20px;"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
            <div class="row d-flex vh-94">
                <div class="col-2 bg-light border-end p-0">
                    <div class="d-flex flex-column mb-3">
                        <div class="p-3 border-bottom d-flex justify-content-start align-items-center">
                            <input type="text" class="form-control" style="border-top-right-radius: 0; border-bottom-right-radius: 0">
                            <button class="btn btn btn-light btn-outline-secondary" style="border-top-left-radius: 0; border-bottom-left-radius: 0">
                                <i class='bx bx-search' ></i>
                            </button>
                        </div>
                        <a href="view-content.html" class="p-3 border-bottom d-flex justify-content-start align-items-center text-decoration-none active"><i class='bx bx-table mr-10'></i>Dashboard</a>

                    </div>
                </div>
                <div class="col-10 p-4">
                    <div class="row">
                        <div class="col-12">
                            <div class="card mt-4 p-3">
                                <div class="container mt-5">
                                    <h1 class="mb-4">Order Trends</h1>

                                    <form method="get" action="dashboard" class="row g-3">
                                        <div class="col-md-4">
                                            <label for="salesperson" class="form-label">Salesperson</label>
                                            <input type="text" id="salesperson" name="salesperson" class="form-control">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="startDate" class="form-label">Start Date</label>
                                            <input type="date" id="startDate" name="startDate" class="form-control">
                                        </div>
                                        <div class="col-md-4">
                                            <label for="endDate" class="form-label">End Date</label>
                                            <input type="date" id="endDate" name="endDate" class="form-control">
                                        </div>
                                        <div class="col-12">
                                            <button type="submit" class="btn btn-primary">Submit</button>
                                        </div>
                                    </form>

                                    <div class="mt-5">
                                        <h2>Success Rate</h2>
                                        <canvas id="successRateChart"></canvas>
                                    </div>

                                    <div class="mt-5">
                                        <h2>Revenue Trend</h2>
                                        <canvas id="revenueChart"></canvas>
                                    </div>

                                    <c:if test="${not empty totalOrders}">
                                        <script>
                                            // Create variables from the JSP attributes
                                            const totalOrders = `${totalOrders}`;
                                            const successfulOrders = `${successfulOrders}`;
                                            const revenue = `${revenue}`;

                                            // Extract the dates and corresponding data
                                            const labels = Object.keys(totalOrders);
                                            const successData = labels.map(date => (successfulOrders[date] || 0) / (totalOrders[date] || 1));
                                            const revenueData = labels.map(date => revenue[date] || 0);

                                            // Create the success rate chart
                                            const successRateChart = new Chart(document.getElementById('successRateChart'), {
                                                type: 'line',
                                                data: {
                                                    labels: labels,
                                                    datasets: [{
                                                            label: 'Success Rate',
                                                            data: successData,
                                                            borderColor: 'green',
                                                            fill: false
                                                        }]
                                                }
                                            });

                                            // Create the revenue chart
                                            const revenueChart = new Chart(document.getElementById('revenueChart'), {
                                                type: 'line',
                                                data: {
                                                    labels: labels,
                                                    datasets: [{
                                                            label: 'Revenue',
                                                            data: revenueData,
                                                            borderColor: 'blue',
                                                            fill: false
                                                        }]
                                                }
                                            });
                                        </script>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
         <jsp:include page="footer.html"></jsp:include>
    </body>
</html>








<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
crossorigin="anonymous"></script>
