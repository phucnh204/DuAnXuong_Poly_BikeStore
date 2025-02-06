<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<header>
	<!-- Header start -->

	<div class="header__wrap">
		<div class="header__menu-mobile">
			<div class="header__menu-mobile__btn">
				<div data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample"
					aria-controls="offcanvasExample">
					<i class="fa-solid fa-bars"></i>
				</div>
				<div>
					<i class="fa-solid fa-magnifying-glass"></i>
				</div>
			</div>
			<div class="offcanvas offcanvas-start" tabindex="-1"
				id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasExampleLabel"></h5>
					<button type="button" class="btn-close text-reset"
						data-bs-dismiss="offcanvas" aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link disabled"
							aria-current="page" href="/home"> <i class="bi bi-house"></i>TRANG
								CHỦ
						</a></li>
						<li class="nav-item "><a class="nav-link disabled"
							aria-current="page" href="/home/products"> <i
								class="bi bi-person-fill"></i> SẢN PHẨM
						</a></li>
						<li class="nav-item"><a class="nav-link disabled" href="#">
								<i class="bi bi-list-ul"></i>SALE OFF
						</a></li>
						<li class="nav-item"><a class="nav-link disabled"
							aria-disabled="true"> <i class="bi bi-telephone-fill"></i>TIN
								TỨC
						</a></li>
						<li class="nav-item"><a class="nav-link disabled"
							aria-disabled="true"> <i class="bi bi-envelope-fill"></i>CHÍNH
								SÁCH NHƯỢNG QUYỀN
						</a></li>
						<li class="nav-item"><a class="nav-link disabled"
							aria-disabled="true"> <i class="bi bi-person-fill"></i> GIỚI
								THIỆU
						</a></li>
						<li class="nav-item"><a class="nav-link disabled"
							aria-disabled="true"> <i class="bi bi-question-circle-fill"></i>GIỚI
								THIỆU
						</a></li>
						<li class="nav-item"><a class="nav-link disabled"
							aria-disabled="true"> <i class="bi bi-question-circle-fill"></i>LIÊN
								HỆ
						</a></li>
					</ul>
				</div>
			</div>
		</div>
		<a href="/home" class="header__logo"> <img
			src="/views/user/Icons/LogoTbikeStore1.jpg" alt="" width="80px">
		</a>
		<div class="header__hotline">
			<i class="fa-solid fa-headset"></i> <span> HOTLINE: <span><a
					href="#" title="Hotline: 0399839632 | 0788612959"> 0399839632 |
						0788612959 </a></span>
			</span>
		</div>
		<!-- <div class="header__address">
			<i class="fa-solid fa-location-dot"></i> <span><a href="#"
				title="Hệ thống cửa hàng"> Hệ thống cửa hàng </a></span>
		</div> -->
		<c:if test="${view ne 'Product.jsp'}">
			<div class="header__search">
				<form class="d-flex" role="search">
					<input type="search" name="keyword" placeholder="Tìm sản phẩm">

					<button class="btn btn-product" type="submit">Tìm</button>
				</form>

			</div>
		</c:if>

		<div class="header__action">
			<!-- <div class="header__look-up header__icon">
				<img src="/views/user/Icons/tracuu.svg" alt="">
			</div> -->
			<c:if test="${not empty sessionScope.isLoggedIn}">
				<div class="header__account header__icon nav-item dropdown">
					<img src="/views/admin/assets/img/NamDZ.jpg" alt=""
						class="dropdown-toggle" role="button" data-bs-toggle="dropdown"
						aria-expanded="false" style="width: 40px; border-radius: 50%;">
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="/home/profile2">Trang
								cá nhân</a></li>
						<li><a class="dropdown-item" href="/changePassword">Đổi
								mật khẩu</a></li>
						<li><a class="dropdown-item" href="/logout">Đăng xuất</a></li>
					</ul>
				</div>
			</c:if>
			<c:if test="${empty sessionScope.isLoggedIn}">
				<div class="header__account header__icon nav-item dropdown">
					<img src="/views/user/Icons/taikhoan.svg" alt=""
						class="dropdown-toggle" role="button" data-bs-toggle="dropdown"
						aria-expanded="false">
					<ul class="dropdown-menu">
						<li><a class="dropdown-item" href="/account/login">Đăng
								nhập</a></li>
						<li><a class="dropdown-item" href="/account/register">Đăng
								ký</a></li>
					</ul>
				</div>
			</c:if>
			<div class="header__cart header__icon">
				<span class="cart-count" id="cart-count">${quantityProduct}</span> <a
					href="/cart/view"> <img src="/views/user/Icons/giohang.svg"
					alt="" id="cart-button" class="dropdown-toggle" role="button"
					data-bs-toggle="dropdown" aria-expanded="false">
				</a>

			</div>


		</div>
	</div>
	<!-- Nav bar start -->
	<nav class="navbar navbar-expand-lg" id="bg-color">
		<div class="container">
			<button class="navbar-toggler " type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="/home"><i class="bi bi-house"></i>TRANG
							CHỦ</a></li>



					<li class="nav-item dropdown position-static"><a
						class="nav-link dropdown-toggle" href="/home/products"
						role="button" data-bs-toggle="dropdown" aria-expanded="false">
							<i class="bi bi-person-fill"></i> SẢN PHẨM
					</a>
						<div class="dropdown-menu w-100 text-center">
							<div class="container-fluid">
								<div class="row w-100">
								<c:forEach var="item" items="${categoriesHeader}">
									<div class="col-12 col-md-3">
										<h4>
										<a href="/home/products" style="text-decoration: none; color: black;">${item.type}</a>
										</h4>
										<a class="dropdown-item" href="/home/products?idcty=${item.id}">${item.type}</a>
									</div>
								</c:forEach>
								

								</div>
							</div>

						</div></li>

					<!-- <li class="nav-item">
                      <a class="nav-link" href="#"
                        ><i class="bi bi-list-ul"></i>SALE OFF</a
                      >
                    </li> -->
					<!-- <li class="nav-item"><a href="/home/news" class="nav-link "
						aria-disabled="true"><i class="bi bi-telephone"></i>TIN TỨC</a></li> -->
					<li class="nav-item"><a href="/home/policy" class="nav-link "
						aria-disabled="true"><i class="bi bi-envelope-fill"></i>CHÍNH
							SÁCH NHƯỢNG QUYỀN</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#" role="button"
						data-bs-toggle="dropdown" aria-expanded="false"> <i
							class="bi bi-person-fill"></i> HƯỚNG DẪN
					</a>
						<ul class="dropdown-menu">
							<li><a class="dropdown-item" href="/home/payment_guide">Hướng
									dẫn thanh toán</a></li>
							<!-- <li><a class="dropdown-item" href="#">Hướng dẫn mua hàng</a></li>
							<li><a class="dropdown-item" href="#">Hướng dẫn chọn xe
									đạp</a></li>
							<li><a class="dropdown-item" href="#">Công nghệ xe đạp</a></li> -->
						</ul></li>
					<li class="nav-item"><a class="nav-link" aria-disabled="true "
						href="/home/about"><i class="bi bi-question-circle-fill"></i>GIỚI
							THIỆU</a></li>
					<li class="nav-item"><a class="nav-link" aria-disabled="true"
						href="/home/contact"><i class="bi bi-question-circle-fill"></i>LIÊN
							HỆ</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Nav bar end -->

	<!-- Header end -->
</header>

<script type="text/javascript">
	document.getElementById("cart-button").addEventListener("click",
			function() {
				window.location.href = "/cart/view";
			});
</script>