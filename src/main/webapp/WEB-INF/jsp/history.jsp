<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
        <a href="/home">Home</a>
        <a href="/bids">My Bids</a>
        <c:if test="${user.history}">
            <a class="active" href="/history">History</a>
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
            <h1>Past Listings</h1>
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
                                        Ended:
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

</body>
</html>
