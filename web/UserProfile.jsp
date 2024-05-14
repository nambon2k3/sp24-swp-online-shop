<%-- 
    Document   : UpdateProfile
    Created on : Feb 16, 2024, 10:41:44 PM
    Author     : Hi
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="//cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
        <script src="//cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        <link href="//cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    </head>
    <body>
        <jsp:include page="Header.jsp"></jsp:include>
        
            <div class="container ">
                <div class="row">
                    <div class="col-md-4 ">
                        <form action="userprofile" method="post">   
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                                <img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg">
                                <span class="font-weight-bold">${user.fullName} </span>
                            <span class="text-black-50">${user.email}</span></div>
                    </form>
                </div>
                <div class="col-md-7 ">
                    <form action="userprofile" method="post">
                        <div class="p-3 py-5">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="text-right">Profile Settings</h4>
                            </div>

                            <div class="row mt-2">
                                <div class="col-md-6"><label class="labels">Full Name: </label>
                                    <input name="fullname"  type="text" class="form-control" value="${user.fullName}" readonly>
                                </div>
                                <div class="col-md-6"><label class="labels">Gender</label>
                                    <input name="gender" type="text" class="form-control" value="${user.gender ? 'Male' : 'Female'}" readonly>
                                </div>
                            </div>
                            <div class="row mt-3">
                                <div class="col-md-12"><label class="labels">Mobile Number</label>
                                    <input name="phone"  type="text" class="form-control" value="${user.phone}" readonly>
                                </div>
                                <div class="col-md-12"><label class="labels">Address Line </label>
                                    <input name="address"  type="text" class="form-control" value="${user.address}" readonly>
                                </div>

                                <div class="col-md-12"><label class="labels">Password</label>
                                    <input name="password" type="text" class="form-control" value="${user.password}" readonly>
                                </div>
                                <a href="uploadprofile?userID=${user.userID}"  class="btn btn-dark mt-3" data-toggle="modal"><span>Update Profile</span></a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
