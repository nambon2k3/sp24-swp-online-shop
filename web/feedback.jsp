<%-- 
    Document   : cart
    Created on : Jun 4, 2024, 7:18:47 PM
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
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
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
                    <form method="get" action="cart" class="mr-0">
                        <div id="product-search">
                            <h3>Search Products</h3>
                            <input type="text" id="search-box" name="searchQuery" placeholder="Search for products..." class="form-control" value="${param.searchQuery}">
                    </div>
                    <div class="form-group">
                        <label for="category">Category:</label>
                        <select id="category" name="category" class="form-control">
                            <option value="">All</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.categoryName}" ${param.category == cat.categoryName ? 'selected' : ''}>${cat.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Filter</button>
                </form>
                <div id="latest-products">
                    <h3>Latest Products</h3>
                    <c:forEach items="${products}" var="p">
                        <a id="product" href="product-detail?id=${p.productId}" style="text-decoration: none; color: black;">
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

                <h2>Product Detail</h2>
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
                        <tr>
                            <td><img src="${product.productDetail.imageURL}" alt="..." width="100" height="100"></td>
                            <td>${product.productDetail.getProductName()}</td>
                            <td>${product.productDetail.getCateogryName()}</td>
                            <td>$${product.productDetail.discount != null &&  product.productDetail.discount != 0 ? (product.productDetail.price * (100-product.productDetail.discount)/100) : product.productDetail.price}</td>
                            <td>${product.quantity}</td>
                            <td>$${product.productDetail.discount != null &&  product.productDetail.discount != 0 ? (product.productDetail.price * (100-product.productDetail.discount)/100)*(product.quantity) : product.productDetail.price*product.quantity}</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/public/product-detail?id=${product.productDetail.productId}&pdid=${product.productDetail.productDetailId}" class="btn btn-primary">Re-buy</a>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <br>
                <h2>Feedback Contact</h2>
                <form id="uploadForm" action="feedback" method="post">
                    <input type="hidden" name="imageBase64" id="imageBase64">
                    <input type="hidden" name="id" value="${product.id}">
                    <table class="table table-borderless">
                        <tr>
                            <td>Full Name:</td>
                            <td><input type="text" class="form-control" name="fullname" value="${sessionScope.user.fullname}"></td> 
                        </tr>
                        <tr>
                            <td>Gender:</td>
                            <td><input type="text" class="form-control" name="gender" value="${sessionScope.user.gender}"></td> 
                        </tr>
                        <tr>
                            <td>Email:</td>
                            <td><input type="text" class="form-control" name="email" value="${sessionScope.user.email}"></td> 
                        </tr>
                        <tr>
                            <td>Phone:</td>
                            <td><input type="text" class="form-control" name="phone" value="${sessionScope.user.phone}"></td> 
                        </tr>
                        <tr>
                            <td>Rating:</td>
                            <td>
                                <div class="d-flex">
                                    <div class="mr-5">
                                        <input type="radio"  name="rate" checked value="1"> <i class='bx bxs-star'></i>
                                    </div>
                                    <div class="mr-5">
                                        <input type="radio"  name="rate" value="2"> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i>
                                    </div>
                                    <div class="mr-5">
                                        <input type="radio"name="rate" value="3"> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i>
                                    </div>
                                    <div class="mr-5">
                                        <input type="radio" name="rate" value="4"> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i>
                                    </div>
                                    <div>
                                        <input type="radio"  name="rate" value="5"> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i> <i class='bx bxs-star'></i>
                                    </div>
                                </div>

                            </td> 
                        </tr>
                        <tr>
                            <td>Image</td>
                            <td><input id="file" type="file" name="file" class="form-control"  name="address"></td> 
                        </tr>
                        <tr>
                            <td>Comment: </td>
                            <td><input type="text" class="form-control" name="comment" value=""></td> 
                        </tr>
                        <tr>
                            <td colspan="2">
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </td>
                        </tr>
                    </table>


                </form>

            </div>

        </div>

    </body>
    
    <script>
        document.getElementById('uploadForm').addEventListener('submit', function(event) {
            const fileInput = document.getElementById('file');
            const file = fileInput.files[0];

            if (file) {
                event.preventDefault(); // Prevent form submission until image is processed

                const reader = new FileReader();
                reader.onloadend = function() {
                    const base64String = reader.result.split(',')[1];
                    document.getElementById('imageBase64').value = base64String;

                    // Now submit the form
                    document.getElementById('uploadForm').submit();
                }
                reader.readAsDataURL(file);
            }
        });
    </script>

</html>


</body>

</html>
