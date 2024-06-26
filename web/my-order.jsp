<%-- 
    Document   : my-order
    Created on : Jun 4, 2024, 10:24:19 PM
    Author     : Legion
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

    <head>
        <title>Shopping Cart</title>
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet">
        <style>
            #product:hover, #product *:hover {
                background-color: #e6e6e6;
            }
        </style>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
    </head>

    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <!-- Header-->
            <header class="py-5" style="background-image: linear-gradient(rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3)), url(https://w0.peakpx.com/wallpaper/752/914/HD-wallpaper-sabito-s-haori-kimetsu-no-yaiba-pattern.jpg);">
                <div class="container px-4 px-lg-5 my-5">
                    <div class="text-center text-white">
                        <h1 class="display-4 fw-bolder">Shop in style</h1>
                        <p class="lead fw-normal text-white-50 mb-0">With this shop hompeage template</p>
                    </div>
                </div>
            </header>

            <div class="col-md-12 d-flex justify-content-center p-3">

                <div id="sidebar" class="col-md-2 p-3" style="border: 1px solid rgb(144, 141, 141); height: 100vh;">
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
                    <c:forEach items="${products}" var="p">
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
            <div class="col-md-10">
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
                <form method="GET" action="my-order" class="form-inline mb-3">
                    <div class="form-group mx-sm-3 mb-2">
                        <label for="orderDate" class="sr-only">Order Date:</label>
                        <input type="date" id="orderDate" name="orderDate" class="form-control" value="${orderDate}" placeholder="Order Date">
                    </div>
                    <div class="form-group mx-sm-3 mb-2">
                        <label for="orderTime" class="sr-only">Order Time:</label>
                        <input type="time" id="orderTime" name="orderTime" class="form-control" value="${orderTime}" placeholder="Order Time">
                    </div>
                    <div class="form-group mx-sm-3 mb-2">
                        <label for="orderStatus" class="sr-only">Order Status:</label>
                        <select id="orderStatus" name="orderStatus" class="form-control">
                            <option value="">All</option>
                            <option value="Received" ${orderStatus eq"Received" ? "selected" : ""}>Received</option>
                            <option value="Submitted" ${orderStatus eq"Submitted" ? "selected" : ""}>Submitted</option>
                            <option value="Shipped" ${orderStatus eq"Shipped" ? "selected" : ""}>Shipped</option>
                            <option value="Request Cancel" ${orderStatus eq "Request Cancel" ? "selected" : ""}>Request Cancel</option>
                            <option value="Canceled" ${orderStatus eq "Canceled" ? "selected" : ""}>Canceled</option>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary mb-2">Filter</button>
                </form>

                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Order Date</th>
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
                                <td>${item.address}</td>
                                <td>${item.phone}</td>
                                <td>$${item.totalCost}</td>
                                <td>${item.status}</td>
                                <td>
                                    <c:if test="${item.status eq 'Shipped'}">
                                        <a href="confirm-order?orderId=${item.id}" class="btn btn-primary">Received</a>
                                    </c:if>
                                    <c:if test="${item.status eq 'Not yet' && !item.isExpired()}">
                                        <a href="payment?orderId=${item.id}&method=repay" class="btn btn-primary">Continue payment</a>
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
                                <a class="page-link" href="?page=${currentPage - 1}&orderDate=${orderDate}&orderTime=${orderTime}&orderStatus=${orderStatus}" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                        </c:if>
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="?page=${i}&orderDate=${orderDate}&orderTime=${orderTime}&orderStatus=${orderStatus}">${i}</a>
                            </li>
                        </c:forEach>
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="?page=${currentPage + 1}&orderDate=${orderDate}&orderTime=${orderTime}&orderStatus=${orderStatus}" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </div>

        </div>

    </body>

</html>


</body>

</html>
