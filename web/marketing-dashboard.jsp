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

        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>

        <!-- Sidebar -->
        <%@ include file="marketing-sidebar.jsp" %>

        <!-- Main content -->
        <div class="main-content container text-center">
            <h1 class="mb-4">Marketing Dashboard</h1>

<!--             Date Picker Form 
            <form id="dateForm" class="mb-4">
                <div class="form-row justify-content-center">
                    <div class="col-auto">
                        <label for="startDate">Start Date:</label>
                        <input type="date" id="startDate" name="startDate" class="form-control">
                    </div>
                    <div class="col-auto">
                        <label for="endDate">End Date:</label>
                        <input type="date" id="endDate" name="endDate" class="form-control">
                    </div>
                    <div class="col-auto">
                        <button type="submit" class="btn btn-primary mt-4">Update Charts</button>
                    </div>
                </div>
            </form>-->

            <div class="row">

                <div class="chart-container col-6">
                    <h2>Posts Statistics</h2>
                    <canvas id="postsChart"></canvas>
                </div>

                <div class="chart-container col-6">
                    <h2>Products Statistics</h2>
                    <canvas id="productsChart"></canvas>
                </div>

            </div>

            <div class="row">

                <div class="chart-container col-6">
                    <h2>Customers Statistics</h2>
                    <canvas id="customersChart"></canvas>
                </div>

                <div class="chart-container col-6">
                    <h2>Feedbacks Statistics</h2>
                    <canvas id="feedbacksChart"></canvas>
                </div>

            </div>

            <div class="chart-container">
                <h2>Trend of New Customers</h2>
                <canvas id="newCustomersTrendChart"></canvas>
            </div>

        </div>

        <script>
            // Labels for the last 7 days
            const labels = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];

            // Fake data for each chart
            const postsData = [${post}];
            const productsData = [${product}];
            const customersData = [${user}];
            const feedbacksData = [${feedback}];
            const newCustomersTrendData = [${user}];

            const chartConfig = (ctx, label, data, backgroundColor, borderColor) => {
                return new Chart(ctx, {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                                label: label,
                                data: data,
                                backgroundColor: backgroundColor,
                                borderColor: borderColor,
                                borderWidth: 1,
                                fill: false,
                                tension: 0.1
                            }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            };

            window.onload = () => {
                const postsCtx = document.getElementById('postsChart').getContext('2d');
                const productsCtx = document.getElementById('productsChart').getContext('2d');
                const customersCtx = document.getElementById('customersChart').getContext('2d');
                const feedbacksCtx = document.getElementById('feedbacksChart').getContext('2d');
                const newCustomersTrendCtx = document.getElementById('newCustomersTrendChart').getContext('2d');

                chartConfig(postsCtx, 'Number of Posts', postsData, 'rgba(75, 192, 192, 0.2)', 'rgba(75, 192, 192, 1)');
                chartConfig(productsCtx, 'Number of Products', productsData, 'rgba(54, 162, 235, 0.2)', 'rgba(54, 162, 235, 1)');
                chartConfig(customersCtx, 'Number of Customers', customersData, 'rgba(255, 206, 86, 0.2)', 'rgba(255, 206, 86, 1)');
                chartConfig(feedbacksCtx, 'Number of Feedbacks', feedbacksData, 'rgba(153, 102, 255, 0.2)', 'rgba(153, 102, 255, 1)');
                chartConfig(newCustomersTrendCtx, 'New Customers Trend', newCustomersTrendData, 'rgba(255, 99, 132, 0.2)', 'rgba(255, 99, 132, 1)');
            };
        </script>



    </body>
</html>
