package com.asm.repository;


import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.asm.model.Product;

public interface FilterRepository extends JpaRepository<Product, Integer>{
	 public static String valueQuery = "select a.id, a.name, a.category_id, c.type, a.photo, a.status, MIN(b.price) as price from Products a \r\n"
			+ "inner join ProductDetails b on a.id = b.product_id\r\n"
			+ "inner join Categories c on a.category_id = c.id\r\n"
			+ "where a.category_id = :category and a.name like CONCAT('%', :keyWord, '%') "
			+ "and price between :minPrice and :maxPrice \r\n"
			+ "and b.color_id in :color \r\n"
			+ "and b.size_id in :size \r\n"
			+ "GROUP BY a.id, a.name, a.category_id, c.type, a.photo, a.status"; 
	
	@Query(value = valueQuery, nativeQuery =  true)
	public Page<Object> findByCategory(@Param("category") Integer category, @Param("keyWord") String keyWord,  @Param("minPrice") double minPrice,  @Param("maxPrice") double maxPrice, @Param("color") List<Integer> color, @Param("size") List<Integer> size, Pageable pageable);
	
}
