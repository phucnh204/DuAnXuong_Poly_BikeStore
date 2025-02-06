package com.asm.controller;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asm.service.changePasswordService;
import com.asm.model.PasswordForm;

import jakarta.servlet.http.HttpSession;

@Controller
public class changePasswordController {

    @Autowired
    private changePasswordService changePasswordService;

    @Autowired
    private HttpSession session;

    @GetMapping("/changePassword")
    public String changePassword(Model model) {
        PasswordForm passwordForm = new PasswordForm();

//         Lấy tài khoản đăng nhập hiện tại từ session
        String currentUsername = (String) session.getAttribute("username");
        if (currentUsername != null) {
            passwordForm.setUsername(currentUsername);
        }

        model.addAttribute("passwordForm", passwordForm);
        return "account/ChangePassword";
    }

    @PostMapping("/changePassword")
    public String processChangePasswordForm(@Valid @ModelAttribute("passwordForm") PasswordForm form,
                                            BindingResult bindingResult,
                                            Model model,
                                            RedirectAttributes redirectAttributes) {

        if (bindingResult.hasErrors()) {
            return "account/ChangePassword";
        }

        String username = form.getUsername();
        String currentPassword = form.getPassword();
        String newPassword = form.getNewPassword();

        // Logic thay đổi mật khẩu ở đây
        boolean isPasswordChanged = changePasswordService.changePassword(username, currentPassword, newPassword);

        if (isPasswordChanged) {
            model.addAttribute("successMessagePasswordChanged", "Đổi mật khẩu thành công.");
            return "account/ChangePassword";
        } else {
            model.addAttribute("message", "Mật khẩu hiện tại không chính xác.");
            return "account/ChangePassword";
        }
    }
}
