<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
<style>
    <%@include file="/views/account/login.css"%> 
</style>
</head>
<body>
<div class="box">
    <div class="box-content mt-3 p-3">
     <c:if test="${not empty successMessageRegister}">
                            <div class="alert alert-success w-100 text-center" role="alert">
                                ${successMessageRegister}
                            </div>
                        </c:if>
        <h1>ĐĂNG NHẬP</h1>
        <div class="line-box">
            <div class="line"></div>
        </div>
        <form:form method="post" action="/login" class="mt-3">
    <div class="mb-3">
        <input type="text" class="form-control" id="emailOrUsername"
               placeholder="Email/tên đăng nhập" name="emailOrUsername"
               value="${emailOrUsername}"/>
    </div>
    <div class="mb-3">
        <input type="password" class="form-control" id="InputPassword"
               placeholder="Mật khẩu" name="password"/>
        <c:if test="${not empty success}">
            <div class="alert alert-success" role="alert">
                ${success}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="text-danger">
                ${error}
            </div>
        </c:if>
    </div>
    <button type="submit" class="btn btn-primary btn-Dangky ">Đăng Nhập</button>
            <div class="text-center mt-2">
				<a class="QuenMK" href="/account/password/formForgot">Quên mật khẩu/</a>
				<a class="DangKy" href="/account/register">Đăng ký tại đây</a>
			</div>
</form:form>

    </div>
</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
    integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
    crossorigin="anonymous"></script>
    <script src="/views/user/js/main.js"></script>
</html>
