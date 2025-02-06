package com.asm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.asm.model.Account;

public interface UserRepository extends JpaRepository<Account, Integer>{
	public Account findByUsername(String username);
}
