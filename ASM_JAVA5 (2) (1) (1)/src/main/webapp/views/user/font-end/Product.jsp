<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>

<div class="row mt-3 m-0">
            <div class="col-lg-3 border p-3">
            <p class="fw-bold fs-5">TÌM SẢN PHẨM</p>
				<form class="d-flex mb-3" role="search">
				<input class="form-control" type="search" name="keyword" placeholder="Nhập tên sản phẩm">
			
			 <button class="btn btn-success ms-3" type="submit">Tìm</button>
		</form>
			<hr class="text-black-50 mt-4">
              <p class="fw-bold fs-5">CHỌN MỨC GIÁ</p>
		<div class="middle">
			<div class="multi-range-slider">
			<form action="/home/products" method="get">
				<input type="range" id="input-left" name="minPrice" min="0" max="${priceMax}" value="${priceMinvl}" onmouseup="this.form.submit();">
				<input type="range" id="input-right" name="maxPrice" min="0" max="${priceMax}" value="${priceMaxvl}" onmouseup="this.form.submit();">
			</form>

				<div class="sliderPrice">
					<div class="track"></div>
					<div class="range"></div>
					<div class="thumb left"></div>
					<div class="thumb right"></div>
				</div>
				<div class="values text-center mt-2 ">
					<span id="value-left">0</span> - <span id="value-right">100</span>
				</div>
			</div>
		</div>
			<hr class="text-black-50 mt-4">
		<h5 class="mt-3 fw-bold">CHỌN MÀU SẮC</h5>
              <div class="scrollable-container">
                <form action="">
                  <c:forEach var = "item" items="${colors}">
			<div class="form-check mb-2">
			 <c:set var="check" value="false"></c:set>
			 <c:forEach var="id" items="${colorFilterC}">
                  <c:if test="${id == item.id}">
                  	<c:set var="check" value="true"></c:set>
				 </c:if>
				 </c:forEach>
				<input class="form-check-input " type="checkbox" value="${item.id}" name="color" onchange="getValueColor();" ${check ? 'checked' : 'unchecked' }> 
				<label class="form-check-label">${item.nameColor}</label>
			</div>
		</c:forEach>
                </form>
              </div>
		<hr class="text-black-50 mt-4">
		<h5 class="mt-3 fw-bold">CHỌN KÍCH THƯỚC</h5>
              <div class="scrollable-container">
                <form action="">
                  <c:forEach var = "item" items="${sizes}">
                  <c:set var="check1" value="false"></c:set>
			 <c:forEach var="id" items="${sizeFilterC}">
                  <c:if test="${id == item.id}">
                  	<c:set var="check1" value="true"></c:set>
				 </c:if>
				 </c:forEach>
			<div class="form-check mb-2">
				<input class="form-check-input" type="checkbox" value="${item.id}" name="size" onchange="getValueSize();" ${check1 ? 'checked' : 'unchecked' }> 
				<label class="form-check-label">${item.nameSize}</label>
			</div>
		</c:forEach>
                </form>
              </div>
		

            </div>
            <div class="col-lg-9">
                <div class="Title-product"> ${item[3]}</div>
                <div class="row mt-3">
                  <c:forEach var="item" items="${listItem.content}">
                <div class="col-md-4 mb-3">
                    <div class="card bicycle-product">
                        <a href="/product/detail/${item[0]}" style="text-decoration: none; color: black">
                            <div class="card border border-0">
                                <img src="/images/${item[4]}"
                                    class="card-img-top pt-3 mb-1  px-4 imgae-bicycle" alt="..."
                                    style="height: 160px;">
                            </div>
                        
                        <div class="card-body">
                            <button type="button"
                                class="btn bg-secondary-subtle px-1 py-0 fw-medium text-secondary-emphasis mb-2 mx-2 button-type"
                                style="font-size: 14px; border-radius: 0px">${item[3]}</button>
                            <p class="card-text fw-medium fs-6 bicycle-name mx-1 name-bicycle">
                                ${item[1]}
                            </p>
                            <hr />
                            <p class="mx-1 my-0 text-danger fw-medium" style="font-size: 17px;"><fmt:formatNumber>${item[6]}</fmt:formatNumber> </p>
                        </div>
                        </a>
                    </div>
                </div>
                </c:forEach>
                    
                    

              <div class="row">
			<nav aria-label="">
				<ul class="pagination justify-content-center mt-3">
					<c:if test="${currentPage > 0}">
						<li class="page-item">
							<a class="page-link" href="/home?pageNo=${currentPage - 1}">Previous</a>
						</li>
					</c:if>
					<c:forEach var="page" items="${pageNumbers}">
						<c:choose>
							<c:when test="${page == currentPage}">
								<li class="page-item active" aria-current="page">
									<span class="page-link">${page + 1}</span>
								</li>
							</c:when>
							<c:otherwise>
								<li class="page-item">
									<a class="page-link" href="/home?pageNo=${page}">${page + 1}</a>
								</li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${currentPage < totalPages - 1}">
						<li class="page-item">
							<a class="page-link" href="/home?pageNo=${currentPage + 1}">Next</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>

            </div>
        </div>
		<script>
	var inputLeft = document.getElementById("input-left");
	var inputRight = document.getElementById("input-right");
	
	var thumbLeft = document.querySelector(".sliderPrice > .thumb.left");
	var thumbRight = document.querySelector(".sliderPrice > .thumb.right");
	var range = document.querySelector(".sliderPrice > .range");
	
	var valueLeft = document.getElementById("value-left");
	var valueRight = document.getElementById("value-right");
	
	function formatValue(value) {
		return parseFloat(value).toLocaleString('vi-VN', { style: 'currency', currency: 'VND', minimumFractionDigits: 0, maximumFractionDigits: 0 });
	}
	
	function setLeftValue() {
	  var min = parseFloat(inputLeft.min);
	  var max = parseFloat(inputLeft.max);
	
	  inputLeft.value = Math.min(parseFloat(inputLeft.value), parseFloat(inputRight.value) - 1).toFixed(2);
	  var percent = ((inputLeft.value - min) / (max - min)) * 100;
	
	  thumbLeft.style.left = percent + "%";
	  range.style.left = percent + "%";
	  valueLeft.textContent = formatValue(inputLeft.value);
	}
	
	function setRightValue() {
	  var min = parseFloat(inputRight.min);
	  var max = parseFloat(inputRight.max);
	
	  inputRight.value = Math.max(parseFloat(inputRight.value), parseFloat(inputLeft.value) + 1).toFixed(2);
	  var percent = ((inputRight.value - min) / (max - min)) * 100;
	
	  thumbRight.style.right = (100 - percent) + "%";
	  range.style.right = (100 - percent) + "%";
	  valueRight.textContent = formatValue(inputRight.value);
	}
	
	inputLeft.addEventListener("input", setLeftValue);
	inputRight.addEventListener("input", setRightValue);
	
	inputLeft.addEventListener("mouseover", function () {
	  thumbLeft.classList.add("hover");
	});
	inputLeft.addEventListener("mouseout", function () {
	  thumbLeft.classList.remove("hover");
	});
	inputLeft.addEventListener("mousedown", function () {
	  thumbLeft.classList.add("active");
	});
	inputLeft.addEventListener("mouseup", function () {
	  thumbLeft.classList.remove("active");
	});
	
	inputRight.addEventListener("mouseover", function () {
	  thumbRight.classList.add("hover");
	});
	inputRight.addEventListener("mouseout", function () {
	  thumbRight.classList.remove("hover");
	});
	inputRight.addEventListener("mousedown", function () {
	  thumbRight.classList.add("active");
	});
	inputRight.addEventListener("mouseup", function () {
	  thumbRight.classList.remove("active");
	});
	
	// Initialize values
	setLeftValue();
	setRightValue();
	
	function getValueColor() {
	    let checkboxes = document.getElementsByName('color');
        let min = document.getElementsByName('minPrice')[0];
        let max = document.getElementsByName('maxPrice')[0];
	    let minValue = parseFloat(min.value);
	    let maxValue = parseFloat(max.value);
	    let result = "";
	    for (var i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
	            result += checkboxes[i].value + ",";
	        }
	    }
	    window.location.href = "/home/products?idcl=" + result + "&minPrice=" + minValue + "&maxPrice=" +maxValue + "&check1=true";
	}
	
	function getValueSize() {
	    let checkboxes = document.getElementsByName('size');
        let min = document.getElementsByName('minPrice')[0];
        let max = document.getElementsByName('maxPrice')[0];
	    let minValue = parseFloat(min.value);
	    let maxValue = parseFloat(max.value);
	    let result = "";
	    for (var i = 0; i < checkboxes.length; i++) {
	        if (checkboxes[i].checked) {
	            result += checkboxes[i].value + ",";
	        }
	    }
	    window.location.href = "/home/products?ids=" + result + "&minPrice=" + minValue + "&maxPrice=" +maxValue + "&check2=true";
	}
</script>


