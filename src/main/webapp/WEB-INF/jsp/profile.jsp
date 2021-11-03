<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bid Wars</title>
    <link rel="stylesheet" href="/resources/css/navbar.css">
    <link rel="stylesheet" href="/resources/css/login.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css"/>
    <script src="/resources/js/utils.js"></script>
    <script src="/resources/js/profile.js"></script>
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
            <a href="/management">Management</a>
        </c:if>
        <div class="custom-navbar-right">
            <a class="active" href="/profile">Welcome ${user.username}! <i class="fa fa-fw fa-user"></i></a>
            <a href="javascript:logout()"><i class="fa fa-fw fa-sign-out"></i></a>
        </div>
    </div>

    <form:form class="modal-content animate" modelAttribute="userForm" action="/profile" method="post">
        <div class="img-container">
            <img src="/resources/images/profile_picture.png" alt="Avatar" class="avatar">
        </div>
        <p><b>&nbsp;&nbsp;Update your account information:</b></p>
        <hr>
        <div class="container">
            <label><b>Username</b></label>
            <form:input path="username" type="text" name="username" minlength="6" maxlength="20" readonly="true"/>
            <label><b>Password</b></label>
            <form:input path="password" type="password" name="password" minlength="8" maxlength="20" required="true"/>
            <label><b>Email</b></label>
            <form:input path="email" type="email" name="email" minlength="4" maxlength="50" readonly="true"/>
            <label><b>Name</b></label>
            <form:input path="name" type="text" placeholder="Enter Name" name="name" minlength="3" maxlength="20" required="true" />
            <label><b>Surname</b></label>
            <form:input path="surname" type="text" placeholder="Enter Surname" name="surname" minlength="3" maxlength="20" required="true" />
            <label><b>Age</b></label>
            <form:input path="age" type="number" placeholder="Enter Age" name="password" min="1" max="150" step="1" required="true" />
            <label><b>Gender</b></label>
            <form:select path="gender" name="likedCategories">
                <option value="" disabled>Choose Gender</option>
                <c:forEach var="gender" items="${genders}">
                    <c:choose>
                        <c:when test="${userForm.gender == gender.text}">
                            <option value="${gender.text}" selected>${gender.text}</option>
                        </c:when>
                        <c:otherwise>
                            <option value="${gender.text}">${gender.text}</option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </form:select>
            <label><b>Liked Categories</b></label>
            <form:select path="likedCategories" name="likedCategories" class="multiSelect2" multiple="multiple" style="width: 100%">
                <c:forEach  var="category" items="${categories}">
                    <option value="${category}">${category}</option>
                </c:forEach>
            </form:select>
            <button type="submit">Save changes</button>
        </div>
    </form:form>
    <input type="hidden" id="likedCategoriesValues" value="${userForm.likedCategories}"/>

</body>
</html>
