<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>TBIKE</title>
    <link rel="apple-touch-icon" sizes="76x76" href="/views/admin/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/views/admin/assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <link href="/views/admin/assets/css/light-bootstrap-dashboard.css" rel="stylesheet" />
    <!-- Fonts and icons -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <!-- CSS Files -->
    <link href="/views/admin/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/views/admin/assets/css/light-bootstrap-dashboard.css?v=2.0.0" rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="/views/admin/assets/css/demo.css" rel="stylesheet" />
    <!-- CSS only -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css">
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <style>
		<%@include file="/views/user/css/product.css"%>
    </style>
</head>
<body> 
    <div class="wrapper">
        <div class="sidebar" data-image="/views/admin/assets/img/sidebar-5.jpg">
            <div class="sidebar-wrapper">                                                                                                                                                                                                
                <div class="logo">
                    <a href="/home" class="simple-text">
                        <img alt="" src="/views/admin/assets/img/Logo.jpg">
                    </a>
                </div>
                <ul class="nav">
				    <c:choose>
				        <c:when test="${role eq 'admin'}">
				            <li class="nav-item"><a class="nav-link" href="/admin" id="bikeProduct-link"><i class="nc-icon nc-chart-pie-35"></i><p>Sản phẩm</p></a></li>
				            <li class="nav-item"><a class="nav-link" href="/admin/user" id="icons-link"><i class="nc-icon nc-atom"></i><p>Người dùng</p></a></li>
				            <li class="nav-item"><a class="nav-link" href="/admin/order" id="maps-link"><i class="nc-icon nc-pin-3"></i><p>Đơn hàng</p></a></li>
				            <li class="nav-item"><a class="nav-link" href="/admin/report" id="notifications-link"><i class="nc-icon nc-chart-bar-32"></i><p>Thống kê báo cáo</p></a></li>
				            <li class="nav-item"><a class="nav-link" href="/admin/bicycle-variations" id="notifications-link"><i class="nc-icon nc-grid-45"></i><p>Quản lý danh mục</p></a></li>
				            <li class="nav-item active active-pro"><a class="nav-link active" href="#" id="upgrade-link"><i class="nc-icon nc-alien-33"></i><p>Chức năng mới đang được cập nhật...</p></a></li>
				        </c:when>
				        <c:when test="${role eq 'staff'}">
				            <li class="nav-item"><a class="nav-link" href="/admin/order" id="maps-link"><i class="nc-icon nc-pin-3"></i><p>Đơn hàng</p></a></li>
				        </c:when>
				    </c:choose>
				</ul>
            </div>
        </div>
        <div class="main-panel">
            <nav class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <img alt="" src="/views/admin/assets/img/home.png">
                    <a class="navbar-brand ms-2" href="/home">Trang chủ</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <form class="d-flex ms-auto" role="search">
                      
                        <a href="#" class="mt-3 simple-text"><img alt="" src="/views/admin/assets/img/NamDZ.jpg" style="width: 55px; border-radius: 50%;"></a>
                    </form>
                </div>
            </nav>
            <main>
                <div id="content">
                    	<jsp:include page="${view}"/>
                </div>
            </main>
        </div>
    </div>
    <!-- Core JS Files -->
    <script src="/views/admin/assets/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
    <script src="/views/admin/assets/js/core/popper.min.js" type="text/javascript"></script>
    <script src="/views/admin/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
    <script src="/views/admin/assets/js/plugins/bootstrap-switch.js"></script>
    <script type="text/admin/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
    <script src="/views/admin/assets/js/plugins/chartist.min.js"></script>
    <script src="/views/admin/assets/js/plugins/bootstrap-notify.js"></script>
    <script src="/views/admin/assets/js/light-bootstrap-dashboard.js?v=2.0.0" type="text/javascript"></script>
    <script src="/views/admin/assets/js/demo.js"></script>
    <script src="/views/admin/assets/js/product.js"></script>
    <script type="text/javascript"
	src="https://www.gstatic.com/charts/loader.js"></script>
	<script type="text/javascript">
    // Load Google Charts
    google.charts.load('current', { packages: ['corechart'] });

    // Draw the first chart
    google.charts.setOnLoadCallback(drawDonutChart);
    function drawDonutChart() {
        var data = google.visualization.arrayToDataTable([
            ['Product', 'Revenue'],
            <c:forEach var="topProductRevenue" items="${topProductRevenues}">
                ['${topProductRevenue.productName}', ${topProductRevenue.revenue}],
            </c:forEach>
        ]);

        var options = {
        	    title: 'Top 4 sản phẩm có doanh thu cao nhất',
        	    pieHole: 0.3,
        	    slices: {
        	    	 0: { color: '#3498db' }, 
        	         1: { color: '#e74c3c' }, 
        	         2: { color: '#f1c40f' }, 
        	         3: { color: '#2ecc71' }  
        	        
        	        
        	    }
        	};




        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
    }

    // Draw the second chart
    google.charts.setOnLoadCallback(drawColumnChart);
    function drawColumnChart() {
    	var data = google.visualization.arrayToDataTable([
    	    ['Element', 'Doanh thu', { role: 'style' }, { role: 'annotation' }],
    	    ['Hôm qua', parseInt(${totalRevenueYesterday}) * 1000, '#FF5733', ${orderCountYesterday} +' đơn'],
    	    ['Hôm nay', parseInt(${totalRevenueToday}) * 1000, '#C70039', ${orderCountToday} +' đơn'],
    	    ['Trong tháng', parseInt(${totalMonth}) * 1000, '#3498db', ${orderCountMonth} +' đơn'],
    	    ['Trong năm', parseInt(${totalYear}) * 1000, '#E74C3C', ${orderCountYear} +' đơn']
    	]);




        var options = {
            title: 'Doanh thu theo từng móc thời gian',
            bar: { groupWidth: '90%' },
            legend: { position: 'none' },
            animation: {
                startup: true,
                duration: 5000,
                easing: 'out'
            },
            vAxis: {
                
                title: 'Doanh thu (VNĐ)'
            },
            
        };

        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
        chart.draw(data, options);
        

    }
</script>
    
</body>
</html>
