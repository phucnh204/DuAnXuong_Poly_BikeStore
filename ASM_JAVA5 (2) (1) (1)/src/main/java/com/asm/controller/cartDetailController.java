package com.asm.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.asm.model.Account;
import com.asm.model.CartDetail;
import com.asm.model.ProductDetail;
import com.asm.repository.AccountRepository;
import com.asm.repository.CartDetailRepository;
import com.asm.repository.CartRepository;
import com.asm.repository.ColorRepository;
import com.asm.repository.ProductDetailRepository;
import com.asm.repository.ProductRepository;
import com.asm.repository.SizeRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class cartDetailController {
	@Autowired
	HttpServletRequest request;
	@Autowired
	ProductRepository productRepository;
	@Autowired
	ColorRepository colorRepository;
	@Autowired
	SizeRepository sizeRepository;
	@Autowired
	ProductDetailRepository productDetailRepository;
	@Autowired
	CartDetailRepository cartDetailRepository;
	@Autowired
	AccountRepository accountRepository;
	@Autowired
	CartRepository cartRepository;
	@Autowired
	HttpSession session;
	static String messageProduc = "";
	
	
	 @PostMapping("/home/cart/add")
	    public String addToCart(
	            @RequestParam("productId") Integer productId,
	            @RequestParam("colorId") Integer colorId,
	            @RequestParam("sizeId") Integer sizeId,
	            @RequestParam("quantity") Integer quantity) {
		 	messageProduc = "";
	        Integer userIdStr = (Integer) session.getAttribute("user");
	        Account account = accountRepository.findById(userIdStr).orElse(null);
	        if (account == null) {
	            return "redirect:/login"; // Nếu không tìm thấy account, chuyển hướng đến trang đăng nhập
	        }

	        ProductDetail productDetail = productDetailRepository.findPriceBTSQL(productId, colorId, sizeId).get(0);

	        Optional<CartDetail> existingCartDetailOpt = cartDetailRepository.findByAccountAndProductDetail(account, productDetail);
	        if (existingCartDetailOpt.isPresent()) {
	            CartDetail existingCartDetail = existingCartDetailOpt.get(); 
	            if ((existingCartDetail.getQuantity() + quantity) > productDetail.getQuantity() && productDetail.getQuantity() - (existingCartDetail.getQuantity() + quantity) < 0) {
	            	if (existingCartDetail.getQuantity() == productDetail.getQuantity()) {
	            		messageProduc = "Bạn đã có "+ existingCartDetail.getQuantity() +" sản phẩm trong giỏ hàng đây là toàn bộ số lượng sản phẩm hiện có";
		            	return "redirect:/product/detail/" + productId + "/" + colorId + "/" + sizeId;
					}else {
						messageProduc = "Bạn chỉ có thể mua  " + ( productDetail.getQuantity() - existingCartDetail.getQuantity()) + " sản phẩm  vì bạn đã có " + (existingCartDetail.getQuantity()) + " sản phẩm  trong giỏ hàng" + ", số sản phẩm sẳn có "+ (productDetail.getQuantity() - existingCartDetail.getQuantity());
		            	return "redirect:/product/detail/" + productId + "/" + colorId + "/" + sizeId;
					}
	            }else {
					System.out.println("soos luong lan dau: "+existingCartDetail.getQuantity() + quantity);
					System.out.println("so luong san pham: "+ productDetail.getQuantity());
					existingCartDetail.setQuantity(existingCartDetail.getQuantity() + quantity);
		            cartDetailRepository.saveAndFlush(existingCartDetail);
				}

	        } else {
	        	if (( quantity) > productDetail.getQuantity()) {
	            	messageProduc = "Hiện chỉ có "+ productDetail.getQuantity() + " sản phẩm sẳn có";
	            	return "redirect:/product/detail/" + productId + "/" + colorId + "/" + sizeId;
				}
	            CartDetail newCartDetail = new CartDetail();
	            List<CartDetail> sizeCart = new ArrayList<>();
	            
	            newCartDetail.setAccount(account);
	            newCartDetail.setProductDetail(productDetail);
	            newCartDetail.setQuantity(quantity);
	            cartDetailRepository.saveAndFlush(newCartDetail);
	            sizeCart = cartRepository.findProduct(account.getId());
	            session.setAttribute("quantityProduct", sizeCart.size());
	        }
	        
	        return "redirect:/product/detail/" + productId + "/" + colorId + "/" + sizeId;
	    }
	 
	 @PostMapping("/pay/now")
	    public String payNow(
	            @RequestParam("productId") Integer productId,
	            @RequestParam("colorId") Integer colorId,
	            @RequestParam("sizeId") Integer sizeId,
	            @RequestParam("quantity") Integer quantity) {
		 	messageProduc = "";
	        Integer userIdStr = (Integer) session.getAttribute("user");
	        Account account = accountRepository.findById(userIdStr).orElse(null);
	        if (account == null) {
	            return "redirect:/login"; // Nếu không tìm thấy account, chuyển hướng đến trang đăng nhập
	        }

	        ProductDetail productDetail = productDetailRepository.findPriceBTSQL(productId, colorId, sizeId).get(0);

	        Optional<CartDetail> existingCartDetailOpt = cartDetailRepository.findByAccountAndProductDetail(account, productDetail);
	        if (existingCartDetailOpt.isPresent()) {
	            CartDetail existingCartDetail = existingCartDetailOpt.get();
	            if ((existingCartDetail.getQuantity() + quantity) > productDetail.getQuantity() && productDetail.getQuantity() - (existingCartDetail.getQuantity() + quantity) < 0) {
	            	if (existingCartDetail.getQuantity() == productDetail.getQuantity()) {
	            		messageProduc = "Bạn đã có "+ existingCartDetail.getQuantity() +" sản phẩm trong giỏ hàng đây là toàn bộ số lượng sản phẩm hiện có";
		            	return "redirect:/product/detail/" + productId + "/" + colorId + "/" + sizeId;
					}else {
						messageProduc = "Bạn chỉ có thể mua  " + ( productDetail.getQuantity() - existingCartDetail.getQuantity()) + " sản phẩm  vì bạn đã có " + (existingCartDetail.getQuantity()) + " sản phẩm  trong giỏ hàng" + ", số sản phẩm sẳn có "+ (productDetail.getQuantity() - existingCartDetail.getQuantity());
		            	return "redirect:/product/detail/" + productId + "/" + colorId + "/" + sizeId;
					}
	            }else {
					System.out.println("soos luong lan dau: "+existingCartDetail.getQuantity() + quantity);
					System.out.println("so luong san pham: "+ productDetail.getQuantity());
					existingCartDetail.setQuantity(existingCartDetail.getQuantity() + quantity);
		            cartDetailRepository.saveAndFlush(existingCartDetail);
				}
	        } else {
	        	if (( quantity) > productDetail.getQuantity()) {
	            	messageProduc = "Hiện chỉ có "+ productDetail.getQuantity() + " sản phẩm sẳn có";
	            	return "redirect:/product/detail/" + productId + "/" + colorId + "/" + sizeId;
				}
	            CartDetail newCartDetail = new CartDetail();
	            List<CartDetail> sizeCart = new ArrayList<>();
	           
	            newCartDetail.setAccount(account);
	            newCartDetail.setProductDetail(productDetail);
	            newCartDetail.setQuantity(quantity);
	            cartDetailRepository.saveAndFlush(newCartDetail);
	            sizeCart = cartRepository.findProduct(account.getId());
	            session.setAttribute("quantityProduct", sizeCart.size());
	            session.setAttribute("idPayNow", productDetail.getId());
	        }

	        return "redirect:/cart/view";
	    }
}
