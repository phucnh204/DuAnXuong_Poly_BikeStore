package com.asm.controller;

import java.util.Random;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.asm.model.Account;
import com.asm.repository.UserRepository;
import com.asm.service.AuthService;
import com.asm.service.SessionService;

import com.asm.utils.PasswordEncoder;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;

@Controller
public class forgotPasswordController implements Runnable{
	
	@Autowired
	PasswordEncoder passwordEncoder;
	@Autowired
	SessionService sessionService;
	@Autowired
	UserRepository userRepository;
	@Autowired
	JavaMailSender sender;
	String message = "";
	boolean check = false;
	String maOTP = "";
	String userName = "";
	String email = "";
	
	@GetMapping("account/password/formForgot")
	public String forgotForm(Model model) {
		model.addAttribute("userName", userName);
		model.addAttribute("email", email);
		model.addAttribute("message", message);
		
		return "/account/ForgotPassword";
	}
	
	@PostMapping("account/password/forgot")
	public String succsessPassword(Model model, @RequestParam("username") String userName,
												@RequestParam("email") String email, 
												@RequestParam("otp") String otp) {
		if (!userName.equals(this.userName) || !otp.equals(maOTP)) {
			message = "Mã OTP không đúng";
			model.addAttribute("message", message);
			return "/account/ForgotPassword";
		}else {
			maOTP = "";
			return "/account/reset-password";
		}

	}
	
	@PostMapping("account/password/otp")
	public String sendOtp(Model model, @RequestParam("username") String userName,
									   @RequestParam("email") String email) {
		Account user = userRepository.findByUsername(userName);
		if (user == null) {
			message = "Không tìm thấy tài khoản";
		}else {
			if (user.getEmail() == null) {
				message = "tài khoản chưa liên kết email";
			}else if(!user.getEmail().equals(email)) {
				message = "email không liên kết với tài khoản";
			}else {
				senMail(userName, email);
			}
		}
		
		return "redirect:/account/password/formForgot";
	}
	@PostMapping("password/reset")
	public String resetPassword(Model model, @RequestParam("password") String password,
	                             @RequestParam("confirm") String confirm) {
	    Account user = userRepository.findByUsername(userName);
	    if (user != null) {
	        if (!password.equals(confirm)) {
	            message = "Mật khẩu xác nhận chưa đúng";
	        } else {
	            // Mã hóa mật khẩu mới
	            String encodedPassword = passwordEncoder.encodePassword(password);
	            user.setPassword(encodedPassword);
	            userRepository.saveAndFlush(user);
	            message = "Đặt lại mật khẩu thành công";
	        }
	    } else {
	        message = "Phiên đổi mật khẩu không có hiệu lực";
	    }

	    model.addAttribute("message", message);
	    return "/account/reset-password";
	}
	public void senMail(String userName ,String toMail) {
		 maOTP = getRandomString(6);
		 sessionService.setAttribute("otp", maOTP);
		 check = true;
		 this.userName = userName;
		 email = toMail;
		 String messageBody
	     = "Xin chào <b>" + "<br/>"
	     + "Đây là email nhận mã OTP từ <b>Bicycle Store</b>."
	     + "<br/><br/>"
	     + "Tên tài khoản: " + userName + "<br/>"
	     + "Mã OTP của bạn là: <b>" + maOTP + ""+ "</b><br/>"
	     + "Hiệu lực của mã OTP là 2 phút!"
	     + "<br/>"
	     + "Vui lòng không cung cấp mã OTP cho bất kỳ ai!"
	     + "<br/>"
	     + "Nếu bạn gặp sự cố, vui lòng liên hệ với bộ phận hỗ trợ thông qua email: "
	     + "<a href='mailto:cuongnqpc05052@fpt.edu.vn'>cuongnqpc05052@fpt.edu.vn</a><br/>"
	     + "chúng tôi đặc biệt không khuyến khích bạn chia sẻ mật khẩu đó với bất kỳ ai.</div>";
		MimeMessage  minMessage = sender.createMimeMessage();
		try {
			MimeMessageHelper helper = new MimeMessageHelper(minMessage, true, "utf-8");
			helper.setFrom("cuongnqpc05052@fpt.edu.vn");
			helper.setTo(toMail);
			helper.setSubject("OTP Quên mật khẩu Bicycle Store");
			helper.setText(messageBody, true);
			sender.send(minMessage);
			message = "Gửi otp thành công";
			Thread thread = new Thread(this);
			thread.start();
		} catch (MessagingException e) {
			message = "Gửi otp thất bại";
		}
	}
	
	  private String getRandomString(int n) {
	        String txt = "1234567890";
	        StringBuilder sb = new StringBuilder();
	        while (n > 0) {
	            Random rd = new Random();
	            sb.append(txt.charAt(rd.nextInt(txt.length())));
	            n--;
	        }
	        return sb.toString();
	    }
	  @Override
	    public void run() {
	        int s = 120;
	        while (true) {
	            if (check == false) {
	            	 maOTP = "";
	                break;
	            }
	            try {
	                Thread.sleep(1000);
	                s--;
	                if (s == 0) {
	                    maOTP = "";
	                   System.out.println("otp hết hiệu lực otp hiện tại là: "+maOTP);
	                  break;
	                    
	                }
	            } catch (InterruptedException ex) {
	            }
	        }
	    }

}
