<!--
=========================================================
 Light Bootstrap Dashboard - v2.0.1
=========================================================

 Product Page: https://www.creative-tim.com/product/light-bootstrap-dashboard
 Copyright 2019 Creative Tim (https://www.creative-tim.com)
 Licensed under MIT (https://github.com/creativetimofficial/light-bootstrap-dashboard/blob/master/LICENSE)

 Coded by Creative Tim

=========================================================

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="/views/admin/assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="/views/admin/assets/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Light Bootstrap Dashboard - Free Bootstrap 4 Admin Dashboard by Creative Tim</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <!-- CSS Files -->
    <link href="/views/admin/assets/css/bootstrap.min.css" rel="stylesheet" />
    <link href="/views/admin/assets/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="/views/admin/assets/css/demo.css" rel="stylesheet" />
</head> 

<body>
 <div class="container mt-5">
		<h2 class="mb-4">Skin Management</h2>

		<!-- Nav tabs -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" id="form-tab" data-toggle="tab" href="#form"
				role="tab" aria-controls="form" aria-selected="true">Add/Edit
					Product</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="table-tab" data-toggle="tab" href="#table" role="tab"
				aria-controls="table" aria-selected="false">Skin Table</a></li>
		</ul>

		<!-- Tab panes -->
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active p-4" id="form" role="tabpanel"
				aria-labelledby="form-tab">
				<!-- Form for adding/editing a product -->
				<form id="productForm" action="" method="post"
					enctype="multipart/form-data">
					<input type="hidden" id="productId" name="productId">
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="id">ID</label> <input type="text" id="id" name="id"
									class="form-control" disabled="disabled">
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="nameBike">Name Skin</label> <input type="text"
									id="nameBike" name="nameBike" class="form-control" required>
							</div>
						</div>

					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="type">Type skin</label> <input type="text" id="type"
									name="type" class="form-control" required>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="status">Trade mark skin</label> <select id="status"
									name="status" class="form-control" required>
									<option value="Available">Trade mark 1</option>
									<option value="Unavailable">Trade mark 2</option>
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="classify">Classify</label> <input type="text"
									id="classify" name="classify" class="form-control" required>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="price">Price</label> <input type="number" id="price"
									name="price" class="form-control" required>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="quantity">Quantity</label> <input type="number"
									id="quantity" name="quantity" class="form-control" required>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="status">Status</label> <select id="status"
									name="status" class="form-control" required>
									<option value="Available">Available</option>
									<option value="Unavailable">Unavailable</option>
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
						<label >Photos</label>
							<div class=" input-group">
								<input type="file" class="form-control" id="inputGroupFile02">
								
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="describe">Describe</label>
						<textarea id="describe" name="describe" class="form-control"
							rows="4" required></textarea>
					</div>
					<button type="submit" class="btn btn-primary">Add</button>
					<button type="button"  class="btn btn-warning d-none">Update</button>
					<button type="button" 
						class="btn btn-secondary d-none">Cancel</button>
				</form>
			</div>
			<div class="tab-pane fade p-4" id="table" role="tabpanel" aria-labelledby="table-tab">
    <!-- Table to display existing products -->
    <div class="table-responsive">
        <table id="productTable" class="table table-striped">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Name Accessary</th>
                    <th>Type</th>
                    <th>Classify</th>
                    <th>Price</th>
                    <th>Describe</th>
                    <th>Photo</th>
                    <th>Video</th>
                    <th>Status</th>
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>1</td>
                    <td>Name Three</td>
                    <td>Xe đạp</td>
                    <td>Loại người lớn</td>
                    <td>100</td>
                    <td>Xe địa hình ...</td>
                    <td><img src="path_to_your_photo" alt="Photo" width="100"></td>
                    <td><a href="path_to_your_video">Watch Video</a></td>
                    <td>Activing</td>
                    <td>2</td>
                    <td>
                        <a href="#" class="btn btn-primary btn-sm">Edit</a>
                        <a href="#" class="btn btn-info btn-sm">Details</a>
                    </td>
                </tr>
                <!-- Add more rows if needed -->
            </tbody>
        </table>
    </div>
</div>

		</div>

	</div>
</body>
<!--   Core JS Files   -->
<script src="/views/admin/assets/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="/views/admin/assets/js/core/popper.min.js" type="text/javascript"></script>
<script src="/views/admin/assets/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="/views/admin/assets/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="/views/admin/assets/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="/views/admin/assets/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="/views/admin/assets/js/light-bootstrap-dashboard.js?v=2.0.0 " type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="/views/admin/assets/js/demo.js"></script>

</html>
