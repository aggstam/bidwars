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
    <script src="https://www.gstatic.com/charts/loader.js"></script>
    <script src="/resources/js/utils.js"></script>
    <script src="/resources/js/statistics.js"></script>
</head>
<body>

    <div class="custom-navbar">
        <a href="/home">Home</a>
        <a href="/bids">My Bids</a>
        <c:if test="${user.history}">
            <a href="/history">History</a>
            <a class="active" href="/statistics">Statistics</a>
        </c:if>
        <c:if test="${user.management}">
            <a href="/management">Management</a>
        </c:if>
        <div class="custom-navbar-right">
            <a href="/profile">Welcome ${user.username}! <i class="fa fa-fw fa-user"></i></a>
            <a href="javascript:logout()"><i class="fa fa-fw fa-sign-out"></i></a>
        </div>
    </div>

    <section class="jumbotron text-left custom-section">
        <div class="container">
            <h1>Age Statistics:</h1>
        </div>
    </section>

    <div class="album py-5 bg-light">
        <div class="container">
            <div class="row">
                <c:forEach  var="ageRangePerCategoryStatistics" items="${ageRangePerCategoryStatisticsMap}">
                    <div class="col-md-4">
                        <div class="card mb-4 shadow-sm ageRangePerCategoryStatisticsChart"></div>
                        <input type="hidden" class="ageRangePerCategoryStatisticsData" value="${ageRangePerCategoryStatistics.value}" name="${ageRangePerCategoryStatistics.key}"/>
                    </div>
                </c:forEach>
                <c:forEach  var="categoryPerAgeRangeStatistics" items="${categoryPerAgeRangeStatisticsMap}">
                    <div class="col-md-4">
                        <div class="card mb-4 shadow-sm categoryPerAgeRangeStatisticsChart"></div>
                        <input type="hidden" class="categoryPerAgeRangeStatisticsData" value="${categoryPerAgeRangeStatistics.value}" name="${categoryPerAgeRangeStatistics.key}"/>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <section class="jumbotron text-left custom-section">
        <div class="container">
            <h1>Gender Statistics:</h1>
        </div>
    </section>

    <div class="album py-5 bg-light">
        <div class="container">
            <div class="row">
                <c:forEach  var="genderPerCategoryStatistics" items="${genderPerCategoryStatisticsMap}">
                    <div class="col-md-4">
                        <div class="card mb-4 shadow-sm genderPerCategoryStatisticsChart"></div>
                        <input type="hidden" class="genderPerCategoryStatisticsData" value="${genderPerCategoryStatistics.value}" name="${genderPerCategoryStatistics.key}"/>
                    </div>
                </c:forEach>
                <c:forEach  var="categoryPerGenderStatistics" items="${categoryPerGenderStatisticsMap}">
                    <div class="col-md-4">
                        <div class="card mb-4 shadow-sm categoryPerGenderStatisticsChart"></div>
                        <input type="hidden" class="categoryPerGenderStatisticsData" value="${categoryPerGenderStatistics.value}" name="${categoryPerGenderStatistics.key}"/>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

    <section class="jumbotron text-left custom-section">
        <div class="container">
            <h1>Combined Statistics:</h1>
        </div>
    </section>

    <div class="album py-5 bg-light">
        <div class="container">
            <div class="row">
                <c:forEach  var="combinationPerCategoryStatistics" items="${combinationPerCategoryStatisticsMap}">
                    <div class="col-md-4">
                        <div class="card mb-4 shadow-sm combinationPerCategoryStatisticsChart"></div>
                        <input type="hidden" class="combinationPerCategoryStatisticsData" value="${combinationPerCategoryStatistics.value}" name="${combinationPerCategoryStatistics.key}"/>
                    </div>
                </c:forEach>
                <c:forEach  var="categoryPerCombinationStatistics" items="${categoryPerCombinationStatisticsMap}">
                    <div class="col-md-4">
                        <div class="card mb-4 shadow-sm categoryPerCombinationStatisticsChart"></div>
                        <input type="hidden" class="categoryPerCombinationStatisticsData" value="${categoryPerCombinationStatistics.value}" name="${categoryPerCombinationStatistics.key}"/>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>

</body>
</html>
