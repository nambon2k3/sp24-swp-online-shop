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
        <style>
            .colors {
                -webkit-box-flex: 1;
                -webkit-flex-grow: 1;
                -ms-flex-positive: 1;
                flex-grow: 1;
            }
            .product-title, .price, .sizes, .colors {
                text-transform: UPPERCASE;
                font-weight: bold;
            }

            .checked, .price span {
                color: #ff9f1a;
            }

            .product-title, .rating, .product-description, .price, .vote, .sizes {
                margin-bottom: 15px;
            }
            .size {
                margin-right: 10px;
            }
            .size:first-of-type {
                margin-left: 40px;
            }

            .color {
                display: inline-block;
                vertical-align: middle;
                margin-right: 10px;
                height: 2em;
                width: 2em;
                border-radius: 2px;
            }
            .color:first-of-type {
                margin-left: 20px;
            }

            .size.active{
                background-color: black;
                color: white
            }
            .size:hover {
                cursor: pointer;
                background-color: #555252
            }
        </style>
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
                                    <div class="text-center mt-3">
                                        <button  type="button" class="btn btn-outline-dark mt-auto text-center" data-bs-toggle="modal" data-bs-target="#exampleModal-${p.productId}">
                                            Add To Cart
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Modal -->
                        <div class="modal fade" id="exampleModal-${p.productId}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalLabel">Choose type</h1>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <h3 class="product-title">${p.productName}</h3>
                                        <p class="product-description">${product.description}</p>
                                        <h4 class="price">current price: <span><span style="color: grey; text-decoration: line-through; margin: 0 10px">${p.productDetail.price}$</span> ${p.productDetail.price * (1 - p.productDetail.discount/100)}$ </span></h4>
                                        <p class="vote"><strong>91%</strong> of buyers enjoyed this product! <strong>(87 votes)</strong></p>
                                        <h5 class="sizes">sizes:
                                            <span style="margin-right: 20px"></span>
                                            <c:forEach items="${p.listProductDetail}" var="pd">
                                                <span class="color size ${pd.size == p.productDetail.size ? 'active' : ''}" onclick="toggleActive(this, ${pd.productDetailId}, '${pd.color}', ${pd.stock})" data-toggle="tooltip" style="border: 1px solid black; text-align: center; align-content: center;" title="small">
                                                    ${pd.size}
                                                </span>
                                            </c:forEach>
                                        </h5>
                                        <h5 class="sizes">colors:
                                            <span id="selectedColor" class="color" style="background-color:  ${p.productDetail.color.toLowerCase()}"></span>
                                        </h5>
                                        <h5 class="colors">Quantity: 
                                            <input oninput="valid2(this)" id="quantity" type="text" style="padding: 5px; width: 200px"  value="1" name="quantity"> 
                                            <span style="font-weight: normal; font-style: italic; font-size: 16px"> (Available: <span id="stock">${p.productDetail.stock}</span>) </span>
                                        </h5>
                                        <input type="hidden" id="selectedProductDetailId" name="selectedProductDetailId" value="${p.productDetail.productDetailId}" />
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                                        <button type="button" class="btn btn-primary" onclick="addToCart(${p.productDetail.productDetailId})">Submit</button>
                                    </div>
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


                                            function toggleActive(element, productDetailId, color, stock) {
                                                // Remove 'active' class from all spans
                                                document.querySelectorAll('.color.size').forEach(span => {
                                                    span.classList.remove('active');
                                                });

                                                // Add 'active' class to the clicked span
                                                element.classList.add('active');
                                                document.getElementById('stock').innerHTML = stock;
                                                // Update the hidden input with the selected ProductDetail ID
                                                document.getElementById('selectedProductDetailId').value = productDetailId;

                                                // Update the color display
                                                document.getElementById('selectedColor').style.backgroundColor = color.toLowerCase();
                                            }
                                            function addToCart(id) {
                                            let quantity = document.getElementById('quantity').value;
                                            console.log(quantity);
                                            fetch('add-cart?id=' + id + '&quantity=' + quantity);
                                            window.alert('ADDED Successfully');
                                        }


        </script>

        <script>
            function valid2(input) {
                input.value = input.value.replace(/[^0-9]/g, '');
                if (input.value - document.getElementById('stock').innerHTML > 0)
                    input.value = document.getElementById('stock').innerHTML;
                if (input.value < 1)
                    input.value = 1;
            }
        </script>
        <!-- đáy -->
        <jsp:include page="footer.html"></jsp:include>
    </body>
</html>
