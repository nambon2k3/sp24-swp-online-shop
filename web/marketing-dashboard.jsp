<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Marketing Dashboard</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome CSS for icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

    </head>
    <body>

        <!-- Sidebar -->
        <%@ include file="marketing-sidebar.jsp" %>

        <!-- Main content -->
        <div class="main-content container text-center">
            <h1 class="mb-4">Marketing Dashboard</h1>

            <!-- Statistics of new orders -->
            <div class="row">
                <div class="col-md-6 mb-4 p-3">
                    <h3>New Orders</h3> <!-- Added title -->
                    <canvas id="newOrdersChart"></canvas>
                </div>
                <!-- Revenues -->
                <div class="col-md-6 mb-4 p-3">
                    <h3>Revenues</h3> <!-- Added title -->
                    <canvas id="revenuesChart"></canvas>
                </div>
            </div>

            <!-- Customers -->
            <div class="row mb-4">
                <div class="col-md-6 p-3">
                    <h3>Customers</h3> <!-- Added title -->
                    <canvas id="customersChart"></canvas>
                </div>
                <!-- Feedbacks -->
                <div class="col-md-6 p-3">
                    <h3>Feedbacks</h3> <!-- Added title -->
                    <canvas id="feedbacksChart"></canvas>
                </div>
            </div>

            <div class="row d-flex" style="justify-content: center">
                <div class="col-md-8">
                    <form action="${pageContext.request.contextPath}/admin/dashboard" method="GET" class="mb-4">
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="start_date">Start Date:</label>
                                <input type="date" id="start_date" name="start_date" class="form-control" required value="${startDate}">
                            </div>
                            <div class="form-group col-md-6">
                                <label for="end_date">End Date:</label>
                                <input type="date" id="end_date" name="end_date" class="form-control" required value="${endDate}">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary">Filter</button>
                    </form>
                </div>

            </div>

            <!-- Trend of order counts -->
            <div class="row">
                <div class="col-md-12">
                    <h2>Order Trend</h2> <!-- Added title -->
                    <canvas id="orderTrendChart"></canvas>
                </div>
            </div>
        </div>




        <!-- Include Chart.js library -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

        <!-- Chart data and configurations -->
        <script>
            var newOrdersCtx = document.getElementById('newOrdersChart').getContext('2d');
            var newOrdersChart = new Chart(newOrdersCtx, {
                type: 'pie',
                data: {
                    labels: ['Success', 'Cancelled', 'Pending'], // Update labels if needed
                    datasets: [{
                            label: 'New Orders',
                            data: [${order_success}, ${order_cancel}, ${order_pending}], // Use dynamic data
                            backgroundColor: [
                                'rgba(54, 162, 235, 0.7)',
                                'rgba(255, 99, 132, 0.7)',
                                'rgba(255, 206, 86, 0.7)'
                            ],
                            borderColor: [
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 99, 132, 1)',
                                'rgba(255, 206, 86, 1)'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true
                }
            });

            // Revenues Chart
            var revenuesCtx = document.getElementById('revenuesChart').getContext('2d');
            var revenuesChart = new Chart(revenuesCtx, {
                type: 'bar',
                data: {
                    labels: ['Previous year', 'This year'],
                    datasets: [{
                            label: 'Revenues',
                            data: [${total_prev}, ${total_now}], // Use dynamic data
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.7)',
                                'rgba(54, 162, 235, 0.7)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(54, 162, 235, 1)'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });

            // Customers Chart (Column Chart)
            var customersCtx = document.getElementById('customersChart').getContext('2d');
            var customersChart = new Chart(customersCtx, {
                type: 'bar', // Change chart type to 'bar'
                data: {
                    labels: ['User', 'Order', 'Feedback'], // Add 'Feedback' label
                    datasets: [{
                            label: 'System',
                            data: [${user_count}, ${order_success + order_pending}, ${feedback_count}], // Use dynamic data
                            backgroundColor: [
                                'rgba(54, 162, 235, 0.7)',
                                'rgba(255, 99, 132, 0.7)',
                                'rgba(75, 192, 192, 0.7)' // Add color for feedback
                            ],
                            borderColor: [
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 99, 132, 1)',
                                'rgba(75, 192, 192, 1)' // Add border color for feedback
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });

            // Feedbacks Chart (Column Chart)
            var feedbacksCtx = document.getElementById('feedbacksChart').getContext('2d');
            var feedbacksChart = new Chart(feedbacksCtx, {
                type: 'bar', // Change chart type to 'bar'
                data: {
                    labels: ['1 Star', '2 Stars', '3 Stars', '4 Stars', '5 Stars'], // Update labels
                    datasets: [{
                            label: 'Average Star',
                            data: [2.7, 0.7, 1, 1.2, 4.8], // Example data for demonstration
                            backgroundColor: [
                                'rgba(255, 99, 132, 0.7)',
                                'rgba(255, 159, 64, 0.7)',
                                'rgba(255, 205, 86, 0.7)',
                                'rgba(75, 192, 192, 0.7)',
                                'rgba(54, 162, 235, 0.7)'
                            ],
                            borderColor: [
                                'rgba(255, 99, 132, 1)',
                                'rgba(255, 159, 64, 1)',
                                'rgba(255, 205, 86, 1)',
                                'rgba(75, 192, 192, 1)',
                                'rgba(54, 162, 235, 1)'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true,
                    scales: {
                        yAxes: [{
                                ticks: {
                                    beginAtZero: true
                                }
                            }]
                    }
                }
            });

            var orderTrendCtx = document.getElementById('orderTrendChart').getContext('2d');
            var norderTrendChart = new Chart(orderTrendCtx, {
                type: 'bar',
                data: {
                    labels: ['Success', 'Cancelled', 'Pending'], // Update labels if needed
                    datasets: [{
                            label: 'Trend Orders',
                            data: [${order_success_filter}, ${order_cancel_filter}, ${order_pending_filter}], // Use filtered data
                            backgroundColor: [
                                'rgba(54, 162, 235, 0.7)',
                                'rgba(255, 99, 132, 0.7)',
                                'rgba(255, 206, 86, 0.7)'
                            ],
                            borderColor: [
                                'rgba(54, 162, 235, 1)',
                                'rgba(255, 99, 132, 1)',
                                'rgba(255, 206, 86, 1)'
                            ],
                            borderWidth: 1
                        }]
                },
                options: {
                    responsive: true
                }
            });

        </script>

    </body>
</html>
