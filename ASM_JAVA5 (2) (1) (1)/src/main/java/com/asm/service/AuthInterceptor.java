package com.asm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.HandlerInterceptor;

import com.asm.model.Account;
import com.asm.repository.AccountRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Service
public class AuthInterceptor implements HandlerInterceptor {
	@Autowired
	SessionService sessionService;
	@Autowired
	AuthService authService;
	@Autowired
	AccountRepository accountRepository;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		if(sessionService.getAttribute("user") == null) {
			response.sendRedirect("/404");
			return false;
		}
		int idUser = sessionService.getAttribute("user");
		
		Account user = accountRepository.findAccountById(idUser);

		System.out.println(user);

		String uri = request.getRequestURI();

		if (!authService.isAdmin(user) && uri.contains("admin")) {
			response.sendRedirect("/404");
			return false;
		}
		return true;
	}
}
