package com.asm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.asm.model.Payments;

public interface PaymentRepository extends JpaRepository<Payments, Integer>{
	
}
