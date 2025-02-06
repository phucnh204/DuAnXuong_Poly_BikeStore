package com.asm.controller;

import java.util.Optional;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.asm.model.Account;
import com.asm.repository.*;
import com.asm.utils.PasswordEncoder;

import jakarta.mail.MessagingException;
import jakarta.validation.Valid;

@Controller
public class RegisterController {

	
	
	@Autowired
	private AccountRepository accountRepository;

	 @Autowired
	    private PasswordEncoder passwordEncoder;
	 
	@GetMapping("/account/register")
	public String showRegistrationForm(Model model, @ModelAttribute("registerData") Account account) {
		return "account/Register";
	}

	 @PostMapping("/account/register")
	    public String registerUser(@Valid @ModelAttribute("registerData") Account account,
	                               BindingResult result, Model model,
	                               @RequestParam("confirmPassword") String confirmPassword) {
	        if (result.hasErrors()) {
	            return "account/Register";
	        }

	        if (!account.getPassword().equals(confirmPassword)) {
	            result.rejectValue("confirmPassword", "error.registerData", "Mật khẩu và xác nhận mật khẩu không khớp.");
	            return "account/Register";
	        }
	        if (accountRepository.findByEmail(account.getEmail()).isPresent()) {
	            result.rejectValue("email", "error.registerData", "Email đã tồn tại.");
	            return "account/Register";
	        }
	        if (accountRepository.findByUsername(account.getUsername()).isPresent()) {
	            result.rejectValue("username", "error.registerData", "Tài khoản đã tồn tại.");
	            return "account/Register";
	        }
	        account.setStatus("Activing");
	        account.setRole("User");

	        // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
	        @SuppressWarnings("static-access")
			String encodedPassword = passwordEncoder.encodePassword(account.getPassword());
	        account.setPassword(encodedPassword);

	        accountRepository.saveAndFlush(account);

	        model.addAttribute("successMessageRegister", "Đăng ký thành công.");
	        return "account/login";
	    }

	 @GetMapping("account/login")
	 public String showLogin() {
	 	return "account/login";
	 }
	 
	


}
