package com.asm.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.asm.model.Account;
import java.util.List;


public interface ProfileRepository extends JpaRepository<Account, Integer>{
	 Account findByUsername(String username);
}
