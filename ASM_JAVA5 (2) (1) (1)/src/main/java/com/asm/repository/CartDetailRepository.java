package com.asm.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.asm.model.Account;
import com.asm.model.CartDetail;
import com.asm.model.ProductDetail;

public interface CartDetailRepository extends JpaRepository<CartDetail, Integer>{
	Optional<CartDetail> findByAccountAndProductDetail(Account account, ProductDetail productDetail);
}
