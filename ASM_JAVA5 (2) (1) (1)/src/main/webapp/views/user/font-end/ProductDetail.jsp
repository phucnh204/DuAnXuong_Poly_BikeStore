<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>

<div class="row mt-3">
	<div class="col-lg-12">
		<div class="row">
			<div class="col-lg-6">
				<%@include file="demoSwiper.jsp"%>
			</div>
			<div class="col-lg-6">
				<div class="row infor-product">
					<h2 class="title-product-detail mt-1">${product.name}</h2>
					<span class="mt-3">SKU:<a class="color-text mt-1">SKU:
							xe-dap-dia-hinh-trek-supercaliber-slr-99-xx-axs-gen-2</a></span> <span
						class="mt-3">Thương hiệu:<a class="color-text">${product.trademark}</a>
						| Tình trạng:<a class="color-text">Còn hàng</a></span> <span class="mt-3">
						<span class="price-product"><fmt:formatNumber>${price}</fmt:formatNumber>₫</span>
					</span>
				</div>
				<hr>

				<form action="/home/cart/add" method="POST">
					<input type="hidden" name="productId" value="${product.id}">
					<input type="hidden" name="colorId" value="${colorId}"> <input
						type="hidden" name="sizeId" value="${sizeId}"> <span>Màu
						sắc:</span>
					<div class="row box-color">
						<c:forEach var="color" items="${colors}">
							<div class="col-md-3">
								<a href="/product/detail/${product.id}/${color[0]}/${sizeId}"
									style="text-decoration: none">
									<div
										class="card mb-3 card-color ${color[0] == colorId ? 'selected' : ''}"
										style="max-width: 540px;" data-image="${color[2]}">
										<div class="row g-0">
											<div class="col-md-3">
												<img src="/images/${color[2]}"
													class="img-fluid rounded-start pt-3 ms-1" alt="...">
											</div>
											<div class="col-md-9">
												<div class="card-body">
													<p class="card-text">
														<small class="text-muted">${color[1]}</small>
													</p>
												</div>
											</div>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>

					<span>Kích thước:</span>
					<div class="row box-size">
						<c:forEach var="size" items="${sizes}">
							<div class="col-md-2">
								<a href="/product/detail/${product.id}/${colorId}/${size.id}"
									style="text-decoration: none; color: black">
									<div
										class="card card-size ${size.id == sizeId ? 'selected' : ''}"
										style="width: 60px">
										<div class="card-body text-center m-0 p-1">
											<h5 class="card-title mt-1">${size.nameSize}</h5>
										</div>
									</div>
								</a>
							</div>
						</c:forEach>
					</div>
					<hr>
					<span>Số lượng:</span>
					<div class="row mt-3">
						<div class="col-lg-4">
							<div class="d-flex mb-4" style="max-width: 200px">
								<button type="button" class="btn bg-color text-white px-3 me-2"
									onclick="decreaseQuantity(this)">
									<i class="fas fa-minus"></i>
								</button>
								<div data-mdb-input-init class="form-outline">
									<input id="form1" min="0" name="quantity" value="1"
										type="number" class="form-control" />
								</div>
								<button type="button" class="btn bg-color text-white px-3 ms-2"
									onclick="increaseQuantity(this)">
									<i class="fas fa-plus"></i>
								</button>
							</div>
						</div>
						<div class="col-lg-4">
							<button type="submit" class="btn btn-addCart2">Thêm vào
								giỏ hàng</button>
						</div>
						<div class="col-lg-4">
							<button type="submit" formaction="/pay/now" class="btn btn-product">Mua ngay</button>
						</div>
					</div>
				</form>

			</div>
		</div>
		<div class="row mt-5">
			<Span class="price-product">Mô tả sản phẩm</Span>
			<hr>
			<Span class="description">${product.description}</Span>
		</div>
	</div>
</div>

<c:if test="${not empty messageProduc}">
		<script>
		  Swal.fire({
		        text: "${messageProduc}",
		        confirmButtonText: 'Xác nhận',
		      });
		</script>
	</c:if>