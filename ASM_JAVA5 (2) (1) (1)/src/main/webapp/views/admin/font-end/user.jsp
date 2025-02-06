<!--
=========================================================
 Light Bootstrap Dashboard - v2.0.1
=========================================================

 Product Page: https://www.creative-tim.com/product/light-bootstrap-dashboard
 Copyright 2019 Creative Tim (https://www.creative-tim.com)
 Licensed under MIT (https://github.com/creativetimofficial/light-bootstrap-dashboard/blob/master/LICENSE)

 Coded by Creative Tim

=========================================================

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.  
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>User</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script 
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>

</head>

<body>
	<div class="container mt-5">
	<h2 class="mb-4">Quản lí tài khoản</h2>
		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" data-bs-toggle="tab" role="tab" href="#tab1">Cập nhật người dùng</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				data-bs-toggle="tab" role="tab" href="#tab2">Danh sách người dùng</a></li>
		</ul>

		<div class="tab-content mt-2 ">
			<!-- Form edit -->
			<div class="tab-pane fade show active" role="tabpanel" id="tab1">
				<div class="tab-content mt-2">
					<div class="row">
						<div class="col-lg-6">
							<div class="mb-3">
								<label for="exampleFormControlInput1" class="form-label">Tên tài khoản</label> <input type="text" class="form-control"
									id="exampleFormControlInput1">
							</div>
							<div class="mb-3">
								<label for="exampleFormControlInput1" class="form-label">Họ và tên</label> <input type="text" class="form-control"
									id="exampleFormControlInput1">
							</div>
							<div class="mb-3">
								<label for="exampleFormControlTextarea1" class="form-label">Mật khẩu</label>
								<input type="password" class="form-control"
									id="exampleFormControlInput1">
							</div>
							<div class="mb-3">
								<label for="role">Vai trò:</label>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="Role"
										id="role1" value="admin"> 
										<label for="role1">Quản lí</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="Role"
										id="role2" value="user"> 
										<label for="role2">Nhân viên</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="Role"
										id="role3" value="user"> 
										<label for="role3">Người dùng</label>
								</div>
							</div>
							
							<div class="mb-3">
								<label for="role">Giới tính:</label>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="Role"
										id="role1" value="admin"> 
										<label for="role1">Nam</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="Role"
										id="role2" value="user"> 
										<label for="role2">Nữ</label>
								</div>
							</div>
					
						</div>
						<div class="col-lg-6">
							<div class="mb-3">
								<label for="exampleFormControlInput1" class="form-label">Email</label>
								<input type="email" class="form-control"
									id="exampleFormControlInput1">
							</div>
							<div class="mb-3">
								<label for="exampleFormControlTextarea1" class="form-label">Số điện thoại</label> <input type="text" class="form-control"
									id="exampleFormControlInput1">
							</div>
							<div class="mb-3">
								<label for="exampleFormControlTextarea1" class="form-label">Địa chỉ</label>
								<input type="text" class="form-control"
									id="exampleFormControlInput1">
							</div>
							<div class="mb-3">
								<label for="status">Trạng thái:</label>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="Status"
										id="status1" value="active"> 
										<label for="status1">Còn hoạt động</label>
								</div>
								<div class="form-check form-check-inline">
									<input class="form-check-input" type="radio" name="Status"
										id="status2" value="stop-working"> 
										<label for="status2">Ngừng hoạt động</label>
								</div>
							</div>
						</div>
					</div>
					<button type="button" class="btn btn-primary">Thêm</button>
				</div>
			</div>
			<!-- Table -->
			<div class="tab-pane fade" role="tabpanel" id="tab2">
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Tên tài khoản</th>
							<th>Họ và tên</th>
							<th>Mật khẩu</th>
							<th>Vai trò</th>
							<th>Email</th>
							<th>Điện thoại</th>
							<th>Địa chỉ</th>
							<th>Trạng thái</th>
							<th>Hoạt động</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>AAA</td>
							<td>Nguyen Van A</td>
							<td>123</td>
							<td>Admin</td>
							<td>Anv12@gmail.com</td>
							<td>0123456789</td>
							<td>Can Tho</td>
							<td>Active</td>
							<td><button type="button" class="btn btn-danger">Xóa</button>
								<button type="button" class="btn btn-warning">Chỉnh sửa</button></td>
						</tr>
					</tbody>
				</table>
			</div>

		</div>

	</div>
	
	
</body>

</html>
