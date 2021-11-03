<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <script src="/resources/js/home.js"></script>
</head>
<body>

    <div class="custom-navbar">
        <a class="active" href="/home">Home</a>
        <a href="/bids">My Bids</a>
        <c:if test="${user.history}">
            <a href="/history">History</a>
            <a href="/statistics">Statistics</a>
        </c:if>
        <c:if test="${user.management}">
            <a href="/management">Management</a>
        </c:if>
        <div class="custom-navbar-right">
            <a href="/profile">Welcome ${user.username}! <i class="fa fa-fw fa-user"></i></a>
            <a href="javascript:logout()"><i class="fa fa-fw fa-sign-out"></i></a>
        </div>
    </div>

    <section class="jumbotron text-center custom-section">
        <div class="container">
            <h1>
                Active Listings
                <c:if test="${user.history}">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addModal">Add</button>
                </c:if>
            </h1>
        </div>
    </section>

    <section class="jumbotron text-center custom-section">
        <div class="container">
            <input type="text" class="searchInput" placeholder="Search"/>
        </div>
    </section>

    <div class="album py-5 bg-light">
        <div class="container">
            <div class="row">
                <c:forEach  var="listing" items="${listings}">
                    <div class="col-md-4">
                        <div class="card mb-4 shadow-sm">
                            <img src="/resources/images/listings/${listing.id}/${listing.image}" width="100%" height="400">
                            <div class="card-body">
                                <p class="card-text text-center">${listing.name}</p>
                                <div class="d-flex justify-content-between align-items-center">
                                    <div class="btn-group">
                                        <button type="button" class="btn btn-sm btn-outline-secondary" onClick="location.href = '/listing/${listing.id}'">View</button>
                                    </div>
                                    <small class="text-muted">
                                        Ending:
                                        <fmt:parseDate value="${listing.ending}" pattern="yyyy-MM-dd HH:mm" var="ending"/>
                                        <fmt:formatDate value="${ending}" pattern="yyyy-MM-dd HH:mm"/>
                                    </small>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <c:if test="${user.history}">
        <div id="addModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form:form class="modal-content" modelAttribute="listingForm" action="/listing" method="post" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h5 class="modal-title">Add Listing</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="name" class="col-form-label">Name</label>
                                <form:input path="name" type="text" class="form-control" id="name" placeholder="Enter Name" minlength="6" maxlength="20" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="description" class="col-form-label">Description</label>
                                <form:input path="description" type="text" class="form-control" id="description" placeholder="Enter Description" minlength="6" maxlength="200" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="category" class="col-form-label">Category</label>
                                <form:input path="category" type="text" class="form-control" id="category" placeholder="Enter Category" minlength="3" maxlength="20" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="ending" class="col-form-label">Ending</label>
                                <form:input path="ending" type="datetime-local" class="form-control" id="ending" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="price" class="col-form-label">Starting Price</label>
                                <form:input path="price" type="number" class="form-control" id="price" min="0" step="1" placeholder="Enter Starting Price" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="file" class="col-form-label">Image</label>
                                <form:input path="file" type="file" id="file" class="form-control" size="5" accept=".png,.jpg" required="true"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Add</button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </c:if>

</body>
</html>
