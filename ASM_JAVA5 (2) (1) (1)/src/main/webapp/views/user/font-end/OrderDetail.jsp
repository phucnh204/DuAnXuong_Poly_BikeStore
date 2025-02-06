<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<style>
.ellipsis {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
	max-width: 200px; /* Adjust this value as needed */
}
</style>
</head>
<body>
	<!-- Content -->
	<div class="container mt-3">
		<div class="row">
			<!-- Form Section -->
			<div class="col-lg-6">
				<div class="row">
					<div class="col-lg-6 mb-2">
						<label for="exampleFormControlInput1" class="form-label mt-3"><span
							style="font-weight: bold; font-size: 20px;">Ngày đặt hàng:</span></label>
						<label><fmt:formatDate value="${listOrderDetai[0]}"
								pattern="dd/MM/yyyy" /></label>
					</div>
					<div class="col-lg-6 mb-2">
						<c:if
							test="${fn:toLowerCase(listOrderDetai[1]) eq 'chờ xác nhận'}">
							<div class="alert bg-info"
								style="color: white; font-weight: bold;" role="alert">Đơn
								hàng đang chờ xác nhận!</div>
						</c:if>
						<c:if test="${fn:toLowerCase(listOrderDetai[1]) eq 'đang xử lý'}">
							<div class="alert bg-info"
								style="color: white; font-weight: bold;" role="alert">Đơn
								hàng đang được xử lý!</div>
						</c:if>
						<c:if
							test="${fn:toLowerCase(listOrderDetai[1]) eq 'đang vận chuyển'}">
							<div class="alert bg-info"
								style="color: white; font-weight: bold;" role="alert">Đơn
								hàng đang được vận chuyển!</div>
						</c:if>
						<c:if
							test="${fn:toLowerCase(listOrderDetai[1]) eq 'đã giao hàng'}">
							<div class="alert bg-warning"
								style="color: white; font-weight: bold;" role="alert">Đơn
								hàng đã được giao thành công!</div>
						</c:if>
						<c:if test="${fn:toLowerCase(listOrderDetai[1]) eq 'hoàn thành'}">
							<div class="alert bg-success"
								style="color: white; font-weight: bold;" role="alert">Đơn
								hàng đã được hoàn thành!</div>
						</c:if>

						<c:if test="${fn:toLowerCase(listOrderDetai[1]) eq 'đã hủy'}">
							<div class="alert bg-danger"
								style="color: white; font-weight: bold;" role="alert">Đơn
								hàng đã bị hủy!</div>
						</c:if>
					</div>
				</div>

				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label"><span
						style="font-weight: bold; font-size: 20px;">Người đặt hàng:</span></label>
					<label>${listOrderDetai[2]}</label>
				</div>
				<div class="mb-3">
					<label for="paymentMethod"
						style="font-weight: bold; font-size: 20px;">Hình thức
						thanh toán:</label> <label>${listOrderDetai[3]}</label>
				</div>
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label"><span
						style="font-weight: bold; font-size: 20px;">Địa chỉ:</span></label> <label>${listOrderDetai[4]}</label>
				</div>
				<div class="mb-3">
					<label for="exampleFormControlInput1" class="form-label"><span
						style="font-weight: bold; font-size: 20px;">Số điện thoại:</span></label>
					<label>${listOrderDetai[5]}</label>
				</div>
				<div class="mb-3">
					<label for="exampleFormControlTextarea1" class="form-label"><span
						style="font-weight: bold; font-size: 20px;">Ghi chú:</span></label>
					<textarea class="form-control" id="exampleFormControlTextarea1"
						rows="3" readonly>${listOrderDetai[6]}</textarea>
				</div>
				<c:if test="${fn:toLowerCase(listOrderDetai[1]) eq 'đã hủy'}">
					<div class="mb-3">
						<label for="exampleFormControlTextarea1" class="form-label"><span
							style="font-weight: bold; font-size: 20px;">Lý do hủy đơn:</span></label>
						<label style="font-weight: bold; font-size: 20px"
							class="text-danger">${listOrderDetai[9]}</label>
					</div>
				</c:if>

				<label style="font-weight: bold; color: #ce0f0f; font-size: 20px">Tổng
					tiền:</label> <label style="font-weight: bold; font-size: 20px"><fmt:formatNumber>${listOrderDetai[7]}</fmt:formatNumber>đ</label>
			</div>

			<!-- Table Section -->
			<div class="col-lg-6">
				<div class="card">
					<div class="card-header"
						style="font-weight: bold; font-size: 15px;">Danh sách sản
						phẩm</div>
					<table class="table">
						<thead>
							<tr>
								<th>ID</th>
								<th>Tên sản phẩm</th>
								<th>Biến thể</th>
								<th>Giá sản phẩm</th>
								<th>Số lượng</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="item" items="${listProduct}">
								<tr>
									<td>${item[0]}</td>
									<td class="ellipsis">${item[1]}</td>
									<td>${item[2]}/${item[3]}</td>
									<td><fmt:formatNumber>${item[4]}</fmt:formatNumber></td>
									<td>${item[5]}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<c:if test="${fn:toLowerCase(listOrderDetai[1]) eq 'đang xử lý'}">
			<button type="button" class="btn btn-danger mt-3 btn-lg fw-bold"
				data-bs-toggle="modal" data-bs-target="#cancelModal"
				onclick="setOrderId(${listOrderDetai[8]})">Hủy đơn</button>

		</c:if>
		<a href="/home/profile2"
			class="btn btn-info mt-3 btn-lg fw-bold text-white">Quay lại</a>
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
</body>
</html>
