package com.asm.utils;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Component;

@Component
public class PasswordEncoder {

	public static String encodePassword(String password) {
	   
	    String salt = BCrypt.gensalt(12); // Độ mạnh là 12
	    // Mã hóa mật khẩu
	    String hashedPassword = BCrypt.hashpw(password, salt);
	    return hashedPassword;
	}

	public boolean checkPassword(String password, String hashedPassword) {
	    // Kiểm tra có khớp với mật khẩu đã mã hóa 
	    return BCrypt.checkpw(password, hashedPassword);
	}

}
