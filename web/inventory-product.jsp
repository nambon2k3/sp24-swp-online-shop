<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product List</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- DataTable CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">
        <!-- Font Awesome CSS for icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/choices.js/public/assets/styles/choices.min.css">
        <script src="https://cdn.jsdelivr.net/npm/choices.js/public/assets/scripts/choices.min.js"></script>

        <style>
            .modal-lg {
                max-width: 80%;
            }

            .table th, .table td {
                vertical-align: middle;
            }

        </style>
    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="inventory-sidebar.jsp" %>

        <div class="mt-5 main-content">
            <h2>Product List</h2>

            <c:if test="${param.success ne null}">
                <div class="alert alert-success" role="alert">
                    Success!
                </div>
            </c:if>
            <c:if test="${param.fail ne null}">
                <div class="alert alert-danger" role="alert">
                    Failed!
                </div>
            </c:if>

            <!-- Filter Form -->
            <form id="searchForm" action="list-product" method="get" class="d-flex mb-4 justify-content-between">
                <input type="hidden" name="page" id="pageInput" value="1">
                <div class="form-group mr-2 col-2">
                    <input class="form-control me-2 mb-4" type="search" name="searchQuery" placeholder="Search" aria-label="Search" value="${searchQuery}">
                </div>

                <div class="form-group mr-2  col-2">
                    <select class="form-control me-2 mb-4" name="categoryId">
                        <option value="">All Categories</option>
                        <c:forEach items="${categories}" var="category">
                            <option value="${category.ID}" <c:if test="${categoryId == category.ID}">selected</c:if>>${category.categoryName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group mr-2  col-2">
                    <input class="form-control me-2 mb-4" type="number" name="minPrice" placeholder="Min Price" value="${minPrice}">
                    <input class="form-control me-2 mb-4" type="number" name="maxPrice" placeholder="Max Price" value="${maxPrice}">
                </div>

                <div class="form-group mr-2  col-2">
                    <select class="form-control me-2 mb-4" name="color">
                        <option value="">All Colors</option>
                        <c:forEach items="${colors}" var="color">
                            <option value="${color}" <c:if test="${selectedColor == color}">selected</c:if>>${color}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-group mr-2  col-2">
                    <select class="form-control me-2 mb-4" name="size">
                        <option value="">All Sizes</option>
                        <c:forEach items="${sizes}" var="size">
                            <option value="${size}" <c:if test="${selectedSize == size}">selected</c:if>>${size}</option>
                        </c:forEach>
                    </select>
                </div>


                <div class="form-group mr-2">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </div>
            </form>

            <!-- Product Table -->
            <table id="productTable" class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th style="width: 20%">Image</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Size</th>
                        <th>Color</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${productList}">
                        <tr>
                            <td>${product.productId}</td>
                            <td style="width: 20%" class="text-center"><img class="w-50 rounded" src="${product.thumb}"></td>
                            <td>${product.productName}</td>
                            <td>${product.categoryName}</td>
                            <td>${product.productDetail.price}</td>
                            <td>${product.productDetail.stock}</td>
                            <td>${product.productDetail.size}</td>
                            <td>${product.productDetail.color}</td>
                            <td>${product.isDeleted ? 'Inactive' : 'Active'}</td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#productInfoModal_${product.productDetail.productDetailId}">Edit</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Pagination -->
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item">
                        <button class="page-link" onclick="submitFormWithPage(1)" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </button>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" step="1" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <button class="page-link" onclick="submitFormWithPage(${i})">${i}</button>
                        </li>
                    </c:forEach>
                    <li class="page-item">
                        <button class="page-link" onclick="submitFormWithPage(${totalPages})" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </button>
                    </li>
                </ul>
            </nav>
        </div>
        <!-- Edit Product Modals -->
        <c:forEach var="product" items="${productList}">
            <!-- Product Info Modal -->
            <div class="modal fade" id="productInfoModal_${product.productDetail.productDetailId}" tabindex="-1" role="dialog" aria-labelledby="productInfoModalLabel_${product.productDetail.productDetailId}" aria-hidden="true">
                <!-- Modal Content -->
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title" id="productInfoModalLabel_${product.productDetail.productDetailId}">Product Details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <!-- Modal Body -->
                        <div class="modal-body">

                            <div class="text-center">
                                <img class="w-25" src="${product.thumb}">
                            </div>
                            <form action="list-product" method="post">
                                <input type="hidden" name="productDetailId" value="${product.productDetail.productDetailId}">
                                <!-- Product Info Table -->
                                <table class="table table-bordered">
                                    <tbody>
                                        <tr>
                                            <th>ID</th>
                                            <td>${product.productId}</td>
                                        </tr>
                                        <tr>
                                            <th>Product Name</th>
                                            <td>${product.productName}</td>
                                        </tr>
                                        <tr>
                                            <th>Size</th>
                                            <td>${product.productDetail.size}</td>
                                        </tr>
                                        <tr>
                                            <th>Color</th>
                                            <td>${product.productDetail.color}</td>
                                        </tr>
                                        <tr>
                                            <th>Category</th>
                                            <td>${product.categoryName}</td>
                                        </tr>
                                        <tr>
                                            <th>Created At</th>
                                            <td>${product.createdAt}</td>
                                        </tr>
                                        <tr>
                                            <th>Description</th>
                                            <td>${product.description}</td>
                                        </tr>
                                        <tr>
                                            <th>Price</th>
                                            <td>${product.productDetail.price}</td>
                                        </tr>
                                        <tr>
                                            <th>Quantity</th>
                                            <td>
                                                <input class="form-control" type="number" name="quantity" value="${product.productDetail.stock}">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Hold</th>
                                            <td>
                                                <input class="form-control" type="number" name="hold" value="${product.productDetail.hold}">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>Import Price</th>
                                            <td>
                                                <input class="form-control" type="number" name="importPrice" value="${product.productDetail.importPrice}">
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                                <input class="form-control btn btn-success" type="submit" value="Update">
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        


        <!-- jQuery and Bootstrap Bundle (includes Popper) -->
        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
        <!-- DataTables -->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>


        <script>
                                    $(document).ready(function () {
                                        // Initialize DataTable
                                        $('#productTable').DataTable({
                                            "paging": false,
                                            "lengthChange": false,
                                            "searching": false,
                                            "ordering": true,
                                            "info": false,
                                            "autoWidth": false
                                        });
                                    });

                                    // Function to submit form with page number
                                    function submitFormWithPage(page) {
                                        $('#pageInput').val(page);
                                        $('#searchForm').submit();
                                    }
        </script>

        <script>
            function updateImage(sliderId) {
                let fileInput = document.getElementById(`imageFile` + sliderId);
                let image = document.getElementById(`image` + sliderId);
                let hiddenInput = document.getElementById(`imageUrl` + sliderId);
                console.log(fileInput, image, hiddenInput)

                // check file uploaded
                if (fileInput.files && fileInput.files[0]) {
                    const file = fileInput.files[0];
                    const maxSize = 2 * 1024 * 1024; // 2 MB in bytes

                    if (file.size > maxSize) {
                        alert("The selected file is too large. Please select a file smaller than 2 MB.");
                        fileInput.value = ''; // Clear the file input
                        return;
                    }

                    // dịch image thành url
                    const reader = new FileReader();

                    reader.onload = function (e) {
                        // Update the image src
                        image.src = e.target.result;

                        // Optionally, update the hidden input with the base64 data URL
                        hiddenInput.value = e.target.result;
                    };

                    reader.readAsDataURL(file);
                }
            }
        </script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                let elements = document.getElementsByClassName('sizeSelect');
                Array.from(elements).forEach(element => {
                    const choices = new Choices(element, {
                        removeItemButton: true,
                        searchResultLimit: 5,
                        renderChoiceLimit: 5,
                        placeholderValue: 'Select option',
                        searchPlaceholderValue: 'Search option',
                    });
                });

                elements = document.getElementsByClassName('colorSelect');
                Array.from(elements).forEach(element => {
                    const choices = new Choices(element, {
                        removeItemButton: true,
                        searchResultLimit: 5,
                        renderChoiceLimit: 5,
                        placeholderValue: 'Select option',
                        searchPlaceholderValue: 'Search option',
                    });
                });
            });
        </script>

    </body>
</html>
