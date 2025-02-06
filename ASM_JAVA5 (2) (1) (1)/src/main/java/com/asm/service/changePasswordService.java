package com.asm.service;

import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.asm.model.Account;
import com.asm.repository.AccountRepository;
import com.asm.utils.PasswordEncoder;

@Service
public class changePasswordService {

    @Autowired
    AccountRepository accountRepository;

    @Autowired
    SessionService sessionService;

    @Autowired
    PasswordEncoder passwordEncoder;

    public boolean changePassword(String username, String password, String newPassword) {
        Optional<Account> currentAccountOpt = accountRepository.findByUsername(username);

        if (currentAccountOpt.isPresent()) {
            Account currentAccount = currentAccountOpt.get();
            if (passwordEncoder.checkPassword(password, currentAccount.getPassword())) {
                // Mã hóa mật khẩu mới trước khi lưu vào cơ sở dữ liệu
                String encodedNewPassword = passwordEncoder.encodePassword(newPassword);
                currentAccount.setPassword(encodedNewPassword);
                accountRepository.saveAndFlush(currentAccount);
                return true;
            }
        }
        return false;
    }

    public Account getCurrentAccount() {
        return sessionService.getAttribute("user");
    }
    
    public Account getAccountByUsername(String username) {
        return accountRepository.findByUsername(username).orElse(null);
    }
}


