<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Quản lý biến thể</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">

<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>

<!-- Custom styles -->
<style>
/* General Styles */
body {
	font-family: 'Montserrat', sans-serif;
	background-color: #f8f9fa;
}

/* Navbar Styles */
.navbar {
	background-color: #ffffff;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.navbar-brand, .navbar-nav .nav-link {
	color: #555555;
	transition: color 0.3s ease;
}

.navbar-brand:hover, .navbar-nav .nav-link:hover {
	color: #007bff;
}

.sidebar .nav-link {
	color: #ecf0f1;
	transition: color 0.3s ease;
}

.sidebar .nav-link:hover {
	color: #3498db;
}

.sidebar .logo img {
	max-width: 120px;
	transition: max-width 0.3s ease;
}

.sidebar .logo img:hover {
	max-width: 130px;
}

.table-hover tbody tr:hover {
	background-color: #f1f1f1;
}

.pagination .page-link {
	color: #555555;
	transition: background-color 0.3s ease, color 0.3s ease;
}

.pagination .page-link:hover {
	background-color: #007bff;
	color: #ffffff;
}

.alert {
	border-radius: 8px;
}

#errorMessage {
	background-color: #f8d7da;
	border: 1px solid #f5c6cb;
	color: #721c24;
	padding: 10px;
	margin: 10px 0;
	opacity: 1;
	transition: opacity 1s ease-in-out;
}

.color-option {
	padding: 8px 16px;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.color-option:hover {
	background-color: #f0f0f0;
}

.btn {
	transition: background-color 0.3s ease, color 0.3s ease;
	border-radius: 8px;
}

/* Fade-out effect for error message */
.fade-out {
	opacity: 0;
	transition: opacity 1s ease-in-out;
}
</style>
</head>
<body>
	<main class="mt-3">
		<c:if test="${not empty param.message}">
			<div id="errorMessage" class="alert alert-danger text-center">${param.message}</div>
		</c:if>


		<h2>Quản lý danh mục</h2>
		<div class="row">
			<div class="col-md-4">
				<!-- Colors Section -->
				<div class="card p-3 mb-3">
					<form
						action="${pageContext.request.contextPath}/admin/bicycle-variations/create"
						method="post">
						<div class="input-group">
							<input type="text" id="nameColor" name="nameColor"
								class="form-control" placeholder="Nhập tên màu" required>

							<div class="input-group-append">
								<button type="submit" class="btn btn-outline-secondary"
									id="button-addon1">Thêm màu sắc</button>
							</div>
						</div>
					</form>

				</div>
				<div class="card p-3 mb-3" style="height: 350px;">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>ID</th>
								<th width="50%" style="padding-left: 60px">Màu sắc</th>
								<th>Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="color" items="${colors.content}">
								<tr>
									<td>${color.id}</td>
									<td style="text-align: center;">${color.nameColor}</td>
									<td class="mt-2"><a
										href="${pageContext.request.contextPath}/admin/bicycle-variations/remove/${color.id}"
										class="btn btn-danger" onclick="return confirmDelete()">Xóa
											màu</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<nav>
						<ul class="pagination justify-content-center">
							<c:if test="${colors.totalPages > 0}">
								<c:forEach begin="0" end="${colors.totalPages - 1}" var="i">
									<li class="page-item ${i == currentPageColor ? 'active' : ''}">
										<a class="page-link"
										href="?pageColor=${i}&pageSize=${currentPageSize}&pageCategory=${currentPageCategory}">${i + 1}</a>
									</li>
								</c:forEach>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
			<div class="col-md-4">
				<!-- Sizes Section -->
				<div class="card p-3 mb-3">
					<form
						action="${pageContext.request.contextPath}/admin/bicycle-variations/create-size"
						method="post">
						<div class="input-group">
							<input type="text" id="bikeSize" name="bikeSize"
								class="form-control" placeholder="Nhập kích cỡ mới" required>
							<div class="input-group-append">
								<button type="submit" class="btn btn-outline-secondary"
									id="button-addon1">Thêm kích cỡ mới</button>
							</div>
						</div>
					</form>

				</div>
				<div class="card p-3 mb-3" style="height: 350px;">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col" width="50%" style="padding-left: 60px">Kích
									cỡ</th>
								<th scope="col">Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="size" items="${sizes.content}">
								<tr>
									<td>${size.id}</td>
									<td style="text-align: center;">${size.nameSize}</td>
									<td class="mt-2"><a
										href="${pageContext.request.contextPath}/admin/bicycle-variations/remove-size/${size.id}"
										class="btn btn-danger" onclick="return confirmDelete()">Xóa
											kích cỡ</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<nav>
						<ul class="pagination justify-content-center">
							<c:if test="${sizes.totalPages > 0}">
								<c:forEach begin="0" end="${sizes.totalPages - 1}" var="i">
									<li class="page-item ${i == currentPageSize ? 'active' : ''}">
										<a class="page-link"
										href="?pageColor=${currentPageColor}&pageSize=${i}&pageCategory=${currentPageCategory}">${i + 1}</a>
									</li>
								</c:forEach>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
			<div class="col-md-4">
				<!-- Categories Section -->
				<div class="card p-3 mb-3">
					<form
						action="${pageContext.request.contextPath}/admin/bicycle-variations/create-type"
						method="post">
						<div class="input-group">
							<input type="text" id="bikeType" name="bikeType"
								class="form-control" placeholder="Nhập loại xe mới" required>
							<div class="input-group-append">
								<button type="submit" class="btn btn-outline-secondary"
									id="button-addon1">Thêm loại xe mới</button>
							</div>
						</div>
					</form>

				</div>
				<div class="card p-3 mb-3" style="height: 350px;">
					<table class="table table-striped">
						<thead>
							<tr>
								<th scope="col">ID</th>
								<th scope="col" width="50%" style="padding-left: 60px">Loại
									xe</th>
								<th scope="col">Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="type" items="${categories.content}">
								<tr>
									<td>${type.id}</td>
									<td style="text-align: center;">${type.type}</td>
									<td class="mt-2"><a
										href="${pageContext.request.contextPath}/admin/bicycle-variations/remove-type/${type.id}"
										class="btn btn-danger" onclick="return confirmDelete()">Xóa
											loại xe</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<nav>
						<ul class="pagination justify-content-center">
							<c:if test="${categories.totalPages > 0}">
								<c:forEach begin="0" end="${categories.totalPages - 1}" var="i">
									<li
										class="page-item ${i == currentPageCategory ? 'active' : ''}">
										<a class="page-link"
										href="?pageColor=${currentPageColor}&pageSize=${currentPageSize}&pageCategory=${i}">${i + 1}</a>
									</li>
								</c:forEach>
							</c:if>
						</ul>
					</nav>
				</div>
			</div>
		</div>
	</main>

	<!-- Bootstrap JS and dependencies -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
		integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"
		integrity="sha384-g/dV0jWgw5vUJ2Zp3B6CkN5My+9nFtz+6DqxFAdZlE2VXDZIYgRIq0pNk/Fi2MzI"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
		integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8sh+VyCExlHvMYXPcW+3g2V4fFg6GzFHSf8Nv2"
		crossorigin="anonymous"></script>

	<!-- Custom script for confirmation dialog -->
	<script>
		function confirmDelete() {
			return confirm('Bạn có chắc chắn muốn xóa không?');
		}
	</script>
</body>
</html>

