package com.asm.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.ScrollPosition.Direction;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asm.model.Account;
import com.asm.repository.AccountRepository;
import com.asm.utils.PasswordEncoder;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class UserController {
	@Autowired
	AccountRepository accountRepository;

	@Autowired
	PasswordEncoder passwordEncoder;

	@Autowired
	HttpServletRequest request;

	@GetMapping("/admin/user")
	public String searchUser(Model model, @RequestParam(name = "keyword", defaultValue = "") String keyword,
			@RequestParam(name = "page", defaultValue = "0") Optional<Integer> page,
			@RequestParam(name = "size", defaultValue = "6") Optional<Integer> size) {

		Pageable pageable = PageRequest.of(page.orElse(0), size.orElse(6), Sort.by(Sort.Direction.DESC, "id"));
		Page<Account> usersPage;

		if (keyword.isEmpty()) {
			usersPage = accountRepository.findAll(pageable);
		} else {
			usersPage = accountRepository.findByUsernameOrEmail(keyword, pageable);
		}

		model.addAttribute("usersPage", usersPage);
		model.addAttribute("currentPage", page.orElse(0));
		model.addAttribute("totalPages", usersPage.getTotalPages());
		model.addAttribute("keyword", keyword);
		request.setAttribute("view", "user/userTable.jsp");
		return "admin/font-end/index";
	}

	@GetMapping("/add")
	public String addUser(Model model) {
		model.addAttribute("account", new Account());
		request.setAttribute("view", "user/userAdd.jsp");
		return "admin/font-end/index";

	}
	@PostMapping("/create")
	public String createUser(@Valid @ModelAttribute("account") Account account, BindingResult result, Model model) {
		 String fullnamePattern = "^[a-zA-Z\\sÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯăÂÊÔưăâêôÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯăÂÊÔưăâêô]+$";

	    if (result.hasErrors()) {
	        request.setAttribute("view", "user/userAdd.jsp");
	        return "admin/font-end/index";
	    }

	    if (!account.getFullname().matches(fullnamePattern)) {
	        model.addAttribute("error", "Họ và tên chỉ được dùng chữ cái không chứa kí tự hoặc chữ số");
	        model.addAttribute("view", "user/userAdd.jsp");
	        return "admin/font-end/index";
	    }

	    Optional<Account> existingUsername = accountRepository.findByUsername(account.getUsername());
	    if (existingUsername.isPresent()) {
	        model.addAttribute("error", "Tên tài khoản đã tồn tại");
	        return "admin/font-end/user/userAdd";
	    }

	    Optional<Account> existingEmail = accountRepository.findByEmail(account.getEmail());
	    if (existingEmail.isPresent()) {
	        model.addAttribute("error", "Email đã được sử dụng");
	        return "admin/font-end/user/userAdd";
	    }

	    String hashedPassword = passwordEncoder.encodePassword(account.getPassword());
	    account.setPassword(hashedPassword);
	    accountRepository.saveAndFlush(account);
	    return "redirect:/admin/user";
	}


	@GetMapping("/admin/user/updateStatus")
	public String updateStatus(@RequestParam("id") int id, @RequestParam("status") String status,
			RedirectAttributes redirectAttributes) {
		Optional<Account> optionalAccount = accountRepository.findById(id);
		if (optionalAccount.isPresent()) {
			Account account = optionalAccount.get();
			account.setStatus(status);
			accountRepository.saveAndFlush(account);
			redirectAttributes.addFlashAttribute("message", "Cập nhật trạng thái thành công");
		} else {
			redirectAttributes.addFlashAttribute("message", "Tài khoản không tồn tại");
		}
		return "redirect:/admin/user";
	}

}
