package com.asm.controller;

import java.util.regex.Pattern;

import com.asm.model.Account;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import com.asm.service.AuthService;
import com.asm.utils.PasswordEncoder;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class loginController {

    @Autowired
    private AuthService authService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private HttpServletRequest request;
    	
    @Autowired
    private HttpSession session;

    @PostMapping("/login")
    public String login(@RequestParam("emailOrUsername") String emailOrUsername,
                        @RequestParam("password") String password, Model model) {
        model.addAttribute("emailOrUsername", emailOrUsername);
      
        if (emailOrUsername == null || emailOrUsername.isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập email hoặc tên đăng nhập.");
            return "account/login";
        }

        if (password == null || password.isEmpty()) {
            model.addAttribute("error", "Vui lòng nhập mật khẩu.");
            return "account/login";
        }

        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        Pattern pattern = Pattern.compile(emailRegex);
        Account account = null;

        if (pattern.matcher(emailOrUsername).matches()) {
            account = authService.findByEmail(emailOrUsername);
            if (account == null) {
                model.addAttribute("error", "Email không tồn tại.");
                return "account/login";
            }
        } else {
            account = authService.findByUsername(emailOrUsername);
            if (account == null) {
                model.addAttribute("error", "Tên đăng nhập không tồn tại.");
                return "account/login";
            }
        }

        if (account != null && passwordEncoder.checkPassword(password, account.getPassword())) {
            if (authService.Inactive(account)) {
                model.addAttribute("error", "Tài khoản của bạn đã bị khóa.");
                return "account/login";
            }

            session.setAttribute("username", account.getUsername()); // Lưu tên đăng nhập vào session
            session.setAttribute("isLoggedIn", true);
            session.setAttribute("user", account.getId());

            if (authService.isAdmin(account)) {
                model.addAttribute("success", "Đăng nhập thành công!");
                session.setAttribute("role", "admin");
                return "redirect:/admin/report";
            } else if (authService.isStaff(account)) {
                model.addAttribute("success", "Đăng nhập thành công!");
                session.setAttribute("role", "staff"); 
                return "redirect:/admin/report";
            } else {
                model.addAttribute("success", "Đăng nhập thành công!");
                request.setAttribute("view", "Home.jsp");
                return "redirect:/home";
            }
        } else {
            model.addAttribute("error", "Sai email/tên đăng nhập hoặc mật khẩu.");
            return "account/login";
        }
    }

    @GetMapping("/logout")
    public String logout() {
        session.invalidate();
        session.setAttribute("user", null);
        return "redirect:/home";
    }
}
