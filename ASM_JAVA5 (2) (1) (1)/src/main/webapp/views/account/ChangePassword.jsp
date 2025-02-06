<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Đổi mật khẩu</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style>
    <%@include file="/views/account/changePassword.css"%>
</style>
</head>
<body>
    <div class="form-container">
        <h1>ĐỔI MẬT KHẨU</h1>
      <c:if test="${not empty successMessagePasswordChanged}">
               <div class="alert alert-success w-100 text-center" role="alert">
              ${successMessagePasswordChanged}
           </div>
        </c:if>
        <form:form modelAttribute="passwordForm" method="post" action="/changePassword">
            <div class="mb-3">
                <form:errors path="username" class="text-title" />
                <form:input path="username" class="form-control" placeholder="Tên tài khoản*" readonly="true"/>
            </div>
            <div class="mb-3">
                <form:errors path="password" class="text-title" />
                <form:password path="password" class="form-control" placeholder="Mật khẩu hiện tại*" />
            </div>
            <div class="mb-3">
                <form:errors path="newPassword" class="text-title" />
                <form:password path="newPassword" class="form-control" placeholder="Mật khẩu mới*" />                
            </div>
            <button type="submit" class="btn btn-danger btn-Dangky">Đổi mật khẩu</button>
            <label class="return-home">Trở về <a href="/home">trang chủ</a></label>
        </form:form>
    </div>
</body>
<script src="/views/user/js/main.js"></script>
</html>
