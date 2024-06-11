<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback List</title>
        <!-- Bootstrap CSS -->
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <!-- DataTable CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/dataTables.bootstrap4.min.css">
        <!-- Font Awesome CSS for icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <!-- Sidebar -->
        <%@ include file="marketing-sidebar.jsp" %>

        <div class="container mt-5 main-content">
            <h2>Feedback List</h2>

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

            <!--filter form-->
            <form id="searchForm" action="feedback" method="get" class="form-inline mb-3">
                <div class="form-group mr-2">
                    <input type="text" class="form-control" name="searchComment" placeholder="Search comment"value="${searchComment}">
                </div>
                <div class="form-group mr-2">
                    <input type="text" class="form-control" name="searchName" placeholder="Search product"value="${searchName}">
                </div>
                <div class="form-group mr-2">
                    <input type="text" class="form-control" name="searchFullName" placeholder="Search fullname"value="${searchFullName}">
                </div>
                <div class="form-group mr-2">
                    <select class="form-control" name="rating">
                        <option value="">Select Rating</option>
                        <option value="1" ${rating eq '1' ? 'selected' : ''}>1</option>
                        <option value="2" ${rating eq '2' ? 'selected' : ''}>2</option>
                        <option value="3" ${rating eq '3' ? 'selected' : ''}>3</option>
                        <option value="4" ${rating eq '4' ? 'selected' : ''}>4</option>
                        <option value="5" ${rating eq '5' ? 'selected' : ''}>5</option>
                    </select>
                </div>
                <div class="form-group mr-2">
                    <select class="form-control" name="status">
                        <option value="">Select Status</option>
                        <option value="true" ${isDeleted ? 'selected' : ''}>Inactive</option>
                        <option value="false" ${!isDeleted ? 'selected' : ''}>Active</option>
                    </select>
                </div>
                <input type="hidden" name="page" id="pageInput" value="1">
                <button type="submit" class="btn btn-primary mt-3">Search</button>
            </form>

            <table id="feedbackTable" class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Product</th>
                        <th>Rating</th>
                        <th>Comment</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="feedback" items="${feedbackList}">
                        <tr>
                            <td>${feedback.id}</td>
                            <td>${feedback.orderDetail.productDetail.product.productName}</td>
                            <td>${feedback.rating}</td>
                            <td>${fn:substring(feedback.comment, 0, 30)}...</td>
                            <td>${feedback.isDeleted ? 'Inactive' : 'Active'}</td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#feedbackInfoModal_${feedback.id}">Info</button>
                                <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editFeedbackModal_${feedback.id}">Edit</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

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

        <c:forEach var="feedback" items="${feedbackList}">

            <!-- Edit Feedback Modal -->
            <div class="modal fade" id="editFeedbackModal_${feedback.id}" tabindex="-1" role="dialog" aria-labelledby="editFeedbackModalLabel_${feedback.id}" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editFeedbackModalLabel_${feedback.id}">Edit Feedback</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!-- Edit Feedback Form -->
                            <form action="feedback" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="feedbackId" value="${feedback.id}">
                                <div class="form-group d-none">
                                    <label for="orderDetailId">Order Detail ID</label>
                                    <input type="text" class="form-control" id="orderDetailId" name="orderDetailId" value="${feedback.orderDetailId}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="rating">Rating</label>
                                    <input type="number" class="form-control" id="rating" name="rating" value="${feedback.rating}" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="comment">Comment</label>
                                    <textarea class="form-control" id="comment" name="comment"readonly>${feedback.comment}</textarea>
                                </div>
                                <div class="form-group">
                                    <label for="status">Status</label>
                                    <select class="form-control" id="status" name="isDeleted">
                                        <option value="false" ${!feedback.isDeleted ? "selected" : ""}>Active</option>
                                        <option value="true" ${feedback.isDeleted ? "selected" : ""}>Inactive</option>
                                    </select>
                                </div>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Feedback Info Modal -->
            <div class="modal fade" id="feedbackInfoModal_${feedback.id}" tabindex="-1" role="dialog" aria-labelledby="feedbackInfoModalLabel_${feedback.id}" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="feedbackInfoModalLabel_${feedback.id}">Feedback Details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <p><strong>ID:</strong> ${feedback.id}</p>
                            
                            <p>
                               <strong>User:</strong> ${feedback.orderDetail.order.fullname} <br>
                               <strong>Address:</strong> ${feedback.orderDetail.order.address} <br>
                               <strong>Phone:</strong> ${feedback.orderDetail.order.phone} <br>
                            </p>
                            <p>
                                <strong>Product:</strong> ${feedback.orderDetail.productDetail.product.productName}
                                <br><img class="w-75" src="${feedback.orderDetail.productDetail.imageURL}">
                            </p>
                            
                            <p><strong>Rating:</strong> ${feedback.rating}</p>
                            <p><strong>Comment:</strong> ${feedback.comment}</p>
                            <p><strong>Image:</strong> <br><img class="w-75" src="${feedback.image}"></p>
                            <p><strong>Status:</strong> ${feedback.isDeleted ? 'Inactive' : 'Active'}</p>
                        </div>
                    </div>
                </div>
            </div>

        </c:forEach>

        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- DataTable JS -->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>

        <script>
                            $(document).ready(function () {
                                $('#feedbackTable').DataTable({
                                    "paging": false,
                                    "lengthChange": false,
                                    "searching": false,
                                    "ordering": true,
                                    "info": false,
                                    "autoWidth": false
                                });
                            });
        </script>

        <script>
            function submitFormWithPage(page) {
                document.getElementById('pageInput').value = page;
                document.getElementById('searchForm').submit();
            }
        </script>

    </body>
</html>
