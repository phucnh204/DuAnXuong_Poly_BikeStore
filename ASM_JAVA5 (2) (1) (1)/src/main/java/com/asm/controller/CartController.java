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
import java.util.Optional;
import java.util.TimeZone;

import org.apache.commons.codec.digest.HmacUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
import com.asm.model.Product;
import com.asm.model.ProductDetail;
import com.asm.model.Status;
import com.asm.repository.AccountRepository;
import com.asm.repository.AddressRepository;
import com.asm.repository.CartRepository;
import com.asm.repository.OrderDetailRepository;
import com.asm.repository.OrderRepository;
import com.asm.repository.PaymentRepository;
import com.asm.repository.ProductDetailRepository;
import com.asm.repository.ProductRepository;
import com.asm.repository.StatusOderRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class CartController {
	@Autowired
	private VNPayConfig vnpayConfig;
	@Autowired
	CartRepository cartRepository;
	@Autowired
	ProductRepository productRepository;
	@Autowired
	ProductDetailRepository productDetailRepository;
	@Autowired
	HttpSession httpSession;
	@Autowired
	AddressRepository addressRepository;
	@Autowired
	AccountRepository accountRepository;
	@Autowired
	StatusOderRepository statusOderRepository;
	@Autowired
	OrderRepository oderRepository;
	@Autowired
	OrderDetailRepository detailRepository;
	@Autowired
	PaymentRepository paymentRepository;
	
	Integer idAccount = 0;
	double totalPice = 0;
	String[] cartDetailIds = null;
	String messageCart = "";
	String messageOrder = "";
	Address address = new Address();
	static String messageAddress = "";
	Double totalAmount;
	Double shipfee;

	@RequestMapping("cart/view")
	public String cartView(Model model, @RequestParam(name = "ids", defaultValue = "") String idStrings) {
		int i = 0;
		totalPice = 0;
		idAccount = (Integer) httpSession.getAttribute("user");
		cartDetailIds = (String[]) httpSession.getAttribute("cartDetailIds");
		// cartDetailController cartDetailController = new cartDetailController();

		List<CartDetail> cartDetails = new ArrayList<>();
		List<CartDetail> cartDetails2 = new ArrayList<>();
		List<ProductDetail> productsDetails = new ArrayList<>();
		List<ProductDetail> productsDetails2 = new ArrayList<>();
		List<String> productsName = new ArrayList<>();
		cartDetails = cartRepository.findProduct(idAccount);
		if (cartDetails.size() > 0) {
			for (CartDetail cartDetail : cartDetails) {
				productsDetails.add(cartDetail.getProductDetail());
			}

			for (ProductDetail detail : productsDetails) {
				productsName.add(detail.getProduct().getName());
			}

			if (cartDetailIds != null && !cartDetailIds.equals("")) {

				i = 0;
				for (String id : cartDetailIds) {
					if (!id.isEmpty()) {
						System.out.println("id: " + id);
						ProductDetail productDetail = productDetailRepository.findById(Integer.valueOf(id)).get();
						CartDetail cartDetail = cartRepository.findByAccountAndProductDetail(idAccount,
								Integer.valueOf(id));
						cartDetails2.add(cartDetail);
						productsDetails2.add(productDetail);
					}

				}

				for (ProductDetail detail : productsDetails2) {
					productsName.add(detail.getProduct().getName());
				}

				for (ProductDetail detail : productsDetails2) {
					try {
						totalPice = totalPice + (detail.getPrice() * cartDetails2.get(i).getQuantity());
						i++;
					} catch (Exception e) {
						// TODO: handle exception
					}

				}
			} else {
				for (ProductDetail detail : productsDetails) {
					productsName.add(detail.getProduct().getName());
				}
			}

		}
		model.addAttribute("messageOder", messageOrder);
		messageOrder = "";
		model.addAttribute("messageCart", messageCart);
		messageOrder = "";
		messageCart = "";
		httpSession.setAttribute("cartDetails", cartDetails);
		httpSession.setAttribute("cartDetails2", cartDetails2);
		httpSession.setAttribute("productsDetails", productsDetails);
		httpSession.setAttribute("productsDetails2", productsDetails2);
		httpSession.setAttribute("quantityProduct", cartDetails.size());
		httpSession.setAttribute("quantityProduct2", cartDetails2.size());
		httpSession.setAttribute("productsName", productsName);
		httpSession.setAttribute("totalPice", totalPice);
		model.addAttribute("view", "Cart.jsp");
		return "user/font-end/index";
	}

	@PostMapping("cart/update")
	public String cartUpdate(@RequestParam("quantity") int quantity, @RequestParam("idCartDetail") Integer id,
			@RequestParam("idProduct") Integer idProduct) {

		CartDetail cartDetail = cartRepository.findById(id).get();
		ProductDetail productDetail = productDetailRepository.findById(idProduct).get();
		if (quantity > productDetail.getQuantity()) {
			System.out.println("sl cart" + quantity);
			System.out.println("sl product" + cartDetail.getQuantity());
			messageCart = "Hiện tại chỉ có " + productDetail.getQuantity() + " sản phẩm có sẳn";
			return "redirect:/cart/view";
		}

		cartDetail.setQuantity(quantity);

		cartRepository.saveAndFlush(cartDetail);

		return "redirect:/cart/view";
	}

	@GetMapping("cart/remove/{id}")
	public String remove(@PathVariable("id") Integer id) {

		CartDetail cartDetail = cartRepository.findById(id).get();

		cartRepository.delete(cartDetail);
		return "redirect:/cart/view";
	}

	@RequestMapping("cart/pay")
	public String cartPay(@RequestParam("ids") String idStrings, Model model) {
		cartDetailIds = null;
		cartDetailIds = idStrings.split(",");

		List<CartDetail> cartDetails = new ArrayList<>();

		List<ProductDetail> productsDetails = new ArrayList<>();
		int i = 0;
		for (String id : cartDetailIds) {
			if (!id.isEmpty()) {
				System.out.println("id: " + id);
				ProductDetail productDetail = productDetailRepository.findById(Integer.valueOf(id)).get();
				CartDetail cartDetail = cartRepository.findByAccountAndProductDetail(idAccount, Integer.valueOf(id));
				cartDetails.add(cartDetail);
				productsDetails.add(productDetail);
			}

		}

		totalPice = 0;
		for (ProductDetail detail : productsDetails) {
			totalPice = totalPice + (detail.getPrice() * cartDetails.get(i).getQuantity());
			i++;
		}
		System.out.println("lenght: " + cartDetailIds.length);
		for (String productDetail : cartDetailIds) {
			System.out.println("gia trị : " + productDetail);
		}
		httpSession.setAttribute("cartDetailIds", cartDetailIds);
		return "forward:/cart/view";
	}

	@GetMapping("cart/checkout")
	public String checkoutViews(@RequestParam(name = "idAddress", defaultValue = "0") Integer idAddress,
			@RequestParam(name = "id", defaultValue = "") Integer id, Model model) {

		messageAddress = "";

		if (cartDetailIds == null) {
			messageCart = "Vui lòng chọn sản phẩm để đặt hàng";
			return "redirect:/cart/view";
		} else if (cartDetailIds.length == 1) {
			for (String string : cartDetailIds) {
				if (string.isEmpty()) {
					messageCart = "Vui lòng chọn sản phẩm để đặt hàng";
					return "redirect:/cart/view";
				}
			}
		}

		Account account = accountRepository.findAccountById(idAccount);
		List<Address> listAddress = addressRepository.findBListyAccount(account.getId());

		if (listAddress.isEmpty()) {
			messageAddress = "Hãy thêm địa chỉ nhận hàng trước, sau đó ĐẶT HÀNG";

			return "redirect:/home/profile";
		}
		address = listAddress.get(idAddress);

		httpSession.setAttribute("address", address);
		httpSession.setAttribute("listAddress", listAddress);
		if (id != null) {
			model.addAttribute("idAddress", id);
			Address diachiExist = addressRepository.findById(id).get();
			model.addAttribute("idTP", diachiExist.getProvince_id());
			model.addAttribute("idQuan", diachiExist.getDistrict_id());
			model.addAttribute("idXaPhuong", diachiExist.getWard_code());
		} else {
			model.addAttribute("idAddress", listAddress.get(0).getId());
			Address diachiExist = addressRepository.findById(listAddress.get(0).getId()).get();
			model.addAttribute("idTP", diachiExist.getProvince_id());
			model.addAttribute("idQuan", diachiExist.getDistrict_id());
			model.addAttribute("idXaPhuong", diachiExist.getWard_code());

		}

		model.addAttribute("nameAccount", account.getFullname());
		model.addAttribute("view", "Order.jsp");

		return "user/font-end/index";
	}

	@PostMapping("cart/order1")
	public String oder(@RequestParam(name = "note", defaultValue = "không có") String note,@RequestParam("shippingFee") String shipingFee, Model model) {
		int i = 0;
		String cleanedShippingFee = shipingFee.replace(".", "");
		shipfee = Double.parseDouble(cleanedShippingFee);
		Account account = accountRepository.findAccountById(idAccount);
		List<ProductDetail> productDetails = (List<ProductDetail>) httpSession.getAttribute("productsDetails2");
		List<CartDetail> cartDetails2 = (List<CartDetail>) httpSession.getAttribute("cartDetails2");
		Orders orders = new Orders();
		orders.setOrder_date(new Date());
		orders.setAccount(account);
		orders.setTotal((double) httpSession.getAttribute("totalPice") + shipfee);
		orders.setNote(note);
		orders.setFee(shipfee);
		
		Status status = statusOderRepository.findById(1).get();
		orders.setStatus(status);
		List<Address> addresses = (List<Address>) httpSession.getAttribute("listAddress");
		orders.setAddress(address);
		Payments payments = paymentRepository.findById(1).get();
		orders.setPayment(payments);
		oderRepository.saveAndFlush(orders);
		for (ProductDetail productDetail : productDetails) {
			OrderDetail orderDetail = new OrderDetail();
			orderDetail.setOrder(orders);
			orderDetail.setPrice(productDetail.getPrice());
			orderDetail.setProductDetail(productDetail);
			orderDetail.setQuantity(cartDetails2.get(i).getQuantity());
			productDetail.setQuantity(productDetail.getQuantity() - cartDetails2.get(i).getQuantity());
			productDetailRepository.saveAndFlush(productDetail);
			detailRepository.saveAndFlush(orderDetail);
			cartRepository.delete(cartDetails2.get(i));
			i++;
		}

		messageOrder = "Đơn hàng của bạn đã được đặt";

		httpSession.removeAttribute("cartDetails2");
		httpSession.removeAttribute("productsDetails2");
		httpSession.removeAttribute("quantityProduct2");
		httpSession.removeAttribute("totalPice");
		cartDetailIds = null;
		return "redirect:/cart/view";
	}

	@PostMapping("address/order")
	public String addressOrder() {

		return "";
	}

	private String vnp_HashSecret = "UE5AQGNZSQFJD9VOXA4HAIFMYH4FZ1J0";
	private String vnp_Url = "https://sandbox.vnpayment.vn/paymentv2/vpcpay.html";

	@PostMapping("cart/order")
	public String checkout(@RequestParam("totalPrice") String amount, @RequestParam("shippingFee") String shippingFee,
			Model model) throws UnsupportedEncodingException {

		String vnp_Version = "2.1.0";
		String vnp_Command = "pay";
		String orderType = "billpayment";
		String vnp_TxnRef = String.valueOf(System.currentTimeMillis());
		String vnp_IpAddr = "127.0.0.1";
		String vnp_TmnCode = "QIPASG5N";

		System.out.println(amount);
		System.out.println(shippingFee);
		String cleanedAmount = amount.replace(".", "");
		String cleanedShippingFee = shippingFee.replace(".", "");
		shipfee = Double.parseDouble(cleanedShippingFee);
		System.out.println(cleanedAmount);
		System.out.println(cleanedShippingFee);

		totalAmount = Double.parseDouble(cleanedAmount) + shipfee;
		System.out.println(totalAmount.toString());
		/* Float tongInteger = (float) totalAmount; */

		Map<String, String> vnp_Params = new HashMap<>();
		vnp_Params.put("vnp_Version", vnp_Version);
		vnp_Params.put("vnp_Command", vnp_Command);
		vnp_Params.put("vnp_TmnCode", vnp_TmnCode);

		vnp_Params.put("vnp_Amount", String.valueOf((int) (totalAmount * 100)));
		vnp_Params.put("vnp_CurrCode", "VND");
		vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
		vnp_Params.put("vnp_OrderInfo", "Thanh toan don hang: " + vnp_TxnRef);
		vnp_Params.put("vnp_OrderType", orderType);
		vnp_Params.put("vnp_Locale", "vn");
		vnp_Params.put("vnp_ReturnUrl", "http://localhost:8080/cart/view1");
		vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

		Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
		String vnp_CreateDate = formatter.format(cld.getTime());
		vnp_Params.put("vnp_CreateDate", vnp_CreateDate);
		cld.add(Calendar.MINUTE, 15);
		String vnp_ExpireDate = formatter.format(cld.getTime());
		vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

		List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
		Collections.sort(fieldNames);
		StringBuilder hashData = new StringBuilder();
		StringBuilder query = new StringBuilder();
		Iterator<String> itr = fieldNames.iterator();
		while (itr.hasNext()) {
			String fieldName = itr.next();
			String fieldValue = vnp_Params.get(fieldName);
			if (fieldValue != null && fieldValue.length() > 0) {
				hashData.append(fieldName);
				hashData.append('=');
				hashData.append(URLEncoder.encode(fieldValue, "UTF-8"));
				query.append(URLEncoder.encode(fieldName, "UTF-8"));
				query.append('=');
				query.append(URLEncoder.encode(fieldValue, "UTF-8"));
				if (itr.hasNext()) {
					query.append('&');
					hashData.append('&');
				}
			}
		}
		String queryUrl = query.toString();
		String vnp_SecureHash = HmacUtils.hmacSha512Hex(vnp_HashSecret, hashData.toString());
		queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
		String paymentUrl = vnpayConfig.getVnp_Url() + "?" + queryUrl;

		return "redirect:" + paymentUrl;
	}

	// Annotation này đảm bảo rằng tất cả các thao tác trong phương thức
	@Transactional
	@RequestMapping("cart/view1")
	public String paymentResult(HttpServletRequest request,
			@RequestParam(name = "note", defaultValue = "không có") String note, Model model)
			throws UnsupportedEncodingException {
		Map<String, String> vnp_Params = new HashMap<>();
		for (Enumeration<String> params = request.getParameterNames(); params.hasMoreElements();) {
			String param = params.nextElement();
			String value = request.getParameter(param);
			if ((value != null) && (value.length() > 0)) {
				vnp_Params.put(param, value);
			}
		}

		String vnp_SecureHash = request.getParameter("vnp_SecureHash");

		if (vnp_Params.containsKey("vnp_SecureHashType")) {
			vnp_Params.remove("vnp_SecureHashType");
		}
		if (vnp_Params.containsKey("vnp_SecureHash")) {
			vnp_Params.remove("vnp_SecureHash");
		}

		List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
		Collections.sort(fieldNames);
		StringBuilder hashData = new StringBuilder();
		for (String fieldName : fieldNames) {
			String fieldValue = vnp_Params.get(fieldName);
			if ((fieldValue != null) && (fieldValue.length() > 0)) {
				hashData.append(fieldName);
				hashData.append('=');
				hashData.append(URLEncoder.encode(fieldValue, "UTF-8"));
				hashData.append('&');
			}
		}
		if (hashData.length() > 0) {
			hashData.deleteCharAt(hashData.length() - 1);
		}

		String secureHash = HmacUtils.hmacSha512Hex(vnp_HashSecret, hashData.toString());

		if (secureHash.equals(vnp_SecureHash)) {
			String responseCode = request.getParameter("vnp_ResponseCode");
			if ("00".equals(responseCode)) {

				int i = 0;
				idAccount = (Integer) httpSession.getAttribute("user");
				
				System.out.println(idAccount);
				Account account = accountRepository.findAccountById(idAccount);
				List<ProductDetail> productDetails = (List<ProductDetail>) httpSession.getAttribute("productsDetails2");
				List<CartDetail> cartDetails2 = (List<CartDetail>) httpSession.getAttribute("cartDetails2");
				Orders orders = new Orders();
				orders.setOrder_date(new Date());
				orders.setAccount(account);
				orders.setTotal(totalAmount);
				orders.setNote(note);
				orders.setFee(shipfee);
				Status status = statusOderRepository.findById(1).get();
				orders.setStatus(status);
				List<Address> addresses = (List<Address>) httpSession.getAttribute("listAddress");

				orders.setAddress(address);
				Payments payments = paymentRepository.findById(2).get();
				orders.setPayment(payments);
				oderRepository.saveAndFlush(orders);
				for (ProductDetail productDetail : productDetails) {
					OrderDetail orderDetail = new OrderDetail();
					orderDetail.setOrder(orders);
					orderDetail.setPrice(productDetail.getPrice());
					orderDetail.setProductDetail(productDetail);
					orderDetail.setQuantity(cartDetails2.get(i).getQuantity());
					productDetail.setQuantity(productDetail.getQuantity() - cartDetails2.get(i).getQuantity());
					productDetailRepository.saveAndFlush(productDetail);
					detailRepository.saveAndFlush(orderDetail);
					cartRepository.delete(cartDetails2.get(i));
					i++;
				}

				messageOrder = "Đơn hàng của bạn đã được đặt";

				httpSession.removeAttribute("cartDetails2");
				httpSession.removeAttribute("productsDetails2");
				httpSession.removeAttribute("quantityProduct2");
				httpSession.removeAttribute("totalPice");
				cartDetailIds = null;
				return "redirect:/cart/view";

			} else {
				model.addAttribute("message", "Giao dịch không thành công. Mã lỗi: " + responseCode);

			}

		} else {
			model.addAttribute("message", "Chữ ký không hợp lệ!");
		}

		return "redirect:/cart/view";
	}
}
