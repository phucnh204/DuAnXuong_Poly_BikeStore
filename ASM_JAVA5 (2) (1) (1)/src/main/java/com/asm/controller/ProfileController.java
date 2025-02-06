package com.asm.controller;

import org.hibernate.id.IntegralDataTypeHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.asm.model.Account;
import com.asm.model.Address;
import com.asm.model.Location;

import com.asm.repository.AddressRepository;
import com.asm.repository.ProfileRepository;
import com.asm.service.LocationService;
import com.fasterxml.jackson.databind.ObjectMapper;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;



@Controller
@RequestMapping("/api")
public class ProfileController {
    @Autowired
    HttpServletRequest request;

    @Autowired
    ProfileRepository profileRepository;

    @Autowired
    AddressRepository addressRepository;

    @Autowired
    HttpSession session;

    @Autowired
    private LocationService locationService;

    @PostMapping("/home/profile/addAddress")
    public String addAddress(@RequestParam("fullname") String fullname,
                             @RequestParam("phone") String phone,
                             @RequestParam("address") String addressDetail,
                             @RequestParam("province") String provinceId,
                             @RequestParam("district") String districtId,
                             @RequestParam("ward") String wardCode,
                             @RequestParam("nameWard") String nameWard,
                             @RequestParam("nameDistrict") String nameDistrict,
                             @RequestParam("nameProvince") String nameProvince,
                             HttpSession session,
                             RedirectAttributes redirectAttributes, Model model) {

        String username = (String) session.getAttribute("username");
        Account currentUserAccount = profileRepository.findByUsername(username);

        if (currentUserAccount != null) {

            if (currentUserAccount.getAddresses().size() >= 3) {
                
                model.addAttribute("message", "Bạn đã đạt số lượng địa chỉ tối đa là 4. Không thể thêm địa chỉ mới.");
            } else {
            	try {
					
				} catch (Exception e) {

					e.printStackTrace();
				}
                Address address = new Address();
                
                address.setFull_name(fullname);
                address.setPhone(phone);
                address.setAddress(addressDetail);
                address.setAccount(currentUserAccount);
                address.setProvince_id(provinceId);
                address.setDistrict_id(districtId);
                address.setWard_code(wardCode);
               
                String fullAddress = addressDetail +", "+nameWard+", "+nameDistrict+", "+nameProvince;
                address.setFull_address(fullAddress);

                addressRepository.saveAndFlush(address);
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "Không tìm thấy tài khoản người dùng.");
        }

        return "redirect:/home/profile";
    }

    @PostMapping("home/profile/updateAddress")
    public String updateAddress(@RequestParam("addressId") Integer addressId,
                                @RequestParam("fullname") String fullname,
                                @RequestParam("phone") String phone,
                                @RequestParam("address") String addressDetail,
                                @RequestParam("province") String provinceId,
                                @RequestParam("district") String districtId,
                                @RequestParam("ward") String wardCode,
                                @RequestParam("nameWard") String nameWard,
                                @RequestParam("nameDistrict") String nameDistrict,
                                @RequestParam("nameProvince") String nameProvince
                                ) {

        Address address = addressRepository.findById(addressId).orElse(null);

        if (address != null) {
        	address.setId(addressId);
        	address.setFull_name(fullname);
            address.setPhone(phone);
            String fullAdd = addressDetail + ", " + nameWard + ", " + nameDistrict + ", " + nameProvince;
            address.setDistrict_id(districtId);
            address.setProvince_id(provinceId);
            address.setWard_code(wardCode);
            
            address.setFull_address(fullAdd);
            addressRepository.saveAndFlush(address);
        } else {
            System.out.println("Không tìm thấy địa chỉ với ID: " + addressId);
        }

        return "redirect:/home/profile";
    }
   
    @PostMapping("/home/profile/deleteAddress/{addressId}")
    public String deleteAddress(@PathVariable("addressId") Integer addressId, RedirectAttributes redirectAttributes) {
        try {
            addressRepository.deleteById(addressId);
            redirectAttributes.addFlashAttribute("message", "Địa chỉ đã được xóa thành công.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Lỗi khi xóa địa chỉ. Vui lòng thử lại sau.");
        }
        return "redirect:/home/profile";
    }
	@Value("${ghn.api.token}")
    private String ghnApiToken;

    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();	

    private HttpHeaders createHeaders() {
        HttpHeaders headers = new HttpHeaders();
        headers.set("Token", ghnApiToken);
        return headers;
    }

    @GetMapping("/provinces")
    public ResponseEntity<String> getProvinces() {
        String url = "https://online-gateway.ghn.vn/shiip/public-api/master-data/province";
        HttpHeaders headers = createHeaders();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, new org.springframework.http.HttpEntity<>(headers), String.class);
        return ResponseEntity.ok().body(response.getBody());
    }

    @GetMapping("/districts")
    public ResponseEntity<String> getDistricts(@RequestParam("province_id") String provinceId) {
        String url = "https://online-gateway.ghn.vn/shiip/public-api/master-data/district?province_id=" + provinceId;
        HttpHeaders headers = createHeaders();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, new org.springframework.http.HttpEntity<>(headers), String.class);
        return ResponseEntity.ok().body(response.getBody());
    }

    @GetMapping("/wards")
    public ResponseEntity<String> getWards(@RequestParam("district_id") String districtId) {
        String url = "https://online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=" + districtId;
        HttpHeaders headers = createHeaders();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, new org.springframework.http.HttpEntity<>(headers), String.class);
        return ResponseEntity.ok().body(response.getBody());
    }
    
}
