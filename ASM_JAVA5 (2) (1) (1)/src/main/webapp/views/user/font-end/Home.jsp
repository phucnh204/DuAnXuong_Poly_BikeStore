<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<main>
	<div class="slider">
		<div id="carouselExampleControls" class="carousel slide"
			data-bs-ride="carousel">
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img
						src="https://bikeshopsaigon.com/uploads/files/banner/01%20copy.jpg"
						class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img
						src="https://bikeshopsaigon.com/uploads/files/banner/02%20copy.jpg"
						class="d-block w-100" alt="...">
				</div>
				<div class="carousel-item">
					<img
						src="https://bikeshopsaigon.com/uploads/files/banner/03%20copy.jpg"
						class="d-block w-100" alt="...">
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
				data-bs-target="#carouselExampleControls" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleControls" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true"></span>
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</div>
	<div class="CardSlider">
		<section>
			<!-- card slider start -->
			<div class="row text-center mt-3">
				<h3>Sản phẩm mới</h3>
				<div class="line-box">
					<div class="line"></div>
				</div>
			</div>
			<div class="container mt-3">
				<div class="swiper-container">
					<div class="swiper mySwiper">
						<div class="swiper-wrapper">

							<c:forEach var="item" items="${listnew.content}">

								<div class="swiper-slide">
									<div class="card slider-item">
										<a href="/product/detail/${item[0]}" style="text-decoration: none; color: black">
											<div class="">
												<img src="/images/${item[5]}" alt="Card Image" class=" img-fluid fixed-ratio imgae-bicycle">
											</div>
											<h3 class="bicycle-name">${item[1]}</h3>
											<p class="text-danger fw-bold" style="font-size: 20px">
												<fmt:formatNumber>${item[9]}</fmt:formatNumber>đ
											</p>
										</a>
									</div> 
								</div>

							</c:forEach> 


						</div>
					</div>
					<!-- If we need pagination -->
					<div class="swiper-pagination"></div>
					<!-- If we need navigation buttons -->
					<div class="swiper-button-prev"></div>
					<div class="swiper-button-next"></div>
					<!-- If we need scrollbar -->
					<div class="swiper-scrollbar"></div>
				</div>
			</div>
			<!-- card slider end -->
		</section>
	</div>
	<div class="product mt-4">
		<div class="row text-center mt-3">
			<h3>SẢN PHẨM BÁN CHẠY</h3>
			<div class="line-box">
				<div class="line"></div>
			</div>
		</div>


		<div class="row mt-3">
			<c:forEach var="item" items="${listItem.content}">

				<div class="col-md-3 mb-3">
					<div class="card bicycle-product">
						<a href="/product/detail/${item[0]}"
							style="text-decoration: none; color: black"> <input
							type="hidden" value="${item[10]}">
							<div class="card border border-0">
								<img src="/images/${item[5]}"
									class="card-img-top pt-3 mb-1  px-4 imgae-bicycle img-fluid fixed-ratio"
									alt="...">
							</div>

							<div class="card-body">
								<button type="button"
									class="btn px-1 py-0 fw-medium text-secondary-emphasis mb-2 mx-2 button-type"
									style="font-size: 14px; border-radius: 0px; background-color: #dedede; color: #6c757d; font-weight: bold; border-radius: 2px;">
									${item[11]}</button>

								<p style="font-weight: 500;"
									class="card-text fw-medium fs-6 bicycle-name mx-1 name-bicycle">
									${item[1]}</p>
								<hr />
								<p class="mx-1 my-0 text-danger fw-medium"
									style="font-size: 17px;">
									<fmt:formatNumber>${item[9]}</fmt:formatNumber>
									đ
								</p>
							</div>
						</a>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

	<section>

		<div class="row text-center mt-4">
			<h3>SẢN PHẨM XE ĐẠP</h3>
			<div class="line-box">
				<div class="line"></div>
			</div>
		</div>
		<!--Product card hover start-->
		<div class="row mt-3">

			<div class="col-lg-3">
			<a href="/home/products?idcty=7" style="text-decoration: none; color: black">
				<div class="image-box">
					<img
						src="https://bikeshopsaigon.com/uploads/files/banner/domane/357450622_660002826148073_6272561996154329821_n.jpg"
						alt="Your Image" class="img-fluid" style="height: 30vh">
					<div class="image-mask"></div>
					<div class="image-title">
						<h2>TREK BIKE</h2>
					</div>
				</div>
				</a>
			</div>
			<div class="col-lg-3">
			<a href="/home/products?idcty=9" style="text-decoration: none; color: black">
				<div class="image-box">
					<img
						src="https://bikeshopsaigon.com/uploads/files/banner/domane/__thumbs/334686870_229428076138821_6551316148583333927_n.jpg/334686870_229428076138821_6551316148583333927_n__600x400.jpg"
						alt="Your Image" class="img-fluid" style="height: 30vh">
					<div class="image-mask"></div>
					<div class="image-title">
						<h2>ROAD BIKE</h2>
					</div>
				</div>
				</a>
			</div>
			<div class="col-lg-3">
			<a href="/home/products?idcty=11" style="text-decoration: none; color: black">
				<div class="image-box">
					<img
						src="https://bikeshopsaigon.com/uploads/images/products-images/MadoneSLR7_23_37025_E_Primary.jpg"
						alt="Your Image" class="img-fluid" style="height: 30vh">
					<div class="image-mask"></div>
					<div class="image-title">
						<h2>CITY BIKE</h2>
					</div>
				</div>
				</a>
			</div>
			<div class="col-lg-3">
			<a href="/home/products?idcty=12" style="text-decoration: none; color: black">
				<div class="image-box">
					<img
						src="https://bikeshopsaigon.com/uploads/images/products-images/Screenshot_2022-08-02_184738.png"
						alt="Your Image" class="img-fluid" style="height: 30vh">
					<div class="image-mask"></div>
					<div class="image-title">
						<h2>MINI BIKE</h2>
					</div>
				</div>
				</a>
			</div>
		</div>
		<div class="row mt-3">
			<div class="col-lg-6">
			<a href="/home/products?idcty=8" style="text-decoration: none; color: black">
				<div class="image-box">
					<img
						src="https://bikeshopsaigon.com/uploads/images/04%20-%20Chi%20ti%E1%BA%BFt%20s%E1%BA%A3n%20ph%E1%BA%A9m/h%C3%ACnh%20l%C3%A0m%20web/h%C3%ACnh%20l%C3%A0m%20web%2019/%E1%BA%A2nh%20ch%E1%BB%A5p%20m%C3%A0n%20h%C3%ACnh%202024-04-11%20131411.png"
						alt="Your Image" class="img-fluid" style="height: 50vh">
					<div class="image-mask"></div>
					<div class="image-title">
						<h2>FIXED GEAR</h2>
					</div>
				</div>
				</a>
			</div>
			<div class="col-lg-6">
			<a href="/home/products?idcty=10" style="text-decoration: none; color: black">
				<div class="image-box">
					<img
						src="https://bikeshopsaigon.com/uploads/images/03%20-%20Danh%20m%E1%BB%A5c%20s%E1%BA%A3n%20ph%E1%BA%A9m/%E1%BA%A2nh%20ch%E1%BB%A5p%20m%C3%A0n%20h%C3%ACnh%202023-12-22%20164155.png"
						alt="Your Image" class="img-fluid" style="height: 50vh">
					<div class="image-mask"></div>
					<div class="image-title">
						<h2>TOURING BIKE</h2>
					</div>
				</div>
				</a>
			</div>
		</div>

		<!--Product card hover end-->
	</section>

</main>