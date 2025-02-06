package com.asm.model;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "Accounts")
public class Account {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @NotBlank(message = "Không để trống tài khoản!")
    @Size(min = 6, message = "Tài khoản quá ngắn!")
    @Column(nullable = false, unique = true, length = 50)
    private String username;

    @NotBlank(message = "Không để trống mật khẩu!")
    @Size(min = 6, message = "Mật khẩu quá ngắn!")
    @Column(nullable = false, length = 255)
    private String password;
    
    @NotBlank(message = "Không để trống họ tên của bạn!")
    @Size(min = 6, message = "Họ tên của bạn quá ngắn!")
    @Column(length = 100)
    private String fullname;

    @NotNull(message = "Bạn chưa chọn giới tính!")
    @Column
    private Boolean gender;

    @Column(length = 50)
    private String role;

    @Column(length = 50)
    private String status ="Activing";

    @NotBlank(message = "Không để trống email!")
    @Size(min = 6, message = "Email của bạn quá ngắn!")
    @Email(message = "Email không hợp lệ!")
    @Column(nullable = false, unique = true, length = 100)
    private String email;
    
    
    @Transient
//    @NotEmpty(message = "Vui lòng xác nhận lại mật khẩu!")
    String confirmPassword = "";
    
    @OneToMany(mappedBy = "account")
    private List<Address> addresses;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFullname() {
		return fullname;
	}

	public void setFullname(String fullname) {
		this.fullname = fullname;
	}

	public Boolean getGender() {
		return gender;
	}

	public void setGender(Boolean gender) {
		this.gender = gender;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public List<Address> getAddresses() {
		return addresses;
	}

	public void setAddresses(List<Address> addresses) {
		this.addresses = addresses;
	}
    
    
    
}
