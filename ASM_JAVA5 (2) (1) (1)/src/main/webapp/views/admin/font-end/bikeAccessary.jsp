<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<style>
.preview-container {
	margin-top: 20px;
}

.preview-container img {
	max-width: 100%;
	height: auto;
	margin-bottom: 10px;
}
 
.preview-container iframe, .preview-container video {
	width: 100%;
	height: 300px;
	margin-bottom: 10px;
}
</style>
<body>
	<div class="container mt-5">
		<h2 class="mb-4">Bike Accessary Management</h2>

		<!-- Nav tabs -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation"><a
				class="nav-link active" id="form-tab" data-toggle="tab" href="#form"
				role="tab" aria-controls="form" aria-selected="true">Add/Edit
					Product</a></li>
			<li class="nav-item" role="presentation"><a class="nav-link"
				id="table-tab" data-toggle="tab" href="#table" role="tab"
				aria-controls="table" aria-selected="false">Product Table</a></li>
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
								<label for="nameBike">Name Accessary</label> <input type="text"
									id="nameBike" name="nameBike" class="form-control" required>
							</div>
						</div>

					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="form-group">
								<label for="type">Type</label> <input type="text" id="type"
									name="type" class="form-control" required>
							</div>
						</div>
						<div class="col-md-6">
							<div class="form-group">
								<label for="status">Trade mark</label> <select id="status"
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
						<!-- Cột cho việc tải lên hình ảnh -->
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
					<button type="button" class="btn btn-warning d-none">Update</button>
					<button type="button" class="btn btn-secondary d-none">Cancel</button>
				</form>
			</div>
			<div class="tab-pane fade p-4" id="table" role="tabpanel" aria-labelledby="table-tab">
    <!-- Table to display existing products -->
    <div class="table-responsive">
        <table id="productTable" class="table  table-bordered">
            <thead class="">
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
                    <td></td>
                    <td><a href="" style="">link</a></td>
                    <td>Activing</td>
                    <td>2</td>
                    <td>
                        <a href="#" class="btn btn-sm btn-primary">Edit</a>
                        <a href="#" class="btn btn-sm btn-info">Details</a>
                    </td>
                </tr>
                <!-- Các hàng khác nếu cần -->
            </tbody>
        </table>
    </div>
</div>

		</div>

	</div>
	<script type="text/javascript">
    $(document).ready(function() {
        // Javascript method's body can be found in assets/js/demos.js
        demo.initDashboardPageCharts();

        demo.showNotification();

    });
</script>
</body>
</html>