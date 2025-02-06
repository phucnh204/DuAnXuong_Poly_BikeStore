package com.asm.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.asm.model.Address;
import com.asm.model.Account;


public interface AddressRepository extends JpaRepository<Address, Integer> {
	
public Address findByAccount(Account account);
	
	@Query(value = "select * from Addresses where account_id = :id", nativeQuery = true)
	public List<Address>  findBListyAccount(@Param("id") Integer account);
}
