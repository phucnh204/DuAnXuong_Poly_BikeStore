<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<title>Thông tin tài khoản</title>

<style>


.card {
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	margin-bottom: 20px;
}

.card-header {
	background-color: #ff5722;
	color: white;
	font-weight: bold;
}

.assert-3 {
	font-weight: bold;
}

.add-address, .btn-link, .default-address {
	color: #ff5722;
	font-weight: bold;
	text-decoration: none;
}

.add-address:hover, .btn-link:hover, .default-address:hover {
	text-decoration: underline;
}

.row-divider {
	border-top: 1px solid #e0e0e0;
	margin: 10px 0;
}

.form-check-input:checked {
	background-color: #ff5722;
	border-color: #ff5722;
}

.btn-custom {
	background-color: #ff5722;
	color: white;
	border: none;
	border-radius: 4px;
	padding: 10px 20px;
	font-weight: bold;
}

.btn-custom:hover {
	background-color: #e64a19;
}

.modal-content {
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.modal-header {
	background-color: #ff5722;
	color: white;
}

.modal-title {
	font-weight: bold;
}

.btn-close {
	background-color: white;
}

.form-control {
	border-radius: 4px;
	margin-bottom: 15px;
}

.btn-primary {
	background-color: #ff5722;
	border: none;
	border-radius: 4px;
	padding: 10px 20px;
	font-weight: bold;
}

.btn-primary:hover {
	background-color: #e64a19;
}

.btn-secondary {
	border-radius: 4px;
	padding: 10px 20px;
	font-weight: bold;
}

.address-info {
	display: inline-block;
}

.address-detail {
	margin-top: 5px;
}

.address-item {
	margin-bottom: 15px;
}

.btn-link {
	font-weight: bold;
	color: #ff5722;
	text-decoration: none;
}

.btn-link:hover {
	text-decoration: underline;
}
</style>

</head>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<body>

	<div class="container mt-3">
		<div class="row">
			<!-- Thông tin tài khoản -->
			<div class="col-md-6">


				<div class="card">
					<div class="card-header">Hồ sơ của tôi</div>
					<div class="card-body">
						<h4>Thông tin</h4>
						<hr>
						<form action="/home/profile/update" class="mt-3" method="post">
							<div class="mb-3 row">
								<label class="col-md-3 col-form-label assert-3">Tên đăng
									nhập</label>
								<div class="col-md-9 col-form-label">${account.username}</div>
							</div>
							<div class="mb-3 row">
								<label class="col-md-3 col-form-label assert-3">Tên</label>
								<div class="col-md-9">
									<input type="text" class="form-control" name="fullname"
										value="${account.fullname}" required="required">
								</div>
							</div>
							<div class="mb-3 row">
								<label class="col-md-3 col-form-label assert-3">Email</label>
								<div class="col-md-9">
									<input type="email" for="email" name="email"
										class="form-control" value="${account.email}"
										required="required">
								</div>
							</div>
							<div class="mb-3 row">
								<label class="col-md-3 col-form-label assert-3">Số điện
									thoại</label>
								<div class="col-md-9">
									<input class="form-control" name="phone" required="required"
										value="${not empty account.addresses ? account.addresses[0].phone : ''}">
								</div>
							</div>
							<div class="mb-3 row">
								<label class="col-md-3 col-form-label assert-3">Giới
									tính</label>
								<div class="col-md-9">
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="gender"
											id="male" value="true"
											${account.gender == 'true' ? 'checked' : ''}> <label
											class="form-check-label" for="male">Nam</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="gender"
											id="female" value="false"
											${account.gender == 'false' ? 'checked' : ''}> <label
											class="form-check-label" for="female">Nữ</label>
									</div>
								</div>
							</div>
							<div class="d-flex justify-content-between">
								<button class="btn btn-custom">Lưu</button>
							</div>
						</form>
					</div>
				</div>
			</div>
			<!-- Địa chỉ của tôi -->
			<div class="col-md-6">
    <div class="card" style="height: 494px">
        <div class="card-header">Địa chỉ của tôi</div>
        <div class="card-body">
            <h4>Danh sách địa chỉ</h4>
            <hr>
            <div class="address-container">
                <c:forEach items="${addresses}" var="address">
                    <div class="address-item mb-3">
                        <div class="d-flex justify-content-between">
                            <div>
                                <span class="address-info"><strong>${address.full_name}</strong> | ${address.phone}</span>
                                <p class="address-detail">${address.full_address}</p>
                            </div>
                            <div>
                                <button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#editAddressModal${address.id}" onclick="loadAddressData(${address.id}, '${address.province_id}', '${address.district_id}', '${address.ward_code}')">Chỉnh sửa</button>
                                /
                                <form action="/api/home/profile/deleteAddress/${address.id}" method="post" style="display: inline;">
                                    <button type="submit" class="btn btn-link" onclick="return confirm('Bạn có chắc chắn muốn xóa địa chỉ này?');">Xóa</button>
                                </form>
                            </div>
                        </div>
                        <!-- Modal Chỉnh sửa Địa chỉ -->
                        <div class="modal fade" id="editAddressModal${address.id}" tabindex="-1" aria-labelledby="editAddressModalLabel${address.id}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="editAddressModalLabel${address.id}">Chỉnh sửa địa chỉ</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        <form action="/api/home/profile/updateAddress" method="post">
                                            <input type="hidden" name="addressId" value="${address.id}">
                                            <div class="mb-3">
                                                <label for="fullname" class="form-label">Họ và tên</label>
                                                <input type="text" class="form-control" name="fullname" value="${address.full_name}">
                                            </div>
                                            <div class="mb-3">
                                                <label for="phone" class="form-label">Số điện thoại</label>
                                                <input type="text" class="form-control" name="phone" value="${address.phone}">
                                            </div>
                                            <div class="mb-3">
                                                <label for="address" class="form-label">Địa chỉ cụ thể</label>
                                                <input type="text" class="form-control" name="address" value="${address.address}">
                                            </div>
                                            <label for="province${address.id}">Thành phố:</label>
                                            <select id="province${address.id}" name="province" class="form-control">
                                                <option value="">Chọn thành phố</option>
                                            </select>
                                            <label for="district${address.id}">Quận/Huyện:</label>
                                            <select id="district${address.id}" name="district" class="form-control" >
                                                <option value="">Chọn quận/huyện</option>
                                            </select>
                                            <label for="ward${address.id}">Xã/Phường:</label>
                                            <select id="ward${address.id}" name="ward" class="form-control" >
                                                <option value="">Chọn xã/phường</option>
                                            </select>
                                            <input type="hidden" name="nameProvince" id="nameProvince${address.id}">
                                            <input type="hidden" name="nameWard" id="nameWard${address.id}">
                                            <input type="hidden" name="nameDistrict" id="nameDistrict${address.id}">
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                                                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <hr>
            <button type="button" class="btn btn-custom" data-bs-toggle="modal" data-bs-target="#addAddressModal">Thêm địa chỉ mới</button>
            <!-- Modal Thêm Địa chỉ -->
            <div class="modal fade" id="addAddressModal" tabindex="-1"
							aria-labelledby="addAddressModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<h5 class="modal-title" id="addAddressModalLabel">Thêm
											địa chỉ mới</h5>
										<button type="button" class="btn-close"
											data-bs-dismiss="modal" aria-label="Close"></button>
									</div>
									<div class="modal-body">
										<div>
											<h1>Chọn địa chỉ giao hàng</h1>
											<form action="/api/home/profile/addAddress" method="post"
												id="addressForm">

												<div class="mb-3">
													<label for="fullname" class="form-label">Họ và tên</label>
													<input type="text" class="form-control" name="fullname"
														required="required">
												</div>
												<div class="mb-3">
													<label for="phone" class="form-label">Số điện thoại</label>
													<input type="text" class="form-control" name="phone"
														required="required">
												</div>
												<div class="mb-3">
													<label for="address" class="form-label">Địa chỉ cụ thể</label> <input
														class="form-control" name="address">
												</div>
												<label for="province">Thành phố:</label> <select class="form-control"
													id="province" name="province">
													<option value="">Chọn thành phố</option>
												</select> <label for="district">Quận/Huyện:</label> <select class="form-control"
													id="district" name="district" >
													<option value="">Chọn quận/huyện</option>
												</select> <label for="ward">Xã/Phường:</label> <select id="ward" class="form-control"
													name="ward" >
													<option value="">Chọn xã/phường</option>
												</select>
												     <input type="hidden" name="nameProvince" id="nameProvince">
													 <input type="hidden" name="nameWard" id="nameWard">
													 <input type="hidden" name="nameDistrict" id="nameDistrict">
												<div class="modal-footer">
													<button type="button" class="btn btn-secondary"
														data-bs-dismiss="modal">Hủy</button>
													<button type="submit" class="btn btn-primary">Thêm</button>
												</div>
											</form>

										</div>
									</div>
								</div>
							</div>
						</div>
            <!-- ... (add address modal code remains the same) -->
        </div>
    </div>
</div>
		</div>
	</div>


	

		
	
	<script type="text/javascript">
	
	$(document).ready(function() {
	    // Load provinces
	    $.get("/api/provinces", function(data) {
	        let provinces = JSON.parse(data).data;
	        provinces.forEach(function(province) {
	            $('#province').append(new Option(province.ProvinceName, province.ProvinceID));
	        });
	    });

	    // Load districts based on selected province
	    $('#province').change(function() {
	        let provinceId = $(this).val();

	        if (provinceId) {
	            $('#district').empty().append(new Option('Chọn quận/huyện', ''));
	            $('#ward').empty().append(new Option('Chọn xã/phường', ''));

	            $.get("/api/districts", { province_id: provinceId }, function(data) {
	                let districts = JSON.parse(data).data;
	                districts.forEach(function(district) {
	                    $('#district').append(new Option(district.DistrictName, district.DistrictID));
	                });
	            });
	        } else {
	            $('#district').empty().append(new Option('Chọn quận/huyện', ''));
	            $('#ward').empty().append(new Option('Chọn xã/phường', ''));
	        }
	    });

	    // Load wards based on selected district
	    $('#district').change(function() {
	        let districtId = $(this).val();
	        if (districtId) {
	            $('#ward').empty().append(new Option('Chọn xã/phường', ''));

	            $.get("/api/wards", { district_id: districtId }, function(data) {
	                let wards = JSON.parse(data).data;
	                wards.forEach(function(ward) {
	                    $('#ward').append(new Option(ward.WardName, ward.WardCode));
	                });
	            });
	        } else {
	            $('#ward').empty().append(new Option('Chọn xã/phường', ''));
	        }
	    });

	    // Set ward name on change
	    $('#ward').change(function() {
	        let wardName = $('#ward option:selected').text();
	        $('#nameWard').val(wardName);
	    });
	    $('#district').change(function() {
	        let districtName = $('#district option:selected').text();
	        $('#nameDistrict').val(districtName);
	    });
	    $('#province').change(function() {
	        let provinceName = $('#province option:selected').text();
	        $('#nameProvince').val(provinceName);
	    });
	});

	</script>
	
	<script type="text/javascript">
	function loadAddressData(addressId, selectedProvinceId, selectedDistrictId, selectedWardCode) {
	    let provinceSelect = $('#province' + addressId);
	    let districtSelect = $('#district' + addressId);
	    let wardSelect = $('#ward' + addressId);

	    // Load provinces and set the selected one
	    $.get("/api/provinces", function(data) {
	        let provinces = JSON.parse(data).data;
	        provinceSelect.empty().append(new Option('Chọn thành phố', ''));
	        provinces.forEach(function(province) {
	            provinceSelect.append(new Option(province.ProvinceName, province.ProvinceID));
	        });
	        provinceSelect.val(selectedProvinceId);

	        // Trigger the change event to load districts
	        provinceSelect.trigger('change');
	    });

	    // Load districts based on the selected province
	    provinceSelect.change(function() {
	        let provinceId = $(this).val();
	        if (provinceId) {
	            districtSelect.empty().append(new Option('Chọn quận/huyện', ''));
	            $.get("/api/districts", { province_id: provinceId }, function(data) {
	                let districts = JSON.parse(data).data;
	                districts.forEach(function(district) {
	                    districtSelect.append(new Option(district.DistrictName, district.DistrictID));
	                });
	                districtSelect.val(selectedDistrictId);

	                // Trigger the change event to load wards
	                districtSelect.trigger('change');
	            });
	        } else {
	            districtSelect.empty().append(new Option('Chọn quận/huyện', ''));
	            wardSelect.empty().append(new Option('Chọn xã/phường', ''));
	        }
	    });

	    // Load wards based on the selected district
	    districtSelect.change(function() {
	        let districtId = $(this).val();
	        if (districtId) {
	            wardSelect.empty().append(new Option('Chọn xã/phường', ''));
	            $.get("/api/wards", { district_id: districtId }, function(data) {
	                let wards = JSON.parse(data).data;
	                wards.forEach(function(ward) {
	                    wardSelect.append(new Option(ward.WardName, ward.WardCode));
	                });
	                wardSelect.val(selectedWardCode);
	            });
	        } else {
	            wardSelect.empty().append(new Option('Chọn xã/phường', ''));
	        }
	    });

	    // Set hidden input values
	    wardSelect.change(function() {
	        let wardName = $('#ward' + addressId + ' option:selected').text();
	        $('#nameWard' + addressId).val(wardName);
	    });
	    districtSelect.change(function() {
	        let districtName = $('#district' + addressId + ' option:selected').text();
	        $('#nameDistrict' + addressId).val(districtName);
	    });
	    provinceSelect.change(function() {
	        let provinceName = $('#province' + addressId + ' option:selected').text();
	        $('#nameProvince' + addressId).val(provinceName);
	    });
	}
	
	

	
</script>