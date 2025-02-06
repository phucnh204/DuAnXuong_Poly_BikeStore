package com.asm.service;

import com.asm.model.Account;
import com.asm.repository.AccountRepository;
import com.asm.utils.PasswordEncoder;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Service;

@Service
public class AuthService {
	  @Autowired
	    private AccountRepository accountRepository;
	    
	    public Account findByEmail(String email) {
	        Optional<Account> account = accountRepository.findByEmail(email);
	        return account.orElse(null);
	    }

	    public Account findByUsername(String username) {
	        Optional<Account> account = accountRepository.findByUsername(username);
	        return account.orElse(null);	
	    }

	    public boolean isAdmin(Account account) {
	        return account != null && account.getRole() != null && account.getRole().equalsIgnoreCase("admin");
	    }

	    public boolean isStaff(Account account) {
	        return account != null && account.getRole() != null && account.getRole().equalsIgnoreCase("staff");
	    }
	    
	    public void updateAccount(Account account) {
	        String hashedPassword = PasswordEncoder.encodePassword(account.getPassword());
	        account.setPassword(hashedPassword);
	        accountRepository.save(account);
	    }
	    
	    public boolean Inactive(Account account) {
	        return account != null && account.getStatus() != null && account.getStatus().equalsIgnoreCase("Inactive");
	    }
}
