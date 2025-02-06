package com.asm.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import org.apache.commons.codec.digest.HmacUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.asm.config.VNPayConfig;
import com.asm.model.Account;
import com.asm.model.Address;
import com.asm.model.CartDetail;
import com.asm.model.OrderDetail;
import com.asm.model.Orders;
import com.asm.model.Payments;
import com.asm.model.ProductDetail;
import com.asm.model.Status;
import com.asm.repository.AccountRepository;
import com.asm.repository.AddressRepository;
import com.asm.repository.CartDetailRepository;
import com.asm.repository.CartRepository;
import com.asm.repository.OrderDetailRepository;
import com.asm.repository.OrderRepository;
import com.asm.repository.PaymentRepository;
import com.asm.repository.ProductDetailRepository;
import com.asm.repository.ProductRepository;
import com.asm.repository.StatusOderRepository;
import com.asm.service.SessionService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class VNPayController {
	@Autowired
    private VNPayConfig vnpayConfig;
    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private ProductRepository productRepository;
    @Autowired
    private CartDetailRepository cartDetailRepository;
    @Autowired
    private SessionService sessionService;
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private OrderDetailRepository orderDetailRepository;
    
    
    
    @Autowired
	CartRepository cartRepository;
	@Autowired
	ProductDetailRepository productDetailRepository;
	@Autowired
	HttpSession httpSession;
	@Autowired
	AddressRepository addressRepository;
	@Autowired
	StatusOderRepository statusOderRepository;
	@Autowired
	OrderRepository oderRepository;
	@Autowired
	OrderDetailRepository detailRepository;
	@Autowired
	PaymentRepository paymentRepository;
	
	Integer idAccount;
	double totalPice = 0;
	String[] cartDetailIds = null;
	String messageCart = "";
	String messageOrder = "";
	Address address = new Address();
	static String messageAddress = "";
    
    
    

//    private String vnp_HashSecret = "UE5AQGNZSQFJD9VOXA4HAIFMYH4FZ1J0";
//    private String vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";
//
//    @PostMapping("cart/order")
//    public String checkout(
//        @RequestParam("totalPayment1") String amount,
//        Model model) throws UnsupportedEncodingException {
//        
//    	
//       
//        String vnp_Version = "2.1.0";
//        String vnp_Command = "pay";
//        String orderType = "billpayment";
//        String vnp_TxnRef = String.valueOf(System.currentTimeMillis());
//        String vnp_IpAddr = "127.0.0.1";
//        String vnp_TmnCode = "QIPASG5N";
//
//        double totalAmount = Double.parseDouble(amount) ;
//
//        Map<String, String> vnp_Params = new HashMap<>();
//        vnp_Params.put("vnp_Version", vnp_Version);
//        vnp_Params.put("vnp_Command", vnp_Command);
//        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
//        vnp_Params.put("vnp_Amount", String.valueOf((int) (totalAmount * 100)));
//        vnp_Params.put("vnp_CurrCode", "VND");
//        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
//        vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang: " + vnp_TxnRef);
//        vnp_Params.put("vnp_OrderType", orderType);
//        vnp_Params.put("vnp_Locale", "vn");
//        vnp_Params.put("vnp_ReturnUrl", "http://localhost:8080/cart/view1");
//        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);
//
//        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
//        String vnp_CreateDate = formatter.format(cld.getTime());
//        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
//        cld.add(Calendar.MINUTE, 15);
//        String vnp_ExpireDate = formatter.format(cld.getTime());
//        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);
//
//        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
//        Collections.sort(fieldNames);
//        StringBuilder hashData = new StringBuilder();
//        StringBuilder query = new StringBuilder();
//        Iterator<String> itr = fieldNames.iterator();
//        while (itr.hasNext()) {
//            String fieldName = itr.next();
//            String fieldValue = vnp_Params.get(fieldName);
//            if (fieldValue != null && fieldValue.length() > 0) {
//                hashData.append(fieldName);
//                hashData.append('=');
//                hashData.append(URLEncoder.encode(fieldValue, "UTF-8"));
//                query.append(URLEncoder.encode(fieldName, "UTF-8"));
//                query.append('=');
//                query.append(URLEncoder.encode(fieldValue, "UTF-8"));	
//                if (itr.hasNext()) {
//                    query.append('&');
//                    hashData.append('&');
//                }
//            }
//        }
//        String queryUrl = query.toString();
//        String vnp_SecureHash = HmacUtils.hmacSha512Hex(vnp_HashSecret, hashData.toString());
//        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
//        String paymentUrl = vnpayConfig.getVnp_Url() + "?" + queryUrl;
//
//        return "redirect:" + paymentUrl;
//    }
//   // Annotation này đảm bảo rằng tất cả các thao tác trong phương thức 
//    @Transactional
//    @RequestMapping("cart/view1")
//    public String paymentResult( HttpServletRequest request,  @RequestParam(name = "note", defaultValue = "không có") String note, Model model) throws UnsupportedEncodingException {
//        Map<String, String> vnp_Params = new HashMap<>();
//        for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements(); ) {
//            String param = params.nextElement();
//            String value = request.getParameter(param);
//            if ((value != null) && (value.length() > 0)) {
//                vnp_Params.put(param, value);
//            }
//        }
//
//        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
//
//        if (vnp_Params.containsKey("vnp_SecureHashType")) {
//            vnp_Params.remove("vnp_SecureHashType");
//        }
//        if (vnp_Params.containsKey("vnp_SecureHash")) {
//            vnp_Params.remove("vnp_SecureHash");
//        }
//
//        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
//        Collections.sort(fieldNames);
//        StringBuilder hashData = new StringBuilder();
//        for (String fieldName : fieldNames) {
//            String fieldValue = vnp_Params.get(fieldName);
//            if ((fieldValue != null) && (fieldValue.length() > 0)) {
//                hashData.append(fieldName);
//                hashData.append('=');
//                hashData.append(URLEncoder.encode(fieldValue, "UTF-8"));
//                hashData.append('&');
//            }
//        }
//        if (hashData.length() > 0) {
//            hashData.deleteCharAt(hashData.length() - 1);
//        }
//
//        String secureHash = HmacUtils.hmacSha512Hex(vnp_HashSecret, hashData.toString());
//
//        if (secureHash.equals(vnp_SecureHash)) {
//            String responseCode = request.getParameter("vnp_ResponseCode");
//            if ("00".equals(responseCode)) {
//            	
//            	int i = 0;
//        		idAccount = 2;
//        		System.out.println(idAccount);
//        		Account account = accountRepository.findAccountById(idAccount);
//        		List<ProductDetail> productDetails = (List<ProductDetail>) httpSession.getAttribute("productsDetails2");
//        		List<CartDetail> cartDetails2 = (List<CartDetail>) httpSession.getAttribute("cartDetails2");
//        		Orders orders = new Orders();
//        		orders.setOrder_date(new Date());
//        		orders.setAccount(account);
//        		orders.setTotal(100000);
//        		orders.setNote(note);
//
//        		Status status = statusOderRepository.findById(1).get();
//        		orders.setStatus(status);
//        		List<Address> addresses = (List<Address>) httpSession.getAttribute("listAddress");
//        		
//        	    CartController cartController = new CartController();
//        	    
//              
//        		orders.setAddress(cartController.address);
//        		Payments payments = paymentRepository.findById(1).get();
//        		orders.setPayment(payments);
//        		oderRepository.saveAndFlush(orders);
//        		for (ProductDetail productDetail : productDetails) {
//        			OrderDetail orderDetail = new OrderDetail();
//        			orderDetail.setOrder(orders);
//        			orderDetail.setPrice(productDetail.getPrice());
//        			orderDetail.setProductDetail(productDetail);
//        			orderDetail.setQuantity(cartDetails2.get(i).getQuantity());
//        			productDetail.setQuantity(productDetail.getQuantity() - cartDetails2.get(i).getQuantity());
//        			productDetailRepository.saveAndFlush(productDetail);
//        			detailRepository.saveAndFlush(orderDetail);
//        			cartRepository.delete(cartDetails2.get(i));
//        			i++;
//        		}
//        		
//        		messageOrder = "Đơn hàng của bạn đã được đặt";
//        		
//        		httpSession.removeAttribute("cartDetails2");
//        		httpSession.removeAttribute("productsDetails2");
//        		httpSession.removeAttribute("quantityProduct2");
//        		httpSession.removeAttribute("totalPice");
//        		cartDetailIds = null;
//        		return "redirect:/cart/view";
//              
//
//         
//
//            } else {
//                model.addAttribute("message", "Giao dịch không thành công. Mã lỗi: " + responseCode);
//
//            
//            }
//            
//        } else {
//            model.addAttribute("message", "Chữ ký không hợp lệ!");
//        }
//
//        return "redirect:/cart/view";
//    }
    


}
