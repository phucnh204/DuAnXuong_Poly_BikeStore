<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<head>
<!-- Các thẻ meta và link khác -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<div class="container">
	<div class="row mt-3">
		<div class="col-lg-3">
			<h5>Thông tin tài khoản</h5>
			<br> <a href="/home/profile" class="btn btn-primary btn-Dangky ">
				Sửa thông tin </a>
		</div>
		<div class="col-lg-9">
			<ul class="nav nav-tabs" id="myTab" role="tablist">
				<li class="nav-item" role="presentation">
					<button class="nav-link active" id="home-tab" data-bs-toggle="tab"
						data-bs-target="#home" type="button" role="tab"
						aria-controls="home" aria-selected="true"
						style="font-size: larger">ĐƠN HÀNG CỦA BẠN</button>
				</li>
				<li class="nav-item" role="presentation">
					<button class="nav-link" id="profile-tab" data-bs-toggle="tab"
						data-bs-target="#profile" type="button" role="tab"
						aria-controls="profile" aria-selected="false"
						style="font-size: larger">ĐƠN HÀNG ĐANG CHỜ XÁC NHẬN</button>
				</li>
			</ul>
			<div class="tab-content" id="myTabContent">
				<div class="tab-pane fade show active" id="home" role="tabpanel"
					aria-labelledby="home-tab">

					<table class="table table-bordered ms-2 table-striped table-center">
						<thead class="table-header">
							<tr>
								<th scope="col">Đơn hàng</th>
								<th scope="col">Ngày</th>
								<th scope="col">Địa chỉ</th>
								<th scope="col">Giá trị</th>
								<th scope="col">Tình trạng</th>
								<th scope="col">Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${listItem}">
								<tr>
									<td>${item[0]}</td>
									<td>${item[1]}</td>
									<td>${item[2]}</td>
									<td><fmt:formatNumber>${item[3]}</fmt:formatNumber>vnd</td>
									<td>${item[4]}</td>
									<td><c:if
											test="${fn:toLowerCase(item[4]) eq 'đã giao hàng'}">
											<button
												onclick="confirmAction('/home/profile/order/${item[0]}?nameStatusfind=ht')"
												class="btn btn-success btn-ms fw-bold text-white">hoàn
												thành</button>
										</c:if><a href="/home/profile/order/${item[0]}?nameStatusfind="
										class="btn btn-warning btn-ms fw-bold text-white">Chi tiết</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<div class="tab-pane fade" id="profile" role="tabpanel"
					aria-labelledby="profile-tab">
					<table class="table table-bordered ms-2 table-striped table-center">
						<thead class="table-header">
							<tr>
								<th scope="col">Đơn hàng</th>
								<th scope="col">Ngày</th>
								<th scope="col">Địa chỉ</th>
								<th scope="col">Giá trị</th>
								<th scope="col">Tình trạng</th>
								<th scope="col">Hành động</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item1" items="${listItem2}">
								<tr>
									<td>${item1[0]}</td>
									<td>${item1[1]}</td>
									<td>${item1[2]}</td>
									<td><fmt:formatNumber>${item1[3]}</fmt:formatNumber></td>
									<td>${item1[4]}</td>
									<td>
										<button type="button"
											class="btn btn-danger btn-ms fw-bold text-white"
											data-bs-toggle="modal" data-bs-target="#cancelModal"
											onclick="setOrderId(${item1[0]})">Hủy đơn</button> <a
										href="/home/profile/order/${item1[0]}"
										class="btn btn-warning btn-ms fw-bold text-white">Chi tiết</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="cancelModal" tabindex="-1"
	aria-labelledby="cancelModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="cancelModalLabel">Lý do hủy đơn</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>
			<div class="modal-body">
				<form id="cancelForm" action="/home/profile/order/cancel"
					method="post">
					<div class="mb-3">
						<label for="reason" class="form-label">Lý do</label>
						<textarea class="form-control" id="reason" name="reason" rows="3"
							required></textarea>
					</div>
					<input type="hidden" id="orderId" name="orderId">
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Đóng</button>
				<button type="submit" form="cancelForm" class="btn btn-danger">Hủy
					đơn</button>
			</div>
		</div>
	</div>
</div>

<script>
        function setOrderId(orderId) {
            document.getElementById('orderId').value = orderId;
        }
        
    </script>
<script>
function confirmAction(url) {
    Swal.fire({
        title: 'Bạn có chắc chắn không?',
        text: "Bạn sẽ không thể hoàn tác hành động này!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Có, hoàn thành!'
    }).then((result) => {
        if (result.isConfirmed) {
            window.location.href = url;
        }
    });
}
</script>