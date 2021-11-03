<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bid Wars Login</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/js/select2.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/select2@4.1.0-beta.1/dist/css/select2.min.css"/>
    <link rel="stylesheet" href="/resources/css/login.css">
    <script src="/resources/js/utils.js"></script>
    <script src="/resources/js/login.js"></script>
</head>
<body>
    <form:form class="modal-content animate" modelAttribute="loginForm" action="/login" method="post">
        <div class="img-container">
            <img src="/resources/images/auctioneer_logo.jpg" class="login-img">
        </div>
        <div class="container">
            <label><b>Username</b></label>
            <form:input path="loginUsername" type="text" placeholder="Enter Username" name="username" minlength="6" maxlength="20" required="true" />
            <label><b>Password</b></label>
            <form:input path="loginPassword" type="password" placeholder="Enter Password" name="password" minlength="8" maxlength="20" required="true" />
            <span class="error-message">${loginForm.errorMessage}</span>
            <button type="submit">Login</button>
        </div>
        <div class="container" style="background-color:#f1f1f1">
            <p>New User? You can sign up by clicking here: <a href="javascript:openModal('signupModal')" class="sign-up-text">Sign Up</a></p>
        </div>
    </form:form>

    <div id="signupModal" class="modal">
        <form:form class="signup-modal modal-content" modelAttribute="userForm" action="/signup" method="post">
            <div class="container sign-up-container">
                <h1>Sign Up</h1>
                <p>Please fill in this form to create an account.</p>
                <hr>

                <label><b>Username</b></label>
                <form:input path="username" type="text" placeholder="Enter Username" name="username" minlength="6" maxlength="20" required="true" />

                <label><b>Password</b></label>
                <form:input path="password" type="password" placeholder="Enter Password" name="password" minlength="6" maxlength="20" required="true" />

                <label><b>Email</b></label>
                <form:input path="email" type="email" placeholder="Enter Email" name="email" minlength="4" maxlength="50" required="true"/>

                <label><b>Name</b></label>
                <form:input path="name" type="text" placeholder="Enter Name" name="name" minlength="3" maxlength="20" required="true" />

                <label><b>Surname</b></label>
                <form:input path="surname" type="text" placeholder="Enter Surname" name="surname" minlength="3" maxlength="20" required="true" />

                <label><b>Age</b></label>
                <form:input path="age" type="number" placeholder="Enter Age" name="password" min="1" max="150" step="1" required="true" />

                <label><b>Gender</b></label>
                <form:select path="gender" name="likedCategories">
                    <option value="" selected>Choose Gender</option>
                    <c:forEach var="gender" items="${genders}">
                        <option value="${gender.text}">${gender.text}</option>
                    </c:forEach>
                </form:select>

                <label><b>Liked Categories</b></label>
                <form:select path="likedCategories" name="likedCategories" class="multiSelect2" multiple="multiple" style="width: 100%">
                    <c:forEach var="category" items="${categories}">
                        <option value="${category}">${category}</option>
                    </c:forEach>
                </form:select>

                <div class="clearfix">
                    <button type="button" onclick="closeModal('signupModal')" class="cancel-button">Cancel</button>
                    <button type="submit" class="signup-button">Sign Up</button>
                </div>
            </div>
        </form:form>
    </div>
</body>
</html>