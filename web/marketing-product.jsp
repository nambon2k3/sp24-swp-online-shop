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

        <div class="container mt-5 main-content">
            <h2>Product List</h2>

            <c:if test="${param.success ne null}">
                <div class="alert alert-success" role="alert">
                    Update success!
                </div>
            </c:if>
            <c:if test="${param.fail ne null}">
                <div class="alert alert-danger" role="alert">
                    Update failed!
                </div>
            </c:if>

            <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addProductModal">
                Add Product
            </button>

            <!-- Filter Form -->
            <form id="searchForm" action="product" method="get" class="form-inline mb-3">
                <div class="form-group mr-2">
                    <input type="text" class="form-control" name="name" placeholder="Product Name" value="${name}">
                </div>
                <div class="form-group mr-2">
                    <input type="text" class="form-control" name="category" placeholder="Category" value="${category}">
                </div>
                <div class="form-group mr-2">
                    <select class="form-control" name="isDeleted">
                        <option value="">Select Status</option>
                        <option value="true" ${isDeletedString eq 'true' ? 'selected' : ''}>Inactive</option>
                        <option value="false" ${isDeletedString eq 'false' ? 'selected' : ''}>Active</option>
                    </select>
                </div>
                <input type="hidden" name="page" id="pageInput" value="1">
                <button type="submit" class="btn btn-primary mt-3">Search</button>
            </form>

            <!-- Product Table -->
            <table id="productTable" class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product Name</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${productList}">
                        <tr>
                            <td>${product.productId}</td>
                            <td>${product.productName}</td>
                            <td>${product.categoryName}</td>
                            <td>${product.detail.price}</td>
                            <td>${product.detail.stock}</td>
                            <td>${product.isDeleted ? 'Inactive' : 'Active'}</td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#productInfoModal_${product.productId}">Info</button>
                                <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editProductModal_${product.productId}">Edit</button>
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
            <div class="modal fade" id="editProductModal_${product.productId}" tabindex="-1" role="dialog" aria-labelledby="editProductModalLabel_${product.productId}" aria-hidden="true">
                <!-- Modal Content -->
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title" id="editProductModalLabel_${product.productId}">Edit Product</h5>
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
                                    <label for="productName">Product Name</label>
                                    <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" required>
                                </div>
                                <div class="form-group">
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
                                    <label for="isDeleted">Is Deleted</label>
                                    <select class="form-control" id="isDeleted" name="isDeleted">
                                        <option value="false" ${!product.isDeleted ? 'selected' : ''}>Active</option>
                                        <option value="true" ${product.isDeleted ? 'selected' : ''}>Inactive</option>
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
            <div class="modal fade" id="productInfoModal_${product.productId}" tabindex="-1" role="dialog" aria-labelledby="productInfoModalLabel_${product.productId}" aria-hidden="true">
                <!-- Modal Content -->
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <!-- Modal Header -->
                        <div class="modal-header">
                            <h5 class="modal-title" id="productInfoModalLabel_${product.productId}">Product Details</h5>
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
                                        <th>Quantity</th>
                                        <td>${product.detail.stock}</td>
                                    </tr>
                                    <tr>
                                        <th>Price</th>
                                        <td>${product.detail.price}</td>
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
    </body>
</html>
