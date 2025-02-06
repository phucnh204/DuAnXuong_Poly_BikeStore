<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
	<div class="mx-2">
		<h2 class="mb-4 mt-4">Quản lí đơn hàng</h2>
		<ul class="nav nav-tabs" role="tablist">
			<li class="nav-item"><a
				class="nav-link ${'product-edition' == activeTab ? 'active' : ''}"
				id="product-edition-tab" data-bs-toggle="tab"
				href="#product-edition"
				aria-selected="${'product-edition' == activeTab}">Danh sách đơn
					hàng</a></li>
			<li class="nav-item"><a
				class="nav-link ${'product-list' == activeTab ? 'active' : ''}"
				id="product-list-tab" data-bs-toggle="tab" href="#product-list"
				aria-selected="${'product-list' == activeTab}">Thông tin đơn
					hàng</a></li>
		</ul>

		<div class="tab-content mt-2">
			<div
				class="tab-pane fade ${'product-edition' == activeTab ? 'show active' : ''}"
				id="product-edition" role="tabpanel"
				aria-labelledby="product-edition-tab">
				<div class="row">
					<div class="col-md-9">
						<form class="d-flex justify-content-end w-100 mb-3"
							action="/admin/order" method="get">
							<input type="text"
								class="form-control me-2 d-flex justify-content-end w-25"
								name="key" onblur="this.form.submit()"
								placeholder="Tìm mã đơn hàng...." />
						</form>
					</div>
					<div class="col-md-3">
						<form class="d-flex justify-content-end w-100 mb-3"
							action="/admin/order" method="get">
							<select class="form-control me-2 d-flex justify-content-end "
								name="nameStatus" onchange="this.form.submit()">
								<c:forEach var="item" items="${listStatus}">
									<option value="${item.nameStatus}"
										${nameStatus == item.nameStatus ? 'selected' : ''}>${item.nameStatus}</option>
								</c:forEach>
							</select>
						</form>
					</div>

				</div>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th>Id</th>
							<th>Ngày đặt hàng</th>
							<th>Người đặt hàng</th>
							<th>Tổng tiền</th>
							<th>Thanh toán</th>
							<th>Số điện thoại</th>
							<th>Trạng thái</th>
							<th>Hành động</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="item1" items="${listOrder}">
							<tr>
								<td>${item1[0]}</td>
								<td><fmt:formatDate value="${item1[1]}"
										pattern="dd/MM/yyyy" /></td>
								<td>${item1[2]}</td>
								<td><fmt:formatNumber>${item1[3]}</fmt:formatNumber></td>
								<td>${item1[4]}</td>
								<td>${item1[5]}</td>
								<td>${item1[6]}</td>
								<td><c:if
										test="${fn:toLowerCase(item1[6]) eq 'đang xử lý' or fn:toLowerCase(item1[6]) eq 'chờ xác nhận'}">
										<c:if test="${fn:toLowerCase(item1[6]) eq 'chờ xác nhận'}">
											<a href="javascript:void(0);"
												onclick="confirmAction('/admin/order/success/${item1[0]}?nameStatusfind=dxl')"
												class="btn btn-success">Xác nhận</a>
										</c:if>
										<c:if test="${fn:toLowerCase(item1[6]) eq 'đang xử lý'}">
											<a href="javascript:void(0);"
												onclick="confirmAction('/admin/order/success/${item1[0]}?nameStatusfind=dvc')"
												class="btn btn-success">Vận chuyển</a>
										</c:if>

										<c:if test="${fn:toLowerCase(role) eq 'admin'}">
											<button type="button" class="btn btn-danger"
												data-bs-toggle="modal" data-bs-target="#cancelModal"
												onclick="setOrderId(${item1[0]})">Hủy đơn</button>
										</c:if>
									</c:if> <c:if test="${fn:toLowerCase(item1[6]) eq 'đang vận chuyển'}">
										<a href="javascript:void(0);"
											onclick="confirmAction('/admin/order/success/${item1[0]}?nameStatusfind=dgh')"
											class="btn btn-success">Đã giao hàng</a>
									</c:if> <a href="/admin/order/edit/${item1[0]}?activeTab=product-list"
									class="btn btn-warning">Chi tiết</a></td>
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
										href="/admin/order?pageNo=${currentPage - 1}&activeTab=product-edition">Previous</a></li>
								</c:if>
								<c:forEach var="page" items="${pageNumbers}">
									<c:choose>
										<c:when test="${page == currentPage}">
											<li class="page-item active" aria-current="page"><span
												class="page-link">${page + 1}</span></li>
										</c:when>
										<c:otherwise>
											<li class="page-item"><a class="page-link"
												href="/admin/order?pageNo=${page}&activeTab=product-edition">${page + 1}</a></li>
										</c:otherwise>
									</c:choose>
								</c:forEach>
								<c:if test="${currentPage < totalPages - 1}">
									<li class="page-item"><a class="page-link"
										href="/admin/order?pageNo=${currentPage + 1}&activeTab=product-edition">Next</a></li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>
			</div>

			<div
				class="tab-pane fade ${'product-list' == activeTab ? 'show active' : ''}"
				id="product-list" role="tabpanel" aria-labelledby="product-list-tab">
				<div class="tab-content mt-2">
					<div class="row">
						<!-- Form Section -->
						<div class="col-lg-6">
							<div class="row">
								<div class="col-lg-6 mb-2">
									<label for="exampleFormControlInput1" class="form-label mt-3"><span
										style="font-weight: bold; font-size: 20px;">Ngày đặt
											hàng:</span></label> <label> <fmt:formatDate
											value="${listOrderDetai[0]}" pattern="dd/MM/yyyy" /></label>
								</div>
								<div class="col-lg-6 mb-2">
									<c:if
										test="${fn:toLowerCase(listOrderDetai[1]) eq 'chờ xác nhận'}">
										<div class="alert bg-info"
											style="color: white; font-weight: bold;" role="alert">Đơn
											hàng đang chờ xác nhận!</div>
									</c:if>
									<c:if
										test="${fn:toLowerCase(listOrderDetai[1]) eq 'đang xử lý'}">
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
									<c:if
										test="${fn:toLowerCase(listOrderDetai[1]) eq 'hoàn thành'}">
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
									style="font-weight: bold; font-size: 20px;">Người đặt
										hàng:</span></label> <label>${listOrderDetai[2]}</label>
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
									style="font-weight: bold; font-size: 20px;">Số điện
										thoại:</span></label> <label>${listOrderDetai[5]}</label>
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
										style="font-weight: bold; font-size: 20px;">Lý do hủy
											đơn:</span></label> <label style="font-weight: bold; font-size: 20px"
										class="text-danger">${listOrderDetai[9]}</label>
								</div>
							</c:if>


							<label style="font-weight: bold; color: #ce0f0f; font-size: 20px">Tổng
								tiền:</label> <label style="font-weight: bold; font-size: 20px"><fmt:formatNumber>${listOrderDetai[7]}</fmt:formatNumber>đ</label>
						</div>
						<!-- Table Section -->
						<div class="col-lg-6">
							<div class="card ">
								<div class="card-header"
									style="font-weight: bold; font-size: 15px;">Danh sách sản
									phẩm</div>
								<table class="table ms-2">
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
					<c:if
						test="${fn:toLowerCase(listOrderDetai[1]) eq 'đang xử lý' or fn:toLowerCase(listOrderDetai[1]) eq 'chờ xác nhận'}">
						<c:if
							test="${fn:toLowerCase(listOrderDetai[1]) eq 'chờ xác nhận'}">
							<button
								onclick="confirmAction('/admin/order/success/${listOrderDetai[8]}?nameStatusfind=dxl')"
								class="btn btn-success mt-3 btn-lg" style="color: white;">Xác
								nhận đơn</button>
						</c:if>
						<c:if test="${fn:toLowerCase(listOrderDetai[1]) eq 'đang xử lý'}">
							<button
								onclick="confirmAction('/admin/order/success/${listOrderDetai[8]}?nameStatusfind=dvc')"
								class="btn btn-success mt-3 btn-lg" style="color: white;">Vận
								chuyển</button>
						</c:if>
					</c:if>
					<c:if
						test="${fn:toLowerCase(listOrderDetai[1]) eq 'đang vận chuyển'}">
						<button
							onclick="confirmAction('/admin/order/success/${listOrderDetai[8]}?nameStatusfind=dgh')"
							class="btn btn-success mt-3 btn-lg" style="color: white;">Đã
							giao hàng</button>
					</c:if>

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
					<form id="cancelForm" action="/admin/order/cancel" method="post">
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
            title: "Bạn có chắt chắn muốn thực hiện hành động này?",
            text: "Bạn sẽ không thể hoàn tác tác vụ đã thực hiện!",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Có, tôi đồng ý!",
            cancelButtonText: "Hủy",
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = url;
            }
        });
    }
</script>



</body>
</html>
