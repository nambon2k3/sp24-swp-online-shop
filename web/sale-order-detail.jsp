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
        <%@ include file="sale-sidebar.jsp" %>

        <!-- Main content -->
        <div class="main-content container" style="margin-top: 10%; margin-bottom: 10%">
            <c:if test="${isSuccess ne null && isSuccess}">
                <div class="alert alert-success alert-dismissible fade show mt-2" role="alert" id="mess">
                    <strong>Save success!</strong> 
                </div>
            </c:if>
            <c:if test="${isSuccess ne null && !isSuccess}">
                <div class="alert alert-danger alert-dismissible fade show mt-2" role="alert" id="mess">
                    <strong>Save failed!</strong> You should check your network.
                </div>
            </c:if>
            <!-- Order Details -->
            <h2>Order Details</h2>
            <p>Order ID: ${order.id}</p>
            <p>Order Date: ${order.createdAt}</p>
            <p>Total Cost: $${order.totalCost}</p>
            <p>Status: ${order.status}</p>

            <!-- Receiver Information -->
            <h3>Receiver Information</h3>
            <p>Full Name: ${order.fullname}</p>
            <p>Address: ${order.address}</p>
            <p>Phone: ${order.phone}</p>
            <p>Gender: ${order.user.gender}</p>
            <p>Sale name: ${order.sale.fullname}</p>

            <!-- Ordered Products -->
            <h3>Ordered Products</h3>
            <table class="table">
                <thead>
                    <tr>
                        <th>Thumbnail</th>
                        <th>Name</th>
                        <th>Category</th>
                        <th>Unit Price</th>
                        <th>Quantity</th>
                        <th>Total Cost</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${orderedProducts}">
                        <tr>
                            <td><img src="${product.imageURL}" alt="..." width="100" height="100"></td>
                            <td>${product.getProductName()}</td>
                            <td>${product.getCateogryName()}</td>
                            <td>$${product.discount != null &&  product.discount != 0 ? (product.price * (100-product.discount)/100) : product.price}</td>
                            <td>${product.buyQuantity}</td>
                            <td>$${product.discount != null &&  product.discount != 0 ? (product.price * (100-product.discount)/100)*(product.buyQuantity) : product.price*product.buyQuantity}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div>
                <strong>Total Order Price:</strong> $${order.totalCost}
            </div>


            <div class="mt-4">
                <c:if test="${order.status eq 'Submitted'}">
                    <a class="btn btn-success" href="approve-order?orderId=${order.id}&status=Approved">
                        Approved
                    </a>
                    <a class="btn btn-danger" href="approve-order?orderId=${order.id}&status=Rejected"">
                        Rejected
                    </a>
                </c:if>
                <form method="get" action="update-order-status" class="form-inline mb-3">
                    <c:if test="${order.status ne 'Received' && order.status ne 'Canceled'}">
                        <table class="table">
                            <c:if test="${sessionScope.staff.role eq 4}">
                                <tr>
                                    <td>
                                        <label for="orderStatus" class="form-label mr-5"><strong>Assign to:</strong> </label>
                                    </td>
                                    <td>
                                        <select id="orderStatus" name="saleId" class="form-control mr-5">
                                            <c:forEach items="${sales}" var="item">
                                                <option value="${item.id}" ${item.id == order.createdBy ? 'selected' : ''}>${item.fullname}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                            </c:if>

                            <tr>
                                <td>
                                    <label for="orderStatus" class="form-label mr-5"><strong>Update Order Status:</strong> </label>
                                </td>

                                <td>
                                    <select id="orderStatus" name="orderStatus" class="form-control mr-5">
                                        <c:if test="${order.status  ne 'Shipped'}">
                                            <option value="${order.status}" selected="">${order.status}</option>
                                        </c:if>
                                        <c:if test="${order.status  eq 'Shipping'}">
                                            <option value="Shipped" ${order.status == 'Shipped' ? 'selected' : ''}>Shipped</option>
                                            <option value="Fail" ${order.status == 'Failed' ? 'selected' : ''}>Failed</option>
                                        </c:if>
                                        <c:if test="${order.status  eq 'Request cancel'}">
                                            <option value="Canceled" ${order.status == 'Canceled' ? 'selected' : ''}>Canceled</option>
                                        </c:if>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <label for="orderStatus" class="form-label mr-5"><strong>Notes: </strong> </label>
                                </td>
                                <td>
                                    <textarea name="notes" class="form-control">
                                        ${order.notes}
                                    </textarea>
                                </td>
                            </tr>
                            <tr>
                                <td><input type="hidden" name="orderId" value="${order.id}"></td>
                                <td><button type="submit" class="btn btn-success">Update</button></td>
                            </tr>
                        </table>
                    </c:if>
                </form>

            </div>

        </div>
        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    </body>
</html>
