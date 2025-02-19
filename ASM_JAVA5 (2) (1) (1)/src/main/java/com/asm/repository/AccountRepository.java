package com.asm.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.asm.model.Account;

public interface AccountRepository extends JpaRepository<Account, Integer>{
	@Query(value = "SELECT * FROM Accounts WHERE id = :id", nativeQuery = true)
	public Account  findAccountById(@Param("id") Integer id);
	
	Optional<Account> findByEmail(String email);
	
    Optional<Account> findByUsername(String username);
    
    @Query("SELECT a FROM Account a WHERE LOWER(a.username) LIKE %:keyword% OR LOWER(a.email) LIKE %:keyword%")
    List<Account> findByUsernameOrEmail(@Param("keyword") String keyword);
    
    @Query("SELECT a FROM Account a WHERE LOWER(a.username) LIKE %:keyword% OR LOWER(a.email) LIKE %:keyword%")
    Page<Account> findByUsernameOrEmail(@Param("keyword") String keyword, Pageable pageable);
    
}
