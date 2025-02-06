<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TBike Store</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css" integrity="sha512-SnH5WK+bZxgPHs44uWIX+LLJAJ9/2PkPKZ5QiAj6Ta86w+fsb2TkcmfRyVX3pBnMFcV7oQPJkl9QevSCWr3W6A==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.css"/>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
<%@include file="/views/user/css/style.css"%>
<%@include file="/views/user/css/product.css"%>
<%@include file="/views/user/css/profile.css"%>
<%@include file="/views/user/css/Register.css"%>
<%@include file="/views/user/css/productDetail.css"%>
</style>
</head>
<body>
	<div class="container">
		<%@include file="layout/header.jsp"%>
		<main>
			<jsp:include page="${view}"/>
		</main>
		<%@include file="layout/footer.jsp"%>
	</div>
</body> 
<c:if test="${not empty messageOder}">
		<script>
		  Swal.fire({
		        text: "${messageOder}",
		        confirmButtonText: 'Xác nhận',
		        icon: "success",
		      });
		</script>
	</c:if>

<c:if test="${not empty messageCart}">
		<script>
		  Swal.fire({
		        text: "${messageCart}",
		        confirmButtonText: 'Xác nhận',
		      });
		</script>
	</c:if>
	
	<c:if test="${not empty messageAddress2}">
		<script>
		  Swal.fire({
		        text: "${messageAddress2}",
		        confirmButtonText: 'Xác nhận',
		      });
		</script>
	</c:if>
	
	<c:if test="${not empty messageProduc}">
		<script>
		  Swal.fire({
		        text: "${messageProduc}",
		        confirmButtonText: 'Xác nhận',
		      });
		</script>
	</c:if>
<script src="https://cdn.jsdelivr.net/npm/swiper@10/swiper-bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
    integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
    crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="/views/user/js/main.js"></script>
     <script src="/views/user/js/product.js"></script>
</html>