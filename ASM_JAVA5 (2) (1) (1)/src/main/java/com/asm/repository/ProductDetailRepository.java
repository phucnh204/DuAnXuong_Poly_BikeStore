package com.asm.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.asm.model.ProductDetail;

public interface ProductDetailRepository extends JpaRepository<ProductDetail, Integer>{

	 @Query(value = "SELECT * FROM ProductDetails WHERE product_id = :productId AND color_id = :colorId AND size_id = :sizeId", nativeQuery = true)
	    List<ProductDetail> findPriceBTSQL(@Param("productId") Integer productId, @Param("colorId") Integer colorId, @Param("sizeId") Integer sizeId);
	
	 @Query(value = "SELECT * FROM ProductDetails WHERE product_id = :productId", nativeQuery = true)
	    Page<ProductDetail> findAllDetailByid(Pageable pageable,@Param("productId") Integer productId);
	 
	 @Query(value = "SELECT * FROM ProductDetails WHERE product_id = :productId and color_id = :colorId and size_id = :sizeId and id != :productDetailId", nativeQuery = true)
	    List<ProductDetail> findDetailByColorAndSize(@Param("productId") Integer productId,@Param("colorId") Integer colorId,@Param("sizeId") Integer sizeId,@Param("productDetailId") Integer productDetailId);
	 
	 @Query(value = "SELECT * FROM ProductDetails WHERE product_id = :productId and color_id = :colorId and size_id = :sizeId ", nativeQuery = true)
	    List<ProductDetail> findDetailByColorAndSize(@Param("productId") Integer productId,@Param("colorId") Integer colorId,@Param("sizeId") Integer sizeId);
	 	
	 @Query(value = "SELECT TOP 1  MAX(ProductDetails.price) FROM ProductDetails", nativeQuery = true)
		public Object findPriceMax();
}
