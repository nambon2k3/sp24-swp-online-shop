<%-- 
    Document   : list-post
    Created on : May 20, 2024, 4:20:58 PM
    Author     : Legion
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Homepage</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
        <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
        <link rel="stylesheet" href="../css/list-post.css">
    </head>

    <body>
        <div class="container-fluid">
            <div class="row d-flex bg-light border justify-content-between align-items-center vh-6">
                <div class="col-1">
                    <span>Marketing</span>
                </div>
                <div class="dropdown col-1" style="text-align: right;">
                    <button class="btn dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class='bx bxs-user'></i>
                    </button>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item border-bottom d-flex justify-content-start align-items-center" href="#">
                                <i class='bx bxs-user' style="margin-right: 20px;"></i><span>User Profile</span></a></li>
                        <li><a class="dropdown-item d-flex justify-content-start align-items-center" href="login.html"><i
                                    class='bx bx-log-in' style="margin-right: 20px;"></i>Logout</a></li>
                    </ul>
                </div>
            </div>
            <div class="row d-flex vh-94">
                <div class="col-2 bg-light border-end p-0">
                    <div class="d-flex flex-column mb-3">
                        <div class="p-3 border-bottom d-flex justify-content-start align-items-center">
                            <input type="text" class="form-control" style="border-top-right-radius: 0; border-bottom-right-radius: 0">
                            <button class="btn btn btn-light btn-outline-secondary" style="border-top-left-radius: 0; border-bottom-left-radius: 0">
                                <i class='bx bx-search' ></i>
                            </button>
                        </div>
                        <a href="view-content.html" class="p-3 border-bottom d-flex justify-content-start align-items-center text-decoration-none active"><i class='bx bx-table mr-10'></i>Post management</a>

                    </div>
                </div>
                <div class="col-10 p-4">
                    <div class="row">
                        <div class="col-12">
                            <h1 class="color-gray border-bottom pb-3">Post Management</h1>
                            <div class="card mt-4 p-3">
                                <div class="card-header">
                                    List post
                                </div>
                                <form method="get" action="list-post" class="form-inline mb-3">
                                    <table>
                                        <tr>
                                            <td>
                                                <div class="form-group">
                                                    <label for="category">Category:</label>
                                                    <select id="category" name="category" class="form-control">
                                                        <option value="">All</option>
                                                        <c:forEach var="cat" items="${categories}">
                                                            <option value="${cat.categoryName}" ${param.category == cat.categoryName ? 'selected' : ''}>${cat.categoryName}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="form-group">
                                                    <label for="author">Author:</label>
                                                    <select id="author" name="author" class="form-control">
                                                        <option value="">All</option>
                                                        <c:forEach var="auth" items="${authors}">
                                                            <option value="${auth}" ${param.author == auth ? 'selected' : ''}>${auth}</option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="form-group">
                                                    <label for="status">Status:</label>
                                                    <select id="status" name="status" class="form-control">
                                                        <option value="">All</option>
                                                        <option value="show" ${param.status == 'show' ? 'selected' : ''}>Hide</option>
                                                        <option value="hide" ${param.status == 'hide' ? 'selected' : ''}>Show</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="form-group">
                                                    <label for="search">Title:</label>
                                                    <input type="text" id="search" name="search" class="form-control" value="${param.search}">
                                                </div>
                                            </td>
                                            <td>
                                                <div class="form-group">
                                                    <label for="sortBy">Sort By:</label>
                                                    <select id="sortBy" name="sortBy" class="form-control">
                                                        <option value="title" ${param.sortBy == 'title' ? 'selected' : ''}>Title</option>
                                                        <option value="category" ${param.sortBy == 'category' ? 'selected' : ''}>Category</option>
                                                        <option value="author" ${param.sortBy == 'author' ? 'selected' : ''}>Author</option>
                                                        <option value="featured" ${param.sortBy == 'featured' ? 'selected' : ''}>Featured</option>
                                                        <option value="status" ${param.sortBy == 'status' ? 'selected' : ''}>Status</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="form-group">
                                                    <label for="sortOrder">Order:</label>
                                                    <select id="sortOrder" name="sortOrder" class="form-control">
                                                        <option value="ASC" ${param.sortOrder == 'ASC' ? 'selected' : ''}>Ascending</option>
                                                        <option value="DESC" ${param.sortOrder == 'DESC' ? 'selected' : ''}>Descending</option>
                                                    </select>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="form-group" style="margin-left: 10px">
                                                    <label for="sortOrder"></label><br>
                                                    <button type="submit" class="btn btn-primary">Filter</button>
                                                    <button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addPostModal">Add New Post</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </form>

                                <table class="table table-bordered table-striped">
                                    <thead class="text-bold">
                                        <tr>
                                            <td>#</td>
                                            <td>Title</td>
                                            <td>Brief</td>
                                            <td>Category</td>
                                            <td>Created Date</td>
                                            <td>Created By</td>
                                            <td>Action</td>
                                        </tr>
                                    </thead>
                                    <tbody id="table-content-body">
                                        <c:forEach var="post" items="${posts}">
                                            <tr>
                                                <td>${post.id}</td>
                                                <td>${post.title}</td>
                                                <td>${fn:substring(post.content, 0, 50)}...</td>
                                                <td>
                                                    ${post.getCategoryName()}
                                                </td>
                                                <td>${post.createdAt}</td>
                                                <td>${post.authorName}</td>
                                                <td>
                                                    <button type="btn" class="btn btn-info" onclick="view(`${post.id}`)" data-bs-toggle="modal" data-bs-target="#viewPostModal">View</button>
                                                    <c:if test="${!post.isDeleted}">
                                                        <a href="update-post?postId=${post.id}&isDeleted=1" class="btn btn-danger">Hide</a>
                                                    </c:if>
                                                    <c:if test="${post.isDeleted}">
                                                        <a href="update-post?postId=${post.id}&isDeleted=0" class="btn btn-success">Show</a>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>

                                <nav>
                                    <ul class="pagination">
                                        <c:if test="${currentPage > 1}">
                                            <li class="page-item"><a class="page-link" href="list-post?page=${currentPage - 1}&category=${param.category}&author=${param.author}&status=${param.status}&search=${param.search}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}">Previous</a></li>
                                            </c:if>
                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                <a class="page-link" href="list-post?page=${i}&category=${param.category}&author=${param.author}&status=${param.status}&search=${param.search}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}">${i}</a>
                                            </li>
                                        </c:forEach>
                                        <c:if test="${currentPage < totalPages}">
                                            <li class="page-item"><a class="page-link" href="list-post?page=${currentPage + 1}&category=${param.category}&author=${param.author}&status=${param.status}&search=${param.search}&sortBy=${param.sortBy}&sortOrder=${param.sortOrder}">Next</a></li>
                                            </c:if>
                                    </ul>
                                </nav>
                                <c:if test="${isSuccess ne null && isSuccess}">
                                    <div class="alert alert-success alert-dismissible fade show mt-2" role="alert" id="mess">
                                        <strong>Save success!</strong> You should check in on some of those fields below.
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>
                                <c:if test="${isSuccess ne null && !isSuccess}">
                                    <div class="alert alert-danger alert-dismissible fade show mt-2" role="alert" id="mess">
                                        <strong>Save failed!</strong> You should check in on some of those fields below.
                                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                                    </div>
                                </c:if>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Modal for Adding New Post -->
        <div class="modal fade" id="addPostModal" tabindex="-1" aria-labelledby="addPostModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form method="post" action="add-post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addPostModalLabel">Add New Post</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="postTitle">Title</label>
                                <input type="text" class="form-control" id="postTitle" name="title" required>
                            </div>
                            <div class="form-group">
                                <label for="postContent">Content</label>
                                <textarea class="form-control" id="postContent" name="content" rows="5" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="postCategory">Category</label>
                                <select class="form-control" id="postCategory" name="category" required>
                                    <c:forEach var="cat" items="${categories}">
                                        <option value="${cat.ID}">${cat.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Post</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>


        <!-- Modal for Adding New Post -->
        <div class="modal fade" id="viewPostModal" tabindex="-1" aria-labelledby="viewPostModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form method="post" action="update-post">
                        <div class="modal-header">
                            <h5 class="modal-title" id="addPostModalLabel">View Post</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="postId">ID:</label>
                                <input type="text" class="form-control" id="postId" name="postId" readonly style="background-color: #e6e6e6">
                            </div>
                            <div class="form-group">
                                <label for="postTitleEdit">Title</label>
                                <input type="text" class="form-control" id="postTitleEdit" name="title" required>
                            </div>
                            <div class="form-group">
                                <label for="postContentEdit">Content</label>
                                <textarea class="form-control" id="postContentEdit" name="content" rows="5" required></textarea>
                            </div>
                            <div class="form-group">
                                <label for="createdAt">Created At: </label>
                                <input type="text" class="form-control" id="createdAt" name="createdAt" readonly style="background-color: #e6e6e6">
                            </div>
                            <div class="form-group">
                                <label for="createdBy">Created By: </label>
                                <input type="text" class="form-control" id="createdBy" name="createdBy" readonly style="background-color: #e6e6e6">
                            </div>
                            <div class="form-group">
                                <label for="postCategoryEdit">Category</label>
                                <select class="form-control" id="postCategoryEdit" name="category" required>
                                    <c:forEach var="cat" items="${categories}">
                                        <option class="cateOption" value="${cat.ID}">${cat.categoryName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Save Post</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4"
        crossorigin="anonymous"></script>
        <script>
            function view(id) {
                fetch('post-detail?id=' + id)
                        .then(response => response.json())
                        .then(data => {
                            data.forEach(post => {
                                document.getElementById('postId').value = post.id;
                                document.getElementById('postTitleEdit').value = post.title;
                                document.getElementById('postContentEdit').value = post.content;
                                document.getElementById('createdAt').value = post.createdAt;
                                document.getElementById('createdBy').value = post.createdBy;
                                

                                let listCategory = document.getElementsByClassName('cateOption');
                                for (let i = 0; i < listCategory.length; i++) {
                                    if (listCategory[i].value === post.categoryId) {
                                        listCategory[i].selected = true;
                                    }
                                }

                            });
                        })
                        .catch(error => {
                            console.error('Error fetching post data:', error);
                        }
                        );
            }
        </script>
    </body>

</html>
