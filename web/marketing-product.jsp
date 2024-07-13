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
        <%@ include file="marketing-sidebar.jsp" %>

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

            <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addProductModal">
                Add Product
            </button>

            <!-- Filter Form -->
            <form id="searchForm" action="product" method="get" class="d-flex mb-4 justify-content-between">
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
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#productInfoModal_${product.productDetail.productDetailId}">Info</button>
                                <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editProductModal_${product.productDetail.productDetailId}">Edit</button>
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
            <!-- Edit Product Modal -->
            <div class="modal fade" id="editProductModal_${product.productDetail.productDetailId}" tabindex="-1" role="dialog" aria-labelledby="editProductModalLabel_${product.productDetail.productDetailId}" aria-hidden="true">
                <!-- Modal Content -->
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProductModalLabel_${product.productDetail.productDetailId}">Edit Product</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <!-- Modal Body -->
                        <div class="modal-body">
                            <!-- Edit Product Form -->
                            <form action="product" method="post">
                                <!-- Hidden Field -->
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <div class="form-group">
                                    <label for="imageUrl">Image</label>
                                    <img id="image${product.productId}" class="w-100" src="${product.thumb}">
                                    <input type="file" class="form-control" id="imageFile${product.productId}" accept="image/*" onchange="updateImage(${product.productId})">
                                    <input type="hidden" class="form-control" id="imageUrl${product.productId}" name="imageUrl" value="${product.thumb}">
                                </div>
                                <div class="form-group">
                                    <label for="productName">Product Name</label>
                                    <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" required>
                                </div>
                                <div class="form-group d-none">
                                    <label for="categoryName">Category</label>
                                    <input type="text" class="form-control" id="categoryName" name="categoryName" value="${product.categoryName}" required>
                                </div>
                                <div class="form-group">
                                    <label for="description">Description</label>
                                    <textarea class="form-control" id="description" name="description" rows="3">${product.description}</textarea>
                                </div>
                                <div class="form-group d-none">
                                    <label for="createdBy">Created By</label>
                                    <input type="text" class="form-control" id="createdBy" name="createdBy" value="${product.createdBy}" required>
                                </div>
                                <div class="form-group">
                                    <label for="productName">Price</label>
                                    <input type="text" class="form-control" id="price" name="price" value="${product.productDetail.price}" required>
                                </div>
                                <div class="form-group">
                                    <label>Size</label>
                                    <select class=" form-control" name="size" required>
                                        <option value="S" ${product.productDetail.size eq 'S' ? 'selected' : ''}>S</option>
                                        <option value="M" ${product.productDetail.size eq 'M' ? 'selected' : ''}>M</option>
                                        <option value="L" ${product.productDetail.size eq 'L' ? 'selected' : ''}>L</option>
                                        <option value="XL" ${product.productDetail.size eq 'XL' ? 'selected' : ''}>XL</option>
                                        <option value="XXL" ${product.productDetail.size eq 'XXL' ? 'selected' : ''}>XXL</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label>Color</label>
                                    <select class="form-control" name="color" required>
                                        <option value="Red" ${product.productDetail.color eq 'Red' ? 'selected' : ''}>Red</option>
                                        <option value="Green" ${product.productDetail.color eq 'Green' ? 'selected' : ''}>Green</option>
                                        <option value="Blue" ${product.productDetail.color eq 'Blue' ? 'selected' : ''}>Blue</option>
                                        <option value="Yellow" ${product.productDetail.color eq 'Yellow' ? 'selected' : ''}>Yellow</option>
                                        <option value="Black" ${product.productDetail.color eq 'Black' ? 'selected' : ''}>Black</option>
                                        <option value="White" ${product.productDetail.color eq 'White' ? 'selected' : ''}>White</option>
                                        <option value="Purple" ${product.productDetail.color eq 'Purple' ? 'selected' : ''}>Purple</option>
                                        <option value="Orange" ${product.productDetail.color eq 'Orange' ? 'selected' : ''}>Orange</option>
                                        <option value="Pink" ${product.productDetail.color eq 'Pink' ? 'selected' : ''}>Pink</option>
                                        <option value="Brown" ${product.productDetail.color eq 'Brown' ? 'selected' : ''}>Brown</option>
                                        <option value="Gray" ${product.productDetail.color eq 'Gray' ? 'selected' : ''}>Gray</option>
                                        <option value="Teal" ${product.productDetail.color eq 'Teal' ? 'selected' : ''}>Teal</option>
                                        <option value="Maroon" ${product.productDetail.color eq 'Maroon' ? 'selected' : ''}>Maroon</option>
                                        <option value="Navy" ${product.productDetail.color eq 'Navy' ? 'selected' : ''}>Navy</option>
                                        <option value="Olive" ${product.productDetail.color eq 'Olive' ? 'selected' : ''}>Olive</option>
                                        <option value="Lime" ${product.productDetail.color eq 'Lime' ? 'selected' : ''}>Lime</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="productName">Quantity</label>
                                    <input type="text" class="form-control" id="quantity" name="quantity" value="${product.productDetail.stock}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="productName">Hold</label>
                                    <input type="text" class="form-control" id="quantity" name="hold" value="${product.productDetail.hold}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="productName">Import Price</label>
                                    <input type="text" class="form-control" id="quantity" name="importPrice" value="${product.productDetail.importPrice}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="isDeleted">Is Deleted</label>
                                    <select class="form-control" id="isDeleted" name="isDeleted">
                                        <option value="false" ${!product.isDeleted ? 'selected' : ''}>Active</option>
                                        <c:if  test="${product.productDetail.stock > 0}">
                                            <option value="true" ${product.isDeleted ? 'selected' : ''}>Inactive</option>
                                        </c:if>
                                    </select>
                                </div>
                                <!-- Add other fields as needed -->
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

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
                                            ${product.productDetail.stock}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Hold</th>
                                        <td>
                                            ${product.productDetail.hold}
                                        </td>
                                    </tr>
                                    <tr>
                                        <th>Import Price</th>
                                        <td>
                                            ${product.productDetail.importPrice}
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- Add Product Modal -->
        <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <form id="addProductForm" action="product" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="imageUrl">Image</label>
                                <img id="image0" class="w-100" src="">
                                <input type="file" class="form-control" id="imageFile0" accept="image/*" onchange="updateImage(0)" required>
                                <input type="hidden" class="form-control" id="imageUrl0" name="imageUrl" value="">
                            </div>
                            <div class="form-group">
                                <label for="productName">Product Name</label>
                                <input type="text" class="form-control" id="productName" name="productName" required>
                            </div>
                            <div class="form-group">
                                <label for="categoryId">Category</label>
                                <select class="form-control" id="categoryId" name="categoryId" required>
                                    <c:forEach var="category" items="${categories}">
                                        <option value="${category.getID()}">${category.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="price">Price</label>
                                <input type="text" class="form-control" id="price" name="price" required>
                            </div>
                            <div class="form-group">
                                <label for="quantity">Quantity</label>
                                <input type="text" class="form-control" id="quantity" name="quantity" required>
                            </div>
                            <div class="form-group">
                                <label>Size</label>
                                <select class="sizeSelect form-control" name="size" multiple required>
                                    <option value="M">S</option>
                                    <option value="M">M</option>
                                    <option value="L">L</option>
                                    <option value="XL">XL</option>
                                    <option value="XXL">XXL</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Color</label>
                                <select class="colorSelect form-control" name="color" multiple required>
                                    <option value="Red">Red</option>
                                    <option value="Green">Green</option>
                                    <option value="Blue">Blue</option>
                                    <option value="Yellow">Yellow</option>
                                    <option value="Black">Black</option>
                                    <option value="White">White</option>
                                    <option value="Purple">Purple</option>
                                    <option value="Orange">Orange</option>
                                    <option value="Pink">Pink</option>
                                    <option value="Brown">Brown</option>
                                    <option value="Gray">Gray</option>
                                    <option value="Teal">Teal</option>
                                    <option value="Maroon">Maroon</option>
                                    <option value="Navy">Navy</option>
                                    <option value="Olive">Olive</option>
                                    <option value="Lime">Lime</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="description">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="3"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Add Product</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


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
