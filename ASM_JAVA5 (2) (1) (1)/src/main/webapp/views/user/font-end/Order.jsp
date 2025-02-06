<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Checkout Page</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<input type="hidden" id="idQuan" value="${idQuan}" />
	<input type="hidden" id="idXaPhuong" value="${idXaPhuong}" />
	<div class="card mt-3">
		<div class="card-body m-1">
			<p class="fs-5" style="color: orange">
				<i class="bi bi-geo-alt-fill"></i> Địa chỉ nhận hàng
			</p>
			<div class="d-flex">
				<p class="fw-bold mb-0">${address.full_name}${address.phone}</p>
				<p class="mb-0 ms-3">${address.full_address}</p>
				<a href="" class="ms-3" data-bs-toggle="modal"
					data-bs-target="#updateAddressModal" style="text-decoration: none">Thay
					đổi</a>
			</div>
		</div>
	</div>
	<div class="card mt-3">
		<div class="card">
			<div class="card-body">
				<div class="row">
					<div class="col-md-7">
						<p class="fw-semibold">Sản phẩm</p>
					</div>
					<div class="col-md-2">
						<p class="fw-light text-center">Đơn giá</p>
					</div>
					<div class="col-md-1">
						<p class="fw-light text-center">Số lượng</p>
					</div>
					<div class="col-md-2">
						<p class="fw-light text-center">Tổng tiền</p>
					</div>
				</div>
				<c:forEach var="PD" items="${cartDetails2}" varStatus="status">
					<div class="row mb-3">
						<div class="col-md-7">
							<div class="row">
								<div class="col-md-2">
									<img
										src="/images/${productsDetails2[status.index].imagedetail}"
										alt="" class="img-fluid" />
								</div>
								<div class="col-md-7 mt-3">
									<div class="">
										<p class="fw-medium">${productsName[status.index]}</p>
									</div>
								</div>
								<div class="col-md-3 mt-3">
									<p>Loại: ${productsDetails2[status.index].size.nameSize},
										${productsDetails2[status.index].color.nameColor}</p>
								</div>
							</div>
						</div>
						<div class="col-md-2 mt-3 text-center">
							<p class="">
								<fmt:formatNumber value="${PD.productDetail.price}" />
							</p>
						</div>
						<div class="col-md-1 mt-3 text-center">
							<p class="">${PD.quantity}</p>
						</div>
						<div class="col-md-2 mt-3 text-center">
							<p class="">
								<fmt:formatNumber
									value="${productsDetails2[status.index].price * PD.quantity}" />
								đ
							</p>
						</div>
					</div>
					<hr />
				</c:forEach>
				<form action="/cart/order1" id="checkoutForm" method="post">
					<div class="row">
						<div class="col-md-8">
							<div class="mb-3">
								<textarea class="form-control" id="note" name="note"
									placeholder="Lời nhắn" rows="3"></textarea>
							</div>
						</div>
					</div>
					<hr />
					<div class="card mt-3">
		<div class="card-body">
			<div class="row mt-3">
				<!-- 					<div class="form-check"> -->
				<!--                                 <input class="form-check-input" type="radio" name="methodPay" checked> -->
				<!--                                 <label class="form-check-label" for="flexRadioDefault1">Thanh toán khi nhận hàng</label> -->
				<!--                             </div> -->
				<!--                             <div class="form-check"> -->
				<!--                                 <input class="form-check-input" type="radio" name="methodPay"> -->
				<!--                                 <label class="form-check-label" for="flexRadioDefault2">Thanh toán VNPay</label> -->
				<!--                             </div> -->
				<!--             		</div> -->
				<div class="checkout-account pay-top sin-payment">
					<input id="payment-method-cash" class="input-radio" type="radio"
						value="Tiền mặt" name="phuongThucThanhToan"> <label
						for="payment-method-3">Thanh toán qua VNPay</label>
					<div style="display: none;"
						class="payment-box open-toogle2 payment_method_bacs">
						<p>Thanh toán bằng tiền mặt khi ship hàng tới</p>
					</div>
				</div>
				<div class="pay-top sin-payment">
					<input checked id="payment-method-online" class="input-radio"
						type="radio" value="VNPay" name="phuongThucThanhToan"> <label
						for="payment-method-3">Thanh Toán khi nhận hàng </label><img
						alt="" src="assets/images/icon-img/payment.png">

				</div>

			</div>
		</div>
	</div>
					<hr>
					<div class="row">
						<div class="col-md-7"></div>
						<div class="col-md-5 text-end fw-bold">
							Tổng tiền (${quantityProduct2} sản phẩm):
							<fmt:formatNumber value="${totalPice}" />
							đ
						</div>
						<div class="row">
							<div class="col-md-9"></div>
							<div class="col-md-3">
								<div class="d-flex">
									<p>Tiền sản phẩm:</p>
									<p class="text-end ms-3">
										<fmt:formatNumber value="${totalPice}" />
										đ
									</p>
								</div>
								<div class="d-flex">
									<p>Phí vận chuyển:</p>
									<p id="shippingFee" class="text-end fw-bold text-danger ms-3">0
										VNĐ</p>
								</div>
								<div class="d-flex">
									<p>Tổng tiền:</p>

									<input type="hidden" name="shippingFee" id="shippingFeeInput"
										value=""> <span id="totalPayment"
										class="text-end fw-bold text-danger ms-3"><fmt:formatNumber
											value="${totalPice}	"></fmt:formatNumber> VND</span> <input
										type="hidden" name="totalPrice" id="totalPrice"
										value='<fmt:formatNumber>${totalPice}</fmt:formatNumber>' />
									<input type="hidden" name="totalPayment1" id="totalPrice"
										value="${totalPice}">
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-md-9">
									<div class="d-flex">
										<p class="me-1">Nhấn "Đặt hàng" đồng nghĩa với bạn đồng ý
											tuân theo</p>
										<a href="" class="" style="text-decoration: none;"> Điều
											khoản Tbike store</a>
									</div>
								</div>
								<div class="col-md-3">
									<button type="submit" class="w-100 btn btn-danger btn-lg">Đặt
										hàng</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="updateAddressModal" tabindex="-1"
		aria-labelledby="updateAddressModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="updateAddressModalLabel">Chọn
						địa chỉ giao hàng</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<c:forEach var="item" items="${listAddress}" varStatus="status">
					<div class="mb-3 ms-3">
						<div class="d-flex">
							<div class="">
								<p class="mb-1 fw-bold">${item.full_name}| ${item.phone}</p>
								<p class="mb-1">${item.full_address}</p>
							</div>
							<c:choose>
								<c:when test="${item.id == idAddress }">
									<div class="ms-auto me-3 mt-3">
										<a
											href="/cart/checkout?idAddress=${status.index}&&id=${item.id}"
											class="btn btn-success ms-3"
											style="display: inline-block; white-space: nowrap;">Đang
											chọn</a>
									</div>
								</c:when>
								<c:otherwise>
									<div class="ms-auto me-3 mt-3">
										<a
											href="/cart/checkout?idAddress=${status.index}&&id=${item.id}"
											class="btn btn-success"
											style="display: inline-block; white-space: nowrap;">Chọn</a>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var checkoutForm = document.getElementById('checkoutForm');
			var cashPayment = document.getElementById('payment-method-cash');
			var onlinePayment = document
					.getElementById('payment-method-online');

			function updateFormAction() {
				if (cashPayment.checked) {
					checkoutForm.action = "/cart/order";
				} else if (onlinePayment.checked) {
					checkoutForm.action = "/cart/order1";
				}
			}

			cashPayment.addEventListener('change', updateFormAction);
			onlinePayment.addEventListener('change', updateFormAction);
		});

		$(document)
				.ready(
						function() {
							let toDistrictId = parseInt($('#idQuan').val());
							let toWardCode = $('#idXaPhuong').val();

							let requestData = {
								service_type_id : 2,
								from_district_id : 1454,
								to_district_id : toDistrictId,
								to_ward_code : toWardCode,
								height : 10,
								length : 10,
								weight : 20,
								width : 20,
								insurance_value : 0,
								coupon : null,
							};

							$
									.ajax({
										url : 'https://online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee',
										type : 'POST',
										contentType : 'application/json',
										headers : {
											'Token' : '879adcac-27e2-11ef-a913-2eff54431c44', // Add your GHN API token here
											'ShopId' : '5127770' // Add your Shop ID here
										},
										data : JSON.stringify(requestData),
										success : function(response) {
											if (response.code === 200) {
												let shippingFee = parseInt(response.data.total);
												$('#shippingFee').text(
														shippingFee + ' VNĐ');
												//                     let totalPrice =  $('#totalPrice').val();
												let totalPriceStr = $(
														'#totalPrice').val()
														.replace(/\./g, '');
												let totalPrice = parseFloat(totalPriceStr);
												let tongCong = totalPrice
														+ shippingFee;
												$('#totalPayment').text(
														tongCong + ' VND');
												$('#shippingFeeInput').val(
														shippingFee);
												// Use toLocaleString to format the number without scientific notation
												$('#totalPayment')
														.val(
																tongCong
																		.toLocaleString(
																				'fullwide',
																				{
																					useGrouping : false
																				}));
											} else {
												alert('Error calculating shipping fee: '
														+ response.message);
											}
										},
										error : function() {
											alert('Error making request to shipping fee API');
										}
									});
						});
	</script>



</body>
</html>
