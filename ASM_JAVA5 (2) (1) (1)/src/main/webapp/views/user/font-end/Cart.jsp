<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>    
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		<section class="h-100 gradient-custom">
  <div class="container">
    <div class="row d-flex justify-content-center my-3">
      <div class="col-md-8">
        <div class="card mb-4">
          <div class="card-header bg-color text-white py-3 ">
            <h5 class="mb-0">Giỏ hàng - ${quantityProduct} sản phẩm</h5>
          </div>
          <div class="card-body">
            <!-- Single item -->
            <c:forEach var="PD" items="${cartDetails}"  varStatus="status">
            	<div class="row">
            	 <!-- Image -->
                
              <div class="col-lg-3 col-md-12 mb-4 mb-lg-0">
               
                <div class="bg-image hover-overlay hover-zoom ripple rounded" data-mdb-ripple-color="light">
                  <img src="/images/${productsDetails[status.index].imagedetail}"
                    class="w-100" alt="Blue Jeans Jacket" />
                  <a href="#!">
                    <div class="mask" style="background-color: rgba(251, 251, 251, 0.2)"></div>
                  </a> 
                </div>
                <!-- Image -->
              </div>

              <div class="col-lg-5 col-md-6 mb-4 mb-lg-0">
                <!-- Data -->
                <p><strong>${productsName[status.index]}</strong></p>
                <p>Color: ${productsDetails[status.index].color.nameColor}</p>
                <p>Size: ${productsDetails[status.index].size.nameSize}</p>
                <a href="/cart/remove/${PD.id}" type="button" data-mdb-button-init data-mdb-ripple-init class="btn btn-primary btn-sm me-1 mb-2" data-mdb-tooltip-init
                  title="Remove item">
                  <i class="fas fa-trash"></i>
                </a>
                
                <!-- Data -->
              </div>

              <div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
                <!-- Quantity -->
                <form action="/cart/update" method="post">
                	                <div class="d-flex mb-4" style="max-width: 300px">
                  <input value="${PD.id}" name="idCartDetail" type="hidden"/>
                   <input value="${productsDetails[status.index].id}" name="idProduct" type="hidden"/>
                  <button data-mdb-button-init data-mdb-ripple-init class="btn bg-color text-white px-3 me-2"
                    onclick="this.parentNode.querySelector('input[type=number]').stepDown();">
                    <i class="fas fa-minus"></i>
                  </button>

                  <div data-mdb-input-init class="form-outline">
                    <input id="form1" min="1" max="999999" name="quantity" value="${PD.quantity}" type="number" class="form-control" onblur="this.form.submit();" />
                    
                  </div>

                  <button data-mdb-button-init data-mdb-ripple-init class="btn bg-color text-white px-3 ms-2"
                    onclick="this.parentNode.querySelector('input[type=number]').stepUp();">
                    <i class="fas fa-plus"></i>
                  </button>
                  <c:set var="check" value="false"></c:set>
                  <c:forEach var="id" items="${cartDetailIds}">
                  <c:if test="${id == PD.productDetail.id || id == idPayNow}">
                  	<c:set var="check" value="true"></c:set>
				 </c:if>
				 </c:forEach>
                <input class="ms-3" type="checkbox" name="cartDetailId" value="${PD.productDetail.id}" onchange="getValue();" ${check ? 'checked' : 'unchecked' } style="width: 20px">
                </div>
                </form>

                <!-- Quantity -->

                <!-- Price -->
                <p class="mt-5 text-center">
                  <strong><fmt:formatNumber>${productsDetails[status.index].price * PD.quantity}</fmt:formatNumber> đ</strong>
                </p>
                <!-- Price -->
              </div>
            </div>
            <!-- Single item -->
            <hr class="my-4" />
            </c:forEach>

   
          </div>
        </div>
        <div class="card mb-4">
          <div class="card-body">
            <p><strong>Tbike store chúc các bạn có một buổi shopping vui vẻ</strong></p>
            <p class="mb-0">mọi thắc mắc liên hệ: 0909099099</p>
          </div>
        </div>
        <div class="card mb-4 mb-lg-0">
          <div class="card-body">
            <p><strong>We accept</strong></p>
            <img class="me-2" width="65px"
              src="https://cdn.haitrieu.com/wp-content/uploads/2022/10/Logo-VNPAY-QR-1.png"
              alt="VNPay" />
          </div>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card mb-4">
          <div class="card-header bg-color text-white py-3">
            <h5 class="mb-0">Thông tin thanh toán</h5>
          </div>
          <div class="card-body">
            <ul class="list-group list-group-flush">
              <li
                class="list-group-item d-flex justify-content-between align-items-center border-0 px-0 mb-3">
                <div>
                  <strong class="fs-5">Tổng tiền:</strong>
                </div>
                <span><strong> <fmt:formatNumber>${totalPice}</fmt:formatNumber> đ </strong></span>
              </li>
            </ul>

            <a  href="/cart/checkout" data-mdb-button-init data-mdb-ripple-init class=" fw-bold d-grid gap-1 btn bg-color text-white text-center btn-block">
              Thanh toán
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
<script type="text/javascript">
function getValue() {
    let checkboxes = document.getElementsByName('cartDetailId');
    let result = "";
    for (var i = 0; i < checkboxes.length; i++) {
        if (checkboxes[i].checked) {
            result += checkboxes[i].value + ",";
        }
    }
    window.location.href = "/cart/pay?ids=" + result;
}
</script>


