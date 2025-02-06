<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quên mật khẩu</title> 
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
    <style>
        <%@include file="/views/account/forgotPassword.css"%>
    </style>
</head>
<body>
<div class="box">
    <div class="box-content mt-3 p-3">
        <h1 style="color: #e95211;">QUÊN MẬT KHẨU</h1>
        <div class="line-box">
            <div class="line"></div>
        </div>
        <form action="/account/password/forgot" method="post">
					<div class="mb-3">
					
							<input type="text" class="form-control" placeholder="Nhập tên tài khoản" name="username" value="${userName}" required/>
					</div>
					<div class="mb-3">
							<div class="row">
								<div class="col-9">
									<input type="email" class="form-control" placeholder="Nhập email" name="email" value="${email}" required/>
								</div>
								<div class="col-3">
									<button formaction="/account/password/otp" class="btn btn-outline-light">Lấy mã</button>
								</div>
							</div>
						
					</div>
					<div class="mb-3">
						<input type="text" class="form-control" placeholder="Nhập mã otp" name="otp"/>
					</div>
						<c:if test="${not empty message}">
						    <div class="alert alert-success" role="alert">
						        ${message}
						    </div>
						</c:if>
											
					<button type="submit" class="btn btn-primary w-100 mb-3">Xác nhận</button>
					<a href="/home" class="btn btn-primary w-100 mb-3">Trang chủ</a>
					</form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="/views/user/js/main.js"></script>
</body>
</html>

