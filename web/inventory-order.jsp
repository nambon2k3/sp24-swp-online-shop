<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
        <%@ include file="inventory-sidebar.jsp" %>

        <!-- Main content -->
        <div class="main-content container text-center" style="margin-top: 10%">
            <h2>My Orders</h2>
            <c:if test="${isSuccess ne null && isSuccess}">
                <div class="alert alert-success alert-dismissible fade show mt-2" role="alert" id="mess">
                    <strong>Save success!</strong> You should check in on some of those fields below.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close" onclick="document.getElementById('mess').style.display = 'none'"></button>
                </div>
            </c:if>
            <c:if test="${isSuccess ne null && !isSuccess}">
                <div class="alert alert-danger alert-dismissible fade show mt-2" role="alert" id="mess">
                    <strong>Save failed!</strong> You should check your network.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            <form method="get" action="list-order" class="form-inline mb-3">
                <div class="row col-12">
                    <div class="col-md-3">
                        <label for="startDate" class="form-label">Start Date</label>
                        <input type="date" id="startDate" name="startDate" class="form-control" value="${param.startDate}">
                    </div>
                    <div class="col-md-3">
                        <label for="endDate" class="form-label">End Date</label>
                        <input type="date" id="endDate" name="endDate" class="form-control" value="${param.endDate}">
                    </div>
                    <div class="col-md-3">
                        <label for="orderStatus" class="form-label">Order Status</label>
                        <select id="orderStatus" name="orderStatus" class="form-control">
                            <option value="" ${param.orderStatus == null ? 'selected' : ''}>All</option>
                            <option value="Approved" ${param.orderStatus == 'Approved' ? 'selected' : ''}>Approved</option>
                            <option value="Shipping" ${param.orderStatus == 'Shipping' ? 'selected' : ''}>Shipping</option>
                        </select>
                    </div>
                    <div class="col-3 mt-3">
                        <button type="submit" class="btn btn-primary">Filter</button>
                    </div>
                </div>
            </form>

            <table class="table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Order Date</th>
                        <th>Customer Name</th>
                        <th>Sale Name</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Total</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${orders}">
                        <tr>
                            <td><a href="order-detail?orderId=${item.id}">${item.id}</a></td>
                            <td>${item.createdAt}</td>
                            <td>${item.user.fullname}</td>
                            <td>${item.staff.fullname}</td>
                            <td>${item.address}</td>
                            <td>${item.phone}</td>
                            <td>$${item.totalCost}</td>
                            <td>${item.status}</td>
                            <td>
                                <c:if test="${item.status eq 'Approved'}">
                                    <a href="shipping-order?orderId=${item.id}&status=Boxed" class="btn btn-primary">Boxed</a>
                                </c:if>
                                    <c:if test="${item.status eq 'Boxed'}">
                                    <a href="shipping-order?orderId=${item.id}&status=Shipping" class="btn btn-primary">Shipping</a>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!-- Pagination Controls -->
            <nav aria-label="Page navigation">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 1}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage - 1}&startDate=${param.startDate}&endDate=${param.endDate}&salesperson=${param.salesperson}&orderStatus=${param.orderStatus}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}&startDate=${param.startDate}&endDate=${param.endDate}&salesperson=${param.salesperson}&orderStatus=${param.orderStatus}">${i}</a>
                        </li>
                    </c:forEach>
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item">
                            <a class="page-link" href="?page=${currentPage + 1}&startDate=${param.startDate}&endDate=${param.endDate}&salesperson=${param.salesperson}&orderStatus=${param.orderStatus}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                </ul>
            </nav>
        </div>
        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    </body>
</html>
