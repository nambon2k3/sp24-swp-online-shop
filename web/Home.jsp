<%-- 
    Document   : Home
    Created on : Jan 7, 2024, 9:04:10 PM
    Author     : Admin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <style>
            .carousel-item img {
                width: 100%;
                height: auto;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
            <div id="carouselExampleCaptions" class="carousel slide">
                <div class="carousel-indicators">
                <c:forEach var="index" begin="0" end="${sliders.size()- 1}"> 
                    <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="${index}" ${index  == 0 ? "class=\"active\" aria-current=\"true\"": ""} aria-label="Slide ${index}"></button>
                </c:forEach>
            </div>
            <div class="carousel-inner">
                <c:set value="1" var="index"/>
                <c:forEach var="slider" items="${sliders}" >
                    <a href="${slider.backlink}" class="carousel-item ${index eq 1 ? "active" : ""}">
                        <img src="${slider.imageUrl}" class="d-block w-100" style="height: 600px; object-fit: contain" alt="...">
                        <div class="carousel-caption d-none d-md-block">
                            <h5>${slider.title}</h5>
                            <p>${slider.notes}</p>
                        </div>
                    </a>
                    <c:set value="${index + 1}" var="index"/>
                </c:forEach>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>   
        <!-- Section-->
        <section class="py-5">
            <div class="container px-4 px-lg-5 mt-5">
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
                                    <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="public/product-detail?id=${p.productId}">View details</a></div>
                                </div>
                            </div>
                        </div>
                    </c:forEach> 
                </div>
                <div class="row d-flex justify-content-center">
                    <a class="btn btn-primary col-lg-2" href="public/list-product">See more</a>
                </div>
            </div>   
        </section>

        <!-- Section-->
        <hr>
        <h2 class="text-center">Try Our Blogs</h2>
        <section class="py-5 d-flex justify-content-center">
            <div id="posts" class="mt-5 col-lg-9">
                
                <div class="row">
                    <c:forEach var="post" items="${posts}">
                        <div class="col-md-4 mb-4">
                            <div class="card">
                                <a href="public/post-detail?id=${post.id}">
                                    <img src="${post.imgURL}" class="card-img-top" alt="${post.title}">
                                    <div class="card-body">
                                        <h5 class="card-title">${post.title}</h5>
                                        <p class="card-text">${fn:substring(post.content, 0, 50)}...</p>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="row d-flex justify-content-center">
                    <a class="btn btn-primary col-lg-2" href="public/list-blog">See more</a>
                </div>
            </div>
            
        </section>            

        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>

        <script>
            function valid(input) {
                input.value = input.value.replace(/[^0-9]/g, '');
                if (input.value > ${endPage})
                    input.value = ${endPage};
                if (input.value < 1)
                    input.value = 1;
            }

        </script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script>
            $(document).ready(function () {
                $('.carousel').carousel({
                    interval: 3000,
                    pause: 'hover'
                });
            });
        </script>
        <!-- đáy -->
        <jsp:include page="footer.html"></jsp:include>
    </body>
</html>
