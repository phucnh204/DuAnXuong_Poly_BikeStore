<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<meta charset="utf-8" />
<title>Swiper demo</title>
<meta name="viewport"
    content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1" />
<!-- Link Swiper's CSS -->
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css" />

<!-- Demo styles -->
<style>
.swiper {
    width: 100%;
    height: 100%;
}

.swiper-slide {
    text-align: center;
    font-size: 18px;
    background: #fff;
    display: flex;
    justify-content: center;
    align-items: center;
}

.swiper-slide img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.swiper {
    width: 100%;
    height: 300px;
    margin-left: auto;
    margin-right: auto;
}

.swiper-slide {
    background-size: cover;
    background-position: center;
}

.mySwiper2 {
    height: 60%;
    width: 100%;
}

.mySwiper {
    height: 20%;
    box-sizing: border-box;
    padding: 10px 0;
}

.mySwiper .swiper-slide {
    width: 25%;
    height: 100%;
    opacity: 0.4;
}

.mySwiper .swiper-slide-thumb-active {
    opacity: 1;
}

.swiper-slide img {
    display: block;
    width: 100%;
    height: 100%;
    object-fit: cover;
}
</style>


<!-- Swiper -->
<div
    style="--swiper-navigation-color: #fff; --swiper-pagination-color: #fff"
    class="swiper mySwiper2">
    <div class="swiper-wrapper">
        <c:forEach var="photo" items="${photos}">
            <div class="swiper-slide">
                <img src="${pageContext.request.contextPath}/images/${photo}" />
            </div>
        </c:forEach>
    </div>
</div>
<div thumbsSlider="" class="swiper mySwiper">
    <div class="swiper-wrapper">
        <c:forEach var="photo" items="${photos}">
            <div class="swiper-slide">
                <img src="${pageContext.request.contextPath}/images/${photo}" />
            </div>
        </c:forEach>
    </div>
</div>

<!-- Swiper JS -->
<script
    src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<!-- Initialize Swiper -->
<script>
    var swiper = new Swiper(".mySwiper", {
        loop : true,
        spaceBetween : 10,
        slidesPerView : 4,
        freeMode : true,
        watchSlidesProgress : true,
    });
    var swiper2 = new Swiper(".mySwiper2", {
        loop : true,
        spaceBetween : 10,
        navigation : {
            nextEl : ".swiper-button-next",
            prevEl : ".swiper-button-prev",
        },
        thumbs : {
            swiper : swiper,
        },
    });
</script>
