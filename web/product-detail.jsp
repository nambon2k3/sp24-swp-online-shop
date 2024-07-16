<%-- 
    Document   : product-detail
    Created on : May 18, 2024, 5:58:36 PM
    Author     : Legion
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="DAO.CartDAO"%>
<%@page import="Model.User"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Detail</title>
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <link rel="stylesheet" href="../css/styles.css">

        <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,700" rel="stylesheet">    
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="../css/pdetail.css">

        <style>
            #navbarSupportedContent {
                display: flex !important
            }
            button:hover {
                color: white
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
    <body class="d-flex flex-column justify-content-between" style="height: 100vh">
        <jsp:include page="header.jsp"></jsp:include>
            <div class="container" style="margin-bottom: 100px">
                <div class="card">
                    <div class="container-fliud">
                        <div class="wrapper row">
                            <form id="form" action="payment" method="post">
                                <div class="preview col-md-6">
                                    <div class="preview-pic tab-content">
                                        <div class="tab-pane active" id="pic-1"><img src="${product.productDetail.imageURL}" /></div>
                                </div>
                                <ul class="preview-thumbnail nav nav-tabs">
                                    <c:forEach items="${listDetails}" var="pd">
                                        <li class="active"><a href="product-detail?pdid=${pd.productDetailId}&id=${product.productId}"><img
                                                    src="${pd.imageURL}"/></a></li>
                                            </c:forEach>
                                </ul>
                            </div>
                            <div class="details col-md-6">
                                <h3 class="product-title">${product.productName}</h3>
                                <div class="rating">
                                    <div class="stars">
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star checked"></span>
                                        <span class="fa fa-star"></span>
                                        <span class="fa fa-star"></span>
                                    </div>
                                    <span class="review-no">41 reviews</span>
                                </div>
                                <p class="product-description">${product.description}</p>
                                <h4 class="price">current price: <span><span style="color: grey; text-decoration: line-through; margin: 0 10px">${product.productDetail.price}$</span> ${product.productDetail.price * (1 - product.productDetail.discount/100)}$ </span></h4>
                                <p class="vote"><strong>91%</strong> of buyers enjoyed this product! <strong>(87 votes)</strong></p>
                                <h5 class="sizes">sizes:
                                    <span style="margin-right: 20px"></span>
                                    <c:forEach items="${listDetails}" var="pd">
                                        <span class="color size ${pd.size == product.productDetail.size ? 'active' : ''}" data-toggle="tooltip" style="border: 1px solid black; text-align: center; align-content: center;" onclick="window.location.href = 'product-detail?pdid=${pd.productDetailId}&id=${product.productId}'" title="small">
                                            ${pd.size}
                                        </span>
                                    </c:forEach>
                                </h5>
                                <h5 class="sizes">colors:
                                    <span class="color" style="background-color:  ${product.productDetail.color.toLowerCase()}"></span>
                                </h5>
                                <h5 class="colors">Quantity: 
                                    <input oninput="valid(this)" id="quantity" type="text" style="padding: 5px" value="1" name="quantity"> 
                                    <input  type="hidden" id="productdetailId" value="${product.productDetail.productDetailId}" name="productdetailId"> 
                                    <input  type="hidden"  name="mode" value="buy&feedback"> 
                                    <input  type="hidden"  name="bankcode" value="NCB">
                                    <input  type="hidden"  name="amount" id="amount" value=""> 
                                    <span style="font-weight: normal; font-style: italic"> (Available: ${product.productDetail.stock - product.productDetail.hold}) </span>
                                </h5>
                                <div class="action">
                                    <button class="add-to-cart btn btn-default" type="button" onclick="addToCart(${product.productDetail.productDetailId})">add to cart</button>
                                </div>
                            </div>
                        </form>

                    </div>
                </div>
            </div>
            <div class="card">
                <h3>Product Feedback</h3>
                <div class="card-body">
                    <c:forEach var="feedback" items="${feedbackList}">
                        <div class="feedback mb-2" style="border: 1px solid lightgray; padding: 15px; background-color: white">

                            <div class="d-flex">
                                <div class="mr-5">
                                    <strong>Rating:</strong>
                                    <c:forEach begin="1" end="${feedback.rating}">
                                        <i style="color: orange" class='bx bxs-star'></i>
                                    </c:forEach>
                                </div>
                            </div>
                            <p><strong>Image:</strong> ${feedback.image}</p>
                            <p><strong>Comment:</strong> ${feedback.comment}</p>
                            <p><strong>Created By:</strong> ${feedback.userName}</p>
                            <p style="text-align: right">
                                <small style="font-style: italic">Created At: ${feedback.createdAt}</small>
                            </p>
                        </div>
                    </c:forEach>
                </div>
                <div class="pagination">
                    <c:if test="${currentPage > 1}">
                        <a href="productFeedback?productDetailID=&page=${currentPage - 1}">Previous</a>
                    </c:if>
                    <c:if test="${feedbackList.size() == 10}">
                        <a href="productFeedback?productDetailID=&page=${currentPage + 1}">Next</a>
                    </c:if>
                </div>
            </div>

        </div>

        <jsp:include page="footer.html"></jsp:include>
            <!-- Bootstrap core JS-->
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
            <!-- Core theme JS-->
            <script src="../js/scripts.js"></script>
            <script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
            <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
            <script defer>
                                        function valid(input) {
                                            input.value = input.value.replace(/[^0-9]/g, '');
                                            if (input.value > ${product.productDetail.stock})
                                                input.value = ${product.productDetail.stock};
                                            if (input.value < 1)
                                                input.value = 1;
                                        }
                                        function addToCart(id) {
                                            let quantity = document.getElementById('quantity').value;
                                            console.log(quantity);
                                            fetch('add-cart?id=' + id + '&quantity=' + quantity);
                                            window.alert('ADDED Successfully');
                                        }

                                        document.getElementById('form').addEventListener('submit', function (event) {
                                            event.preventDefault(); // Prevent form submission until image is processed
                                            document.getElementById('amount').value = (document.getElementById('quantity').value * 100 * ${product.productDetail.price * (1 - product.productDetail.discount/100)});
                                            document.getElementById('form').submit();
                                        });
        </script>
    </body>
</html>
