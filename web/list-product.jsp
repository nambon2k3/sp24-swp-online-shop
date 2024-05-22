<%-- 
    Document   : Home
    Created on : Jan 7, 2024, 9:04:10 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>List Product Page</title>
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="../css/styles.css" rel="stylesheet" />
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
            <!-- Section-->
            <section class="py-5">
                <div class="container px-4 px-lg-5 mt-5">
                    <!-- Search and Filter Form -->
                    <form action="list-product" method="get" class="d-flex mb-4">
                        <input class="form-control me-2" type="search" name="searchQuery" placeholder="Search" aria-label="Search" value="${searchQuery}">
                    <select class="form-select me-2" name="categoryId">
                        <option value="">All Categories</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.ID}" <c:if test="${categoryId == category.ID}">selected</c:if>>${category.categoryName}</option>
                        </c:forEach>
                    </select>
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
                <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
                    <c:forEach items="${products}" var="p">
                        <div class="col mb-5">
                            <div class="card h-100">
                                <!-- Sale badge-->
                                <c:if test="${p.productDetail.discount != null || p.productDetail.discount != 0}">
                                    <div class="badge bg-dark text-white position-absolute" style="top: 0.5rem; right: 0.5rem">Sale</div>
                                </c:if>

                                <!-- Product image-->
                                <img class="card-img-top" src="${p.productDetail.imageURL}" alt="..." />
                                <!-- Product details-->
                                <div class="card-body p-4">
                                    <div class="text-center">
                                        <!-- Product name-->
                                        <h5 class="fw-bolder">${p.productName}</h5>
                                        <!-- Product reviews-->
                                        <div class="d-flex justify-content-center small text-warning mb-2">
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                            <div class="bi-star-fill"></div>
                                        </div>
                                        <!-- Product price-->
                                        <span class="text-muted text-decoration-line-through">$20.00</span>
                                        $${p.productDetail.price}
                                    </div>
                                </div>
                                <!-- Product actions-->
                                <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                                    <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="product-detail?id=${p.productId}">View details</a></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach> 
                </div>
                <!-- Pagination -->
                <div class="row mb-5">
                    <form action="list-product" method="get" class="d-flex text-center justify-content-center align-items-lg-center">
                        <input type="hidden" name="searchQuery" value="${searchQuery}">
                        <input type="hidden" name="categoryId" value="${categoryId}">
                        <button style="margin-right: 10px; width: fit-content" class="btn btn-primary">Go to Page:</button>
                        <input class="form-control" oninput="valid(this)" style="width: 30px; font-size: 15px; padding: 5px; height: 25px; margin-right: 5px" pattern="\d{1,}" title="Enter number" type="text" name="page" value="${page}" min="1" max="${endPage}">
                        / ${endPage}
                    </form>
                </div>
            </div>
        </section>

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="../js/scripts.js"></script>

        <script>
            function valid(input) {
                input.value = input.value.replace(/[^0-9]/g, '');
                if (input.value > ${endPage})
                    input.value = ${endPage};
                if (input.value < 1)
                    input.value = 1;
            }
        </script>
        <!-- đáy -->
        <jsp:include page="footer.html"></jsp:include>
    </body>
</html>
