<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Đăng Ký</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="/views/account/register.css" rel="stylesheet">
</head> 
<body>
	<div class="container">
		<div class="row justify-content-center mt-5">
			<div class="col-md-7 col-lg-6">
				<div class="card">
					<div class="card-body d-flex flex-column align-items-center">
						<h1 class="text-center mb-4">ĐĂNG KÝ</h1>
						<form:form method="post" modelAttribute="registerData"
							action="/account/register" class="w-100">
							<div class="row">
								<div class="col-md-6">
									<div class="mb-3 w-100">
										<form:input path="username" class="form-control"
											placeholder="Tài khoản*" required="required" />
										<form:errors path="username" class="text-danger validateCheck" />
									</div>
									<div class="mb-3 w-100">
										<form:input path="email" class="form-control"
											placeholder="Email của bạn*" required="required" />
										<form:errors path="email" class="text-danger validateCheck" />
									</div>
									<div class="mb-3 w-100">
										<form:input path="fullname" class="form-control"
											placeholder="Họ và tên*" required="required" />
										<form:errors path="fullname" class="text-danger validateCheck" />
									</div>
								</div>
								<div class="col-md-6">
									<div class="mb-3 w-100">
										<form:password path="password" class="form-control"
											placeholder="Mật khẩu*" required="required" />
										<form:errors path="password" class="text-danger validateCheck" />
									</div>
									<div class="mb-3 w-100">
										<form:password path="confirmPassword" class="form-control"
											placeholder="Xác nhận mật khẩu*" name="confirmPassword"
											required="required" />
										<form:errors path="confirmPassword"
											class="text-danger validateCheck" />
									</div>
									<div class="mb-3 w-100">
										<div class="text-white pt-2">
											<form:label path="gender">Giới tính:</form:label>
											<form:radiobutton path="gender" value="true"
												required="required" />
											Nam
											<form:radiobutton path="gender" value="false"
												required="required" />
											Nữ
										</div>
										<form:errors path="gender" class="text-danger validateCheck" />
									</div>
								</div>
							</div>
							<button type="submit" class="btn btn-primary btn-block">Đăng
								ký</button>
							<div class="text-center mt-2">
								<span class="text-white">Bạn đã có tài khoản?</span> <a
									href="/account/login" class="fw-medium text-orange"
									style="text-decoration: none;">Đăng nhập</a>
							</div>
						</form:form>

					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
