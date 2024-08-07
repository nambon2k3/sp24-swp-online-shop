<%-- 
    Document   : order-detail
    Created on : Jun 6, 2024, 3:54:30 PM
    Author     : Legion
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Order Details</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Header-->
            <header class="py-5 mb-3" style="background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url(https://w0.peakpx.com/wallpaper/752/914/HD-wallpaper-sabito-s-haori-kimetsu-no-yaiba-pattern.jpg);">
                <div class="container px-4 px-lg-5 my-5">
                    <div class="text-center text-white">
                        <h1 class="display-4 fw-bolder">Shop in style</h1>
                        <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                    </div>
                </div>
            </header>
            <div class="row col-12" style="margin-bottom: 200px">
                <!-- Sidebar -->
                <div id="sidebar" class="col-md-2 p-3 mr-5" style="border: 1px solid rgb(144, 141, 141); height: 100vh;">
                    <form method="get" action="../public/list-product" class="mr-0">
                        <div id="product-search">
                            <h3>Search Products</h3>
                            <input type="text" id="search-box" name="searchQuery" placeholder="Search for products..." class="form-control" value="${param.searchQuery}">
                    </div>
                    <div class="form-group">
                        <label for="category">Category:</label>
                        <select id="category" name="categoryId" class="form-control">
                            <option value="">All</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.ID}" ${param.category == cat.categoryName ? 'selected' : ''}>${cat.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Filter</button>
                </form>
                <div id="latest-products">
                    <h3>Latest Products</h3>
                    <c:forEach items="${latestProducts}" var="p">
                        <a id="product" href="../public/product-detail?id=${p.productId}" style="text-decoration: none; color: black;">
                            <table class="p-2">
                                <tr>
                                    <td><img src="${p.productDetail.imageURL}" style="width:50px; height: 50px" alt="..." /></td>
                                    <td><h5 class="fw-bolder">${p.productName}</h5></td>
                                    <td>
                                        <div class="d-flex justify-content-center small text-warning mb-2">
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                        </div>
                                    </td>
                                    <td>
                                        <c:if test="${p.productDetail.discount != null || p.productDetail.discount != 0}">
                                            <span class="text-muted text-decoration-line-through">$${p.productDetail.price}</span>
                                            $${p.productDetail.price * (100.0- p.productDetail.discount)/100}
                                        </c:if>

                                        <c:if test="${p.productDetail.discount == null || p.productDetail.discount == 0}">
                                            $${p.productDetail.price}
                                        </c:if>

                                    </td>
                                </tr>
                            </table>
                        </a>

                    </c:forEach>
                </div>
                <div id="static-contacts" style="margin-top: 15px">
                    <h3>Contact Us</h3>
                    <p>Email: contact@example.com</p>
                    <p>Phone: 123-456-7890</p>
                    <p>Address: 123 Main St, Anytown, USA</p>
                </div>
            </div>
            <div class="col-md-9">
                <!-- Order Details -->
                <h2>Order Details</h2>
                <p>Order ID: ${order.id}</p>
                <p>Order Date: ${order.createdAt}</p>
                <p>Total Cost: $${order.totalCost}</p>
                <p>Status: ${order.status}</p>
                <p>Payment Method: ${order.paymentMethod}</p>

                <!-- Receiver Information -->
                <h3>Receiver Information</h3>
                <p>Full Name: ${order.fullname}</p>
                <p>Address: ${order.address}</p>
                <p>Phone: ${order.phone}</p>
                <p>Gender: ${order.getGender(sessionScope.user.email)}</p>

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
                            <th>Actions</th>
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
                                <td>
                                    <a href="${pageContext.request.contextPath}/public/product-detail?id=${product.productId}&pdid=${product.productDetailId}" class="btn btn-primary">Re-buy</a>
                                    <c:if test="${order.status eq 'Close' && !product.isFeedbacked()}">
                                        <a href="feedback?id=${product.orderDetailId}" class="btn btn-secondary">Feedback</a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <div>
                    <strong>Total Order Price:</strong> $${order.totalCost}
                </div>
                
                
                <!-- Order Actions -->
                <c:if test="${order.status ne 'Close' && order.status ne 'Canceled' && order.status ne 'Failed' && order.status ne 'Success' && order.status ne 'Rejected' && order.status ne 'Delivering'}">
                    <div class="mt-4">
                    <a href="cancel-order?orderId=${order.id}" class="btn btn-danger">Cancel Order</a>
                </div>
                </c:if>

            </div>
        </div>
        <jsp:include page="footer.html"></jsp:include>
    </body>
</html>

