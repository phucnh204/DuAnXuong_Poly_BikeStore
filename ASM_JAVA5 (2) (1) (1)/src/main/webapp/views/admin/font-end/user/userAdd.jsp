<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>User</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<style>
  <style>
        body {
            padding: 10px;
            font-family: Arial, Helvetica, sans-serif;
        }

        .container {
            display: flex;
            flex-wrap: wrap;
        }

        .card-header {
            background-color: #e66138;
            font-weight: bold;
            color: white;
        }

        .btn {
            width: 200px;
            font-weight: bold;
        }

        th, td {
            text-align: center;
        }

        .table-responsive {
            overflow-x: auto;
            max-width: 100%;
        }

        .column {
            max-width: 150px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        h5 {
            color: #000000;
        }

        .pagination {
            margin-top: 1rem;
            display: flex;
            justify-content: center;
            list-style: none;
            padding: 0;
        }

        .pagination .page-item {
            margin: 0 0.25rem;
        }

        .pagination .page-link {
            color: #007bff;
            background-color: white;
            border: 1px solid #dee2e6;
            padding: 0.5rem 0.75rem;
            border-radius: 0.25rem;
            text-decoration: none;
            transition: background-color 0.2s, border-color 0.2s;
        }

        .pagination .page-link:hover {
            background-color: #e9ecef;
            border-color: #dee2e6;
        }

        .pagination .page-item.active .page-link {
            color: white;
            background-color: #007bff;
            border-color: #007bff;
        }
    </style>
<body>
    <div class="card mt-3">
        <div class="card-header">Thông tin tài khoản</div>
        <form:form modelAttribute="account" action="/create" method="post">
            <c:if test="${not empty error}">
                <div class="alert alert-danger" role="alert">
                    ${error}
                </div>
            </c:if>
            <div class="row m-1">
                <div class="col-lg-6">
                    <div class="mb-3">
                        <label for="username" class="form-label">Tên tài khoản</label>
                        <form:input path="username" class="form-control" id="username" required="required"/>
                        <form:errors path="username" cssClass="text-danger"/>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">Mật khẩu</label>
                        <form:input path="password" type="password" class="form-control" id="password" required="required"/>
                        <form:errors path="password" cssClass="text-danger"/>
                    </div>
                    <div class="mb-3">
                        <label for="role">Vai trò:</label>
                        <div class="form-check form-check-inline">
                            <form:radiobutton path="role" class="form-check-input" id="role1" value="admin"/>
                            <label for="role1">Quản lý</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <form:radiobutton path="role" class="form-check-input" id="role2" value="staff" checked="checked"/>
                            <label for="role2">Nhân viên</label>
                        </div>
                    </div>
                    
                </div>
                <div class="col-lg-6">
                    <div class="mb-3">
                        <label for="fullname" class="form-label">Họ và tên</label>
                        <form:input path="fullname" class="form-control" id="fullname" required="required"/>
                        <form:errors path="fullname" cssClass="text-danger"/>
                    </div>
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <form:input path="email" class="form-control" id="email" required="required"/>
                        <form:errors path="email" cssClass="text-danger"/>
                    </div>
                    <div class="mb-3">
                        <label for="gender">Giới tính:</label>
                        <div class="form-check form-check-inline">
                            <form:radiobutton path="gender" class="form-check-input" id="gender1" value="true" checked="checked"/>
                            <label for="gender1">Nam</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <form:radiobutton path="gender" class="form-check-input" id="gender2" value="false"/>
                            <label for="gender2">Nữ</label>
                        </div>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn-success m-2">Thêm</button>
            <a href="/admin/user" class="btn btn-info m-2">Quay lại</a>
        </form:form>
    </div>
</body>
</html>
