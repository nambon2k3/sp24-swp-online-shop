<%-- 
    Document   : header
    Created on : May 18, 2024, 5:57:13 PM
    Author     : Legion
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Model.Cart" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light">
            <div class="container px-4 px-lg-5">
                <a class="navbar-brand" href="home">Sloth Shopping</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
                        <li class="nav-item"><a class="nav-link" aria-current="page" href="#!">Home</a></li>
                        <li class="nav-item"><a class="nav-link" href="#!">About</a></li>
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Shop</a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="public/list-product">All Products</a></li>
                            </ul>
                        </li>
                    </ul>
                    <form class="d-flex">

                        <c:if test="${sessionScope.user == null}">
                            <a class="btn btn-outline-dark" href="${pageContext.request.contextPath}/login" style="margin-right: 25px">
                                <i class="bi-user me-1"></i>
                                Login
                            </a>
                        </c:if>
                        <c:if test="${sessionScope.user != null}">
                            <a class="btn btn-outline-dark" href="${pageContext.request.contextPath}/public/cart" style="margin-right: 25px">
                                <i class="bi-cart-fill me-1"></i>
                                Cart
                            </a>
                            <a class="btn btn-outline-dark mx-2" href="${pageContext.request.contextPath}/common/profile">
                                Profile
                            </a>

                            <a class="btn btn-outline-dark" href="${pageContext.request.contextPath}/customer/my-order" style="margin-right: 25px">
                                <i class="bi-user me-1"></i>
                                My Order
                            </a>
                            <a class="btn btn-outline-dark" href="${pageContext.request.contextPath}/customer/list-feedback">
                                <i class="bi-user me-1"></i>
                                Feedback
                            </a>
                            <a class="btn btn-outline-dark" href="${pageContext.request.contextPath}/logout">
                                Logout
                            </a>
                        </c:if>
                    </form>
                </div>
            </div>
        </nav>
    </body>
</html>
