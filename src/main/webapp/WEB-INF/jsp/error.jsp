<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bid Wars</title>
    <link rel="stylesheet" href="/resources/css/navbar.css">
    <link rel="stylesheet" href="/resources/css/error.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="/resources/js/utils.js"></script>
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
            <a href="/profile">Welcome ${user.username}! <i class="fa fa-fw fa-user"></i></a>
            <a href="javascript:logout()"><i class="fa fa-fw fa-sign-out"></i></a>
        </div>
    </div>

    <div class="wrapper">
        <div class="box">
            <h1>500</h1>
            <p>Sorry, it's me, not you.</p>
            <p>&#58;&#40;</p>
        </div>
    </div>
</body>
</html>
