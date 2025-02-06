<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách người dùng</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet"
    integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
    crossorigin="anonymous">
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
    crossorigin="anonymous"></script>
<script>
    function confirmStatusUpdate(url) {
        if (confirm("Bạn có chắc chắn muốn cập nhật trạng thái không?")) {
            window.location.href = url;
        }
    }
</script>
</head>
<style>
    body {
        padding: 20px;
    }

    .card-header {
        background-color: #e66138;
        font-weight: bold;
        color: white;
    }

    .btn {
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
    <c:if test="${not empty message}">
        <div class="alert alert-success" role="alert">
            ${message}
        </div>
    </c:if>
    <div class="card">
        <div
            class="card-header d-flex justify-content-between align-items-center">
            <a href="/add" type="button" class="btn btn-success m-2">Thêm tài
                khoản</a>
            <h4 style="color: #f16621;" >Danh sách người dùng</h4>
            <div class="col-md-6">
                <form class="d-flex" role="search" action="/admin/user" method="GET">
                    <input class="form-control me-2" type="text" name="keyword"
                        placeholder="Nhập tên tài khoản" aria-label="Search"
                        value="${keyword}">
                    <button class="btn btn-primary" type="submit">Tìm</button>
                </form>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên tài khoản</th>
                        <th>Mật khẩu</th>
                        <th>Họ và tên</th>
                        <th>Giới tính</th>
                        <th>Vai trò</th>
                        <th>Trạng thái</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${usersPage.content}">
                        <tr>
                            <td>${user.id}</td>
                            <td class="column">${user.username}</td>
                            <td class="column">**********</td>
                            <td class="column">${user.fullname}</td>
                            <td>${user.gender ? 'Nam' : 'Nữ'}</td>
                            <td>${user.role}</td>
                            <td>
                                <span class="${user.status == 'Activing' ? 'text-success' : 'text-danger'}">
                                    ${user.status}
                                </span>
                            </td>
                            <td>
                                <a href="javascript:void(0);" 
                                   onclick="showConfirmModal('/admin/user/updateStatus?id=${user.id}&status=${user.status == 'Activing' ? 'Inactive' : 'Activing'}')" 
                                   class="btn btn-warning">
                                    Cập nhật trạng thái
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div class="pagination">
                <ul class="pagination justify-content-center">
                    <c:if test="${currentPage > 0}">
                        <li class="page-item"><a class="page-link" 
                            href="/admin/user?page=0&keyword=${keyword}">Đầu tiên</a>
                        </li>
                    </c:if>
                    <c:forEach var="pageNumber" begin="0" end="${totalPages - 1}">
                        <c:if test="${pageNumber == currentPage}">
                            <li class="page-item active"><span class="page-link">${pageNumber + 1}</span></li>
                        </c:if>
                        <c:if test="${pageNumber != currentPage}">
                            <li class="page-item"><a class="page-link" href="/admin/user?page=${pageNumber}&keyword=${keyword}">${pageNumber + 1}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages - 1}">
                        <li class="page-item"><a class="page-link" 
                            href="/admin/user?page=${totalPages - 1}&keyword=${keyword}">Đến cuối </a>
                        </li>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>

    <!-- Modal -->
 <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header" style="background-color:#e66138; border-bottom: 1px solid #000;">
                    <h5 class="modal-title m-1" id="confirmModalLabel" style="color:#ffffff">Xác nhận cập nhật</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body" style="font-weight: bold; border-bottom: 1px solid #000;">
                    Bạn chắc chắn muốn cập nhật trạng thái?
                </div>
                <div class="modal-footer mt-1" >                   
                    <button type="button" class="btn btn-primary" id="confirmBtn">Xác nhận</button>
                     <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Quay lại</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        let confirmUrl = '';

        function showConfirmModal(url) {
            confirmUrl = url;
            const confirmModal = new bootstrap.Modal(document.getElementById('confirmModal'), {});
            confirmModal.show();
        }

        document.getElementById('confirmBtn').addEventListener('click', function () {
            window.location.href = confirmUrl;
        });
    </script>
</body>
</html>

