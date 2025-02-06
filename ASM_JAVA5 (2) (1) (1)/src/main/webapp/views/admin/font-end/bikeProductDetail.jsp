<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>

<html lang="en">
<head>
<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="/views/admin/assets/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="/views/admin/assets/img/favicon.ico">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Bike Product</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<!-- Fonts and icons -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<!-- CSS Files -->
<link href="/views/admin/assets/css/bootstrap.min.css" rel="stylesheet" />
<link
	href="/views/admin/assets/css/light-bootstrap-dashboard.css?v=2.0.0 "
	rel="stylesheet" />
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="/views/admin/assets/css/demo.css" rel="stylesheet" />
<style>
.preview-container {
	margin-top: 20px;
}

.preview-container img {
	max-width: 100%;
	height: auto;
	margin-bottom: 10px;
}

.preview-container iframe, .preview-container video {
	width: 100%;
	height: 300px;
	margin-bottom: 10px;
}
</style>
</head>

<body>
	<div class="container mt-5">
		<h2 class="mb-4">Quản lí biến thể</h2>

		<!-- Nav tabs -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
		<li class="nav-item"><a
				class="nav-link ${'product-edition' == activeTab ? 'active' : ''}"
				id="product-edition-tab" data-bs-toggle="tab"
				href="#product-edition"
				aria-selected="${'product-edition' == activeTab}">Thêm/sửa biến thể</a></li>
			<li class="nav-item"><a
				class="nav-link ${'product-list' == activeTab ? 'active' : ''}"
				id="product-list-tab" data-bs-toggle="tab" href="#product-list"
				aria-selected="${'product-list' == activeTab}">Danh sách biến thể</a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content pt-3" id="myTabContent">
			<c:if test="${not empty error}">
				<div class="alert alert-danger" role="alert">${error}</div>
			</c:if>
			<c:if test="${not empty success}">
				<div class="alert alert-success" role="alert">${success}</div>
			</c:if>
			<div
				class="tab-pane fade ${'product-edition' == activeTab ? 'show active' : ''}"
				id="product-edition" role="tabpanel"
				aria-labelledby="product-edition-tab">
				<!-- Form for adding/editing a product -->
				<form:form id="productForm" modelAttribute="productDetail"
					method="post" action="/admin/product/detail/insert"
					enctype="multipart/form-data">
					 <input type="hidden" id="id" name="id" value="${productDetail.id}">
						<input type="hidden" id="pdid" name="product_id"
						value="${product.id}">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="nameBike">Tên xe</label>
								<input id="namepd" name="product"
									class="form-control" required="required"
									value="${product.name}"/>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="type">Màu sắc</label>
								<form:select path="color.id" id="color" name="color"
									class="form-select" aria-label="Default select example">
									<c:forEach var="color" items="${colors}">
										<option value="${color.id}"
											<c:if test="${color.id eq productDetail.color.id}">selected</c:if>>${color.nameColor}</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="type">Kích thước</label>
								<form:select path="size.id" id="size" name="size"
									class="form-select" aria-label="Default select example">
									<c:forEach var="size" items="${sizes}">
										<option value="${size.id}"
											<c:if test="${size.id eq productDetail.size.id}">selected</c:if>>${size.nameSize}</option>
									</c:forEach>
								</form:select>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="nameBike">Giá</label>
								<fmt:formatNumber var="formattedPrice" value="${productDetail.price}"  maxFractionDigits="0" minFractionDigits="0"/>


								<form:input path="price" id="price" name="price"
									class="form-control" required=""  value="${formattedPrice}"/>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-6">
							<label>Hình ảnh biến thể</label>
							<div class="input-group">
								<input type="file" class="form-control" id="inputGroupFile02"
									name="image">
							</div>
						</div>
						<!-- Cột cho URL của video -->
						<div class="col-md-6">
							<div class="form-group">
								<label for="nameBike">Số lượng</label>
								<form:input path="quantity" id="quantity" name="quantity"
									class="form-control" required="" />
							</div>
						</div>
					</div>

					<button type="submit" class="btn btn-primary">Thêm</button>
					<button formaction="/admin/product/detail/update" id="updateBtn" class="btn btn-warning ">Cập nhật</button>
					<a href="/admin/product/detail/${product.id}?resetError=true" id="cancelBtn" class="btn btn-secondary ">Làm
						mới</a>
				</form:form>
			</div>
			<div
				class="tab-pane fade ${'product-list' == activeTab ? 'show active' : ''}"
				id="product-list" role="tabpanel" aria-labelledby="product-list-tab">
				<!-- Table to display existing products -->
				<div class="table-responsive">
					<table id="productTable" class="table table-striped">
						<thead class="thead-dark">
							<tr>
								<th>ID</th>
								<th>Tên sản phẩm</th>
								<th>Màu sắc</th>
								<th>Kích thước</th>
								<th>Giá tiền</th>
								<th>Số lượng</th>
								<th>Hoạt động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${productDetailList}">
								<tr>
									<td>${item.id}</td>
									<td>${item.product.name}</td>
									<td>${item.color.nameColor}</td>
									<td>${item.size.nameSize}</td>
									<td><fmt:formatNumber>${item.price}</fmt:formatNumber></td>
									<td>${item.quantity}</td>
									<td><a href="/admin/product/detail/edit/${item.id}"
										class="btn btn-sm btn-primary">Chỉnh sửa</a> </td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div class="card-footer">
						<div class="row">
							<nav aria-label="">
								<ul class="pagination justify-content-center mt-3">
									<!-- Các hàng khác nếu cần -->
									<c:if test="${currentPage > 0}">
										<li class="page-item"><a class="page-link"
											href="/admin/product/detail/${product.id}?pageNo=${currentPage - 1}&activeTab=product-list">Previous</a></li>
									</c:if>
									<c:forEach var="page" items="${pageNumbers}">
										<c:choose>
											<c:when test="${page == currentPage}">
												<li class="page-item active" aria-current="page"><span
													class="page-link">${page + 1}</span></li>
											</c:when>
											<c:otherwise>
												<li class="page-item"><a class="page-link"
													href="/admin/product/detail/${product.id}?pageNo=${page}&activeTab=product-list">${page + 1}</a></li>
											</c:otherwise>
										</c:choose>
									</c:forEach>
									<c:if test="${currentPage < totalPages - 1}">
										<li class="page-item"><a class="page-link"
											href="/admin/product/detail/${product.id}?pageNo=${currentPage + 1}&activeTab=product-list">Next</a></li>
									</c:if>
								</ul>
							</nav>
						</div>
					</div>
					
				</div>
			</div>
		</div>
	</div>
</body>
<!-- Core JS Files -->
<script src="/views/admin/assets/js/core/jquery.3.2.1.min.js"
	type="text/javascript"></script>
<script src="/views/admin/assets/js/core/popper.min.js"
	type="text/javascript"></script>
<script src="/views/admin/assets/js/core/bootstrap.min.js"
	type="text/javascript"></script>
<!-- Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="/views/admin/assets/js/plugins/bootstrap-switch.js"></script>
<!-- Google Maps Plugin -->
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!-- Chartist Plugin -->
<script src="/views/admin/assets/js/plugins/chartist.min.js"></script>
<!-- Notifications Plugin -->
<script src="/views/admin/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script
	src="/views/admin/assets/js/light-bootstrap-dashboard.js?v=2.0.0 "
	type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="/views/admin/assets/js/demo.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// Javascript method's body can be found in assets/js/demos.js
		demo.initDashboardPageCharts();
		demo.showNotification();
	});
</script>

</html>
