<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>

<style>
.product-name-cell {
	max-width: 150px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.navbar-brand {
	font-weight: bold;
}

.card-title {
	font-size: 1.5rem;
	font-weight: bold;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light"></nav>


	<div class="tab-content" id="myTabContent">
		<div class="tab-pane fade show active" id="orders-tab" role="tabpanel"
			aria-labelledby="orders-tab">
			<div class="row">
				<div class="col-md-6">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">Biểu đồ thống kê đơn hàng</h4>
						</div>
						<div class="card-body">
							<div id="chart_div" style="width: 100%; height: 400px;"></div>
						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="card">
						<div class="card-header">
							<h4 class="card-title">Biểu đồ thống kê đơn hàng</h4>
						</div>
						<div class="card-body">
							<div id="donutchart" style="width: 100%; height: 400px;"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="row mt-4">
				<div class="col-md-6">
					<div class="card">
						<div class="card-header">
							<div class="row align-items-center">
								<div class="col-md-6">
									<h4 class="card-title">Đơn hàng</h4>
								</div>
								<div class="col-md-6 text-right">
									<img alt="" width="100px"
										src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLG0GklylkEL7snkeT8IN6YKgb6arR10opsA&s">
								</div>
							</div>
						</div>
						<div class="card-body">
							<table class="table table-hover table-striped">
								<thead>
									<tr>
										<th>Trạng thái</th>
										<th>Số lượng</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="statusCount" items="${statusCounts}">
										<tr>
											<td>${statusCount.status}</td>
											<td>${statusCount.count}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							Tổng số lượng đơn:
							<c:set var="totalOrders" value="0" />
							<c:forEach var="statusCount" items="${statusCounts}">
								<c:set var="totalOrders"
									value="${totalOrders + statusCount.count}" />
							</c:forEach>
							<strong>${totalOrders}</strong> hóa đơn
						</div>
					</div>
				</div>
				<div class="col-md-6 mb-4">
					<div class="card">
						<div class="card-header">
							<div class="row align-items-center">
								<div class="col-md-5">
									<h4 class="card-title">Sản phẩm mang lại doanh thu cao
										nhất</h4>
								</div>
								<div class="col-md-7 text-right">
									<img alt="" width="100px"
										src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFHmggV2RVgAbPpABifvCa5vuZ6WLwkMLUvw&s">
								</div>
							</div>
						</div>
						<div class="card-body">
							<table class="table table-hover table-striped">
								<thead>
									<tr>
										<th>Tên sản phẩm</th>
										<th>Doanh thu</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="topProductRevenue"
										items="${topProductRevenues}">
										<tr>
											<td class="product-name-cell">${topProductRevenue.productName}</td>
											<td><fmt:formatNumber
													value="${topProductRevenue.revenue}" type="currency"
													currencySymbol=".000VNĐ" groupingUsed="true" /></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>


		</div>

		

	<!-- Scripts -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"
		integrity="sha512-bLT0Qm9VnAYZDflyKcBaQ2gg0hSYNQrJ8RilYldYQ1FxQYoCLtUjuuRuZo+fjqhx/qtq/1itJ0C2ejDxltZVFg=="
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
		integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+pw/JBsm6tcRMOh0tuUH4/dpBf0svG5X2qH"
		crossorigin="anonymous"></script>