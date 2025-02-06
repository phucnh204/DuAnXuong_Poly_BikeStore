<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<style>
.page_404 {
	padding: 40px 0;
	background: #fff;
	font-family: 'Arvo', serif;
}

.page_404  img {
	width: 100%;
}

.four_zero_four_bg {
	background-image:
		url(https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif);
		background-repeat: no-repeat;
	height: 400px;
	background-position: center;
}

.four_zero_four_bg h1 {
	font-size: 80px;
}

.four_zero_four_bg h3 {
	font-size: 80px;
}

.link_404 {
	color: #fff !important;
	padding: 10px 20px;
	background: #39ac31;
	margin: 20px 0;
	display: inline-block;
}

.contant_box_404 {
	margin-top: -50px;
}
</style>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>

<body>
	<section class="page_404">
		<div class="container-fluid">
			<div class="row">
				<div class="col-sm-12 ">
					<div class="col-sm-offset-1  text-center">
						<div class="four_zero_four_bg">
							<h1 class="text-center ">404</h1>
						</div>

						<div class="contant_box_404">
							<h3 class="h2">Có gì đó sai sai</h3>

							<p>Trang web này không tồn tại</p>

							<a href="/home" class="link_404">Quay về trang chủ</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>