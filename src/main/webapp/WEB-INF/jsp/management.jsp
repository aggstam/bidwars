<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bid Wars</title>
    <link rel="stylesheet" href="/resources/css/navbar.css">
    <link rel="stylesheet" href="/resources/css/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="/resources/js/utils.js"></script>
    <script src="/resources/js/management.js"></script>
</head>
<body>

    <div class="custom-navbar">
        <a href="/home">Home</a>
        <a href="/bids">My Bids</a>
        <c:if test="${user.history}">
            <a href="/history">History</a>
            <a href="/statistics">Statistics</a>
        </c:if>
        <c:if test="${user.management}">
            <a class="active" href="/management">Management</a>
        </c:if>
        <div class="custom-navbar-right">
            <a href="/profile">Welcome ${user.username}! <i class="fa fa-fw fa-user"></i></a>
            <a href="javascript:logout()"><i class="fa fa-fw fa-sign-out"></i></a>
        </div>
    </div>

    <section class="jumbotron text-center custom-section">
        <div class="container">
            <h1>
                User Management
                <button type="button" class="btn btn-primary addButton" data-toggle="modal" data-target="#userModal">
                    Add
                </button>
            </h1>
        </div>
    </section>

    <section class="jumbotron text-center custom-section">
        <div class="container">
            <input type="text" class="searchInput" placeholder="Search"/>
        </div>
    </section>

    <div class="table-container">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>History</th>
                    <th>Management</th>
                    <th></th>
                </tr>
            </thead>
            <tbody id="managementTable">
                <c:forEach  var="u" items="${users}">
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.username}</td>
                        <td>**********</td>
                        <td>
                            <c:choose>
                                <c:when test="${u.history}">
                                    <i class="fa fa-fw fa-check"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="fa fa-fw fa-times"></i>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${u.management}">
                                    <i class="fa fa-fw fa-check"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="fa fa-fw fa-times"></i>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary editButton" data-toggle="modal" data-target="#userModal">Edit</button>
                            <button type="button" class="btn btn-primary button-red deleteButton" data-toggle="modal" data-target="#deleteModal">Delete</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <div id="userModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form:form id="userForm" class="modal-content" modelAttribute="userForm" action="/management" method="post">
                    <div class="modal-header">
                        <h5 id="modalTitle" class="modal-title">Add User</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="username" class="col-form-label">Name</label>
                            <form:input path="username" type="text" class="form-control" id="username" placeholder="Enter Username" minlength="6" maxlength="20" required="true"/>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-form-label">Description</label>
                            <form:input path="password" type="password" class="form-control" id="password" placeholder="Enter Password" minlength="8" maxlength="20" required="true"/>
                        </div>
                        <div class="form-group">
                            <label for="history" class="col-form-label">History</label>
                            <form:checkbox path="history" class="form-control" id="history"/>
                        </div>
                        <div class="form-group">
                            <label for="management" class="col-form-label">Management</label>
                            <form:checkbox path="management" class="form-control" id="management"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button id="submitButton" type="submit" class="btn btn-primary">Add</button>
                    </div>
                </form:form>
            </div>
        </div>
    </div>

    <div id="deleteModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <form id="deleteForm" class="modal-content" action="/management/delete/" method="post">
                    <div class="modal-header">
                        <h5 class="modal-title">Delete User</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p>Are you sure you want to proceed?</p>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary button-red">Delete</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
