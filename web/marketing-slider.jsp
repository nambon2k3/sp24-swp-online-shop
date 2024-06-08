<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Slider List</title>
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
            <h2>Slider List</h2>

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

            <button type="button" class="btn btn-primary mb-3" data-toggle="modal" data-target="#addSliderModal">Add Slider</button>

            <!--filter form-->
            <form action="slider" method="get" class="form-inline mb-3">
                <div class="form-group mr-2">
                    <input type="text" class="form-control" name="search" placeholder="Search">
                </div>
                <div class="form-group mr-2">
                    <select class="form-control" name="status">
                        <option value="">Select Status</option>
                        <option value="true">Inactive</option>
                        <option value="false">Active</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary mt-3">Search</button>
            </form>

            <table id="sliderTable" class="table table-striped">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Image</th>
                        <th>Backlink</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="slider" items="${sliderList}">
                        <tr>
                            <td>${slider.id}</td>
                            <td>${slider.title}</td>
                            <td><img style="width: 200px" src="${slider.imageUrl}"></td>
                            <td>${slider.backlink}</td>
                            <td>${slider.isDeleted ? 'Inactive' : 'Active'}</td>
                            <td>
                                <button type="button" class="btn btn-info btn-sm" data-toggle="modal" data-target="#sliderInfoModal_${slider.id}">Info</button>
                                <button type="button" class="btn btn-primary btn-sm" data-toggle="modal" data-target="#editSliderModal_${slider.id}">Edit</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li class="page-item">
                        <a class="page-link" href="?page=1" aria-label="Previous">
                            <span aria-hidden="true">&laquo;</span>
                        </a>
                    </li>
                    <c:forEach begin="1" end="${totalPages}" step="1" var="i">
                        <li class="page-item ${currentPage == i ? 'active' : ''}">
                            <a class="page-link" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item">
                        <a class="page-link" href="?page=${totalPages}" aria-label="Next">
                            <span aria-hidden="true">&raquo;</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>

        <c:forEach var="slider" items="${sliderList}">

            <!-- Edit Slider Modal -->
            <div class="modal fade" id="editSliderModal_${slider.id}" tabindex="-1" role="dialog" aria-labelledby="editSliderModalLabel_${slider.id}" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="editSliderModalLabel_${slider.id}">Edit Slider</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <!-- Edit Slider Form -->
                            <form action="slider" method="post">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="sliderId" value="${slider.id}">
                                <div class="form-group">
                                    <label for="imageUrl">Title</label>
                                    <input type="text" class="form-control" id="imageUrl" name="title" value="${slider.title}" required>
                                </div>
                                <div class="form-group">
                                    <label for="imageUrl">Image URL</label>
                                    <input type="text" class="form-control" id="imageUrl" name="imageUrl" value="${slider.imageUrl}" required>
                                </div>
                                <div class="form-group">
                                    <label for="imageUrl">Backlink</label>
                                    <input type="text" class="form-control" id="imageUrl" name="backlink" value="${slider.backlink}" required>
                                </div>
                                <div class="form-group">
                                    <label for="imageUrl">Note</label>
                                    <input type="text" class="form-control" id="imageUrl" name="notes" value="${slider.notes}">
                                </div>
                                <div class="form-group">
                                    <label for="status">Status</label>
                                    <select class="form-control" id="status" name="isDeleted">
                                        <option value="false" ${!slider.isDeleted ? "selected" : ""}>Active</option>
                                        <option value="true" ${slider.isDeleted ? "selected" : ""}>Inactive</option>
                                    </select>
                                </div>
                                <!-- Add other fields as needed -->
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Slider Info Modal -->
            <div class="modal fade" id="sliderInfoModal_${slider.id}" tabindex="-1" role="dialog" aria-labelledby="sliderInfoModalLabel_${slider.id}" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="sliderInfoModalLabel_${slider.id}">Slider Details</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <img class="w-100 mb-3" src="${slider.imageUrl}">
                            <p><strong>ID:</strong> ${slider.id}</p>
                            <p><strong>Title:</strong> ${slider.title}</p>
                            <p><strong>Notes:</strong> ${slider.notes}</p>
                            <p><strong>Backlink:</strong> ${slider.backlink}</p>
                            <p><strong>Status:</strong> ${slider.isDeleted ? 'Inactive' : 'Active'}</p>
                            <p><strong>Created At:</strong> <fmt:formatDate value="${slider.createdAt}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
                            <!--<p><strong>Created By:</strong> ${slider.createdBy}</p>-->
                        </div>
                    </div>
                </div>
            </div>

        </c:forEach>

        <!-- Add Slider Modal -->
        <div class="modal fade" id="addSliderModal" tabindex="-1" role="dialog" aria-labelledby="addSliderModalLabel" aria-hidden="true">
            <!-- Modal Content -->
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <!-- Modal Header -->
                    <div class="modal-header">
                        <h5 class="modal-title" id="addSliderModalLabel">Add Slider</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <!-- Modal Body -->
                    <div class="modal-body">
                        <!-- Add Slider Form -->
                        <form action="slider" method="post">
                            <!-- Hidden Field -->
                            <input type="hidden" name="action" value="add">
                            <!-- Form Inputs -->
                            <div class="form-group">
                                <label for="imageUrl">Image URL</label>
                                <input type="text" class="form-control" id="imageUrl" name="imageUrl" required>
                            </div>
                            <div class="form-group">
                                <label for="imageUrl">Title</label>
                                <input type="text" class="form-control" id="imageUrl" name="title" required>
                            </div>
                            <div class="form-group">
                                <label for="imageUrl">Backlink</label>
                                <input type="text" class="form-control" id="imageUrl" name="backlink" required>
                            </div>
                            <div class="form-group">
                                <label for="imageUrl">Note</label>
                                <input type="text" class="form-control" id="imageUrl" name="notes">
                            </div>
                            <div class="form-group">
                                <label for="isDeleted">Status</label>
                                <select class="form-control" id="isDeleted" name="isDeleted">
                                    <option value="false">Active</option>
                                    <option value="true">Inactive</option>
                                </select>
                            </div>
                            <!--                            <div class="form-group">
                                                            <label for="createdBy">Created By</label>
                                                            <input type="text" class="form-control" id="createdBy" name="createdBy" required>
                                                        </div>-->
                            <button type="submit" class="btn btn-primary">Add Slider</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap JS and jQuery -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <!-- DataTable JS -->
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/dataTables.bootstrap4.min.js"></script>

        <script>
            $(document).ready(function () {
                $('#sliderTable').DataTable({
                    "paging": false,
                    "lengthChange": false,
                    "searching": false,
                    "ordering": true,
                    "info": false,
                    "autoWidth": false
                });
            });
        </script>

    </body>
</html>
