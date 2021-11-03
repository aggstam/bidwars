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
    <script src="/resources/js/listing.js"></script>
</head>
<body onload="setCountDown('${listing.ending}')">

    <div class="custom-navbar">
        <a href="/home">Home</a>
        <a href="/bids">My Bids</a>
        <c:if test="${user.history}">
            <a href="/history">History</a>
        </c:if>
        <c:if test="${user.management}">
            <a href="/management">Management</a>
            <a href="/statistics">Statistics</a>
        </c:if>
        <div class="custom-navbar-right">
            <a href="/profile">Welcome ${user.username}! <i class="fa fa-fw fa-user"></i></a>
            <a href="javascript:logout()"><i class="fa fa-fw fa-sign-out"></i></a>
        </div>
    </div>

    <section class="jumbotron text-center custom-section">
        <div class="container">
            <h1>
                Listing
                <c:if test="${user.history}">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editModal">Edit</button>
                    <button type="button" class="btn btn-primary button-red" data-toggle="modal" data-target="#deleteModal">Delete</button>
                </c:if>
            </h1>
        </div>
    </section>

    <div class="album py-5 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <img src="/resources/images/listings/${listing.id}/${listing.image}" class="listing-image">
                </div>
                <div class="details col-md-8">
                    <h2>Name: ${listing.name}</h2>
                    <p><strong>Category: </strong>${listing.category}</p>
                    <p><strong>Description: </strong>${listing.description}</p>
                    <c:choose>
                        <c:when test="${isActive}">
                            <p>
                                <strong>Ending: </strong>
                                <span id="timer"></span>
                            </p>
                            <p>
                                <strong>Current Price: </strong>
                                <fmt:setLocale value="en_GR"/>
                                <fmt:formatNumber value="${listing.price}" type="currency" currencySymbol="&euro;"/>
                            </p>
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#bidModal">
                                Place bid
                            </button>
                            <p><strong>Bids: </strong></p>
                            <ul class="list-group">
                                <fmt:setLocale value="en_GR"/>
                                <c:forEach var="bid" items="${bids}">
                                    <li class="list-group-item">
                                        <fmt:parseDate value="${bid.timestamp}" pattern="yyyy-MM-dd HH:mm" var="timestamp"/>
                                        <fmt:formatDate value="${timestamp}" pattern="yyyy-MM-dd HH:mm"/>
                                        :
                                        <fmt:formatNumber value="${bid.price}" type="currency" currencySymbol="&euro;"/>
                                        by ${bid.user.username}
                                    </li>
                                </c:forEach>
                            </ul>
                        </c:when>
                        <c:otherwise>
                            <p>
                                <strong>Ended: </strong>
                                <fmt:parseDate value="${listing.ending}" pattern="yyyy-MM-dd HH:mm" var="ending"/>
                                <fmt:formatDate value="${ending}" pattern="yyyy-MM-dd HH:mm"/>
                            </p>
                            <p>
                                <strong>Price Sold: </strong>
                                <fmt:setLocale value="en_GR"/>
                                <fmt:formatNumber value="${winnerPrice}" type="currency" currencySymbol="&euro;"/>
                            </p>
                            <p>
                                <strong>Winner: </strong>${winner}
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <c:if test="${hasSuggestedListings}">
        <section class="jumbotron text-left custom-section">
            <div class="container">
                <h1>Suggested Listings:</h1>
            </div>
        </section>

        <div class="album py-5 bg-light">
            <div class="container">
                <div class="row">
                    <c:forEach  var="listing" items="${suggestedListings}">
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
    </c:if>

    <c:if test="${isActive}">
        <div id="bidModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form:form class="modal-content" modelAttribute="bidForm" action="/listing/placeBid/${listing.id}" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">Bid</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="price" class="col-form-label">Price</label>
                                <form:input path="price" type="number" class="form-control" id="price" min="${listing.price + 1}" step="1" placeholder="Enter Price" required="true"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Place bid</button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </c:if>

    <c:if test="${user.history}">
        <div id="editModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form:form class="modal-content" modelAttribute="listingForm" action="/listing/${listing.id}" method="post" enctype="multipart/form-data">
                        <div class="modal-header">
                            <h5 class="modal-title">Edit Listing</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label for="name" class="col-form-label">Name</label>
                                <form:input path="name" value="${listing.name}" type="text" class="form-control" id="name" placeholder="Enter Name" minlength="6" maxlength="20" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="description" class="col-form-label">Description</label>
                                <form:input path="description" value="${listing.description}" type="text" class="form-control" id="description" placeholder="Enter Description" minlength="6" maxlength="200" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="category" class="col-form-label">Category</label>
                                <form:input path="category" value="${listing.category}" type="text" class="form-control" id="category" placeholder="Enter Category" minlength="6" maxlength="20" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="ending" class="col-form-label">Ending</label>
                                <fmt:parseDate value="${listing.ending}" pattern="yyyy-MM-dd HH:mm" var="ending"/>
                                <fmt:formatDate value="${ending}" pattern="yyyy-MM-dd'T'HH:mm" var="formatted"/>
                                <form:input path="ending" type="datetime-local" class="form-control" id="ending" value="${formatted}" required="true"/>
                            </div>
                            <div class="form-group">
                                <label for="file" class="col-form-label">Image</label>
                                <form:input path="file" type="file" id="file" class="form-control" size="5" accept=".png,.jpg"/>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Edit</button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>

        <div id="deleteModal" class="modal fade"  tabindex="-1" role="dialog" aria-labelledby="modalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form class="modal-content" action="/listing/delete/${listing.id}" method="post">
                        <div class="modal-header">
                            <h5 class="modal-title">Delete Listing</h5>
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
    </c:if>

</body>
</html>
