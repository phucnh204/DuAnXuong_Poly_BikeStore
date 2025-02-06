package com.asm.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.asm.model.Account;
import com.asm.model.Address;
import com.asm.model.CartDetail;
import com.asm.model.Category;
import com.asm.model.Color;
import com.asm.model.Location;
import com.asm.model.Product;
import com.asm.model.ProductAndPrice;
import com.asm.model.Size;
import com.asm.repository.CartRepository;
import com.asm.repository.CategoryRepository;
import com.asm.repository.ColorRepository;
import com.asm.repository.FilterRepository;
import com.asm.repository.OrderDetailRepository;
import com.asm.repository.OrderRepository;
import com.asm.repository.ProductDetailRepository;
import com.asm.repository.ProductRepository;
import com.asm.repository.ProfileRepository;
import com.asm.repository.SizeRepository;
import com.asm.service.LocationService;
import com.asm.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class viewController {
@Autowired
HttpServletRequest request;
@Autowired
ProductRepository productRepository;
@Autowired
CategoryRepository categoryRepository;
@Autowired
ColorRepository colorRepository;
@Autowired
SizeRepository sizeRepository;
@Autowired
FilterRepository filterRepository;
@Autowired
ProductDetailRepository productDetailRepository;
@Autowired
OrderRepository orderRepository;
@Autowired
OrderDetailRepository detailRepository;

@Autowired
HttpSession session;

@Autowired
private LocationService locationService;
@Autowired
HttpSession httpSession;
@Autowired
ProfileRepository profileRepository;
@Autowired
CartRepository cartRepository;
@Autowired
OrderDetailRepository orderDetailRepository;
@Autowired
OrderRepository orRepository;

Integer idCategory = 0;
List<Integer> colorFilter = new ArrayList<>();
List<Integer> sizeFilter =  new ArrayList<>();
List<Integer> colorFilterC = new ArrayList<>();
List<Integer> sizeFilterC =  new ArrayList<>();
double priceMinvl = -1;
double priceMaxvl = -1;

@GetMapping("/home")
public String ShowHome(Model model, 
                       @RequestParam("pageNo") Optional<Integer> pageNo, 
                       @RequestParam("pageSize") Optional<Integer> pageSize,
                       @RequestParam(name = "keyword", defaultValue = "") String keyWord) {
    int currentPage = pageNo.orElse(0);
    int pageSizeValue = pageSize.orElse(8);
    Integer idAccount = (Integer) httpSession.getAttribute("user");
    List<CartDetail> sizeCart = new ArrayList<>();
    sizeCart = cartRepository.findProduct(idAccount);
    httpSession.setAttribute("quantityProduct", sizeCart.size());
    Pageable pageable =PageRequest.of(currentPage, pageSizeValue, Sort.by("name").ascending());
    Page<Object[]> productPage = productRepository.findTop8SaleSQL(keyWord,pageable);
    
    Page<Object[]> Top8new = productRepository.findTop8NewSQL(keyWord,pageable);
    
    List<Category> categoriesHeader = categoryRepository.findAll();
    httpSession.setAttribute("categoriesHeader", categoriesHeader);
    model.addAttribute("listnew", Top8new);
    model.addAttribute("listItem", productPage);
    model.addAttribute("currentPage", currentPage);
    model.addAttribute("totalPages", productPage.getTotalPages());
    model.addAttribute("pageNumbers", getPageNumbers(productPage));

 
    request.setAttribute("view", "Home.jsp");
    return "user/font-end/index";
}

private List<Integer> getPageNumbers(Page<Object[]> productPage) {
    int totalPages = productPage.getTotalPages();
    List<Integer> pageNumbers = new ArrayList<>();
    for (int i = 0; i < totalPages; i++) {
        pageNumbers.add(i);
    }
    return pageNumbers;
}

@GetMapping("/home/products")
public String  productsViews(Model model, @RequestParam("pageNo") Optional<Integer> pageNo, 
        					 @RequestParam("pageSize") Optional<Integer> pageSize,
        					 @RequestParam(name =  "idcty", defaultValue = "0") Integer id,
        					 @RequestParam(name = "keyword", defaultValue = "") String keyWord,
        					 @RequestParam(name =  "minPrice", defaultValue = "0") double minPrice,
        					 @RequestParam(name =  "maxPrice", defaultValue = "0") double maxPrice,
        					 @RequestParam(name =  "idcl", defaultValue = "") String idColor,
        					 @RequestParam(name =  "ids", defaultValue = "") String idSize,
        					 @RequestParam(name =  "check1", defaultValue = "false") boolean check1,
        					 @RequestParam(name =  "check2", defaultValue = "false") boolean check2) {

	colorFilter = new ArrayList<>();
		sizeFilter = new ArrayList<>();
		double priceMin = 0;
		double priceMax = (double) productDetailRepository.findPriceMax();
		 if (maxPrice == 0) {
				maxPrice = priceMax;
			}
		 if (priceMaxvl != maxPrice || priceMinvl != minPrice) {
			 priceMaxvl = maxPrice;
			 priceMinvl = minPrice;
			
		}
		if (idColor.equals("")) {
			if (colorFilterC.size() == 1 && check1 == true) {
				System.out.println("code ayyy 1");
				colorFilterC = new ArrayList<>();
			} if (colorFilterC.size() == 0) {
				System.out.println("code ayyy 2");
				colorFilter = colorRepository.findIdColor();
			}else {
				System.out.println("code ayyy 3");
				colorFilter = colorFilterC;
			}
			
		}else {
			colorFilterC = new ArrayList<>();
			String listIdColor[] =  idColor.split(",");
			   for (String color : listIdColor) {
	                try {
	                    int colorId = Integer.parseInt(color); 
	                    colorFilter.add(colorId);
	                    colorFilterC.add(colorId);
	                } catch (NumberFormatException e) {
	                    
	                    e.printStackTrace();
	                }
	            }
		}
		
		if (idSize.equals("")) {
			if (sizeFilterC.size() == 1 && check2 == true) {
				sizeFilterC = new ArrayList<>();
			}if (sizeFilterC.size() == 0) {
				sizeFilter = sizeRepository.findIdSize();
			}else {
				sizeFilter = sizeFilterC;
			}
		}else {
			sizeFilterC = new ArrayList<>();
			String listIdSize[] =  idSize.split(",");
			   for (String size : listIdSize) {
	                try {
	                    int sizeId = Integer.parseInt(size); 
	                    sizeFilter.add(sizeId);
	                    sizeFilterC.add(sizeId);
	                } catch (NumberFormatException e) {
	                    
	                    e.printStackTrace();
	                }
	            }
		}
		if (id != 0) {
			idCategory = id;
		}
		
	 	int currentPage = pageNo.orElse(0);
	    int pageSizeValue = pageSize.orElse(5);
	    Pageable pageable =PageRequest.of(currentPage, pageSizeValue, Sort.by("name").ascending());
					
	    if (request.getParameter("keyword") != null) {
	    	colorFilter = colorRepository.findIdColor();
			sizeFilter = sizeRepository.findIdSize();
			colorFilterC = new ArrayList<>();
			sizeFilterC = new ArrayList<>();
        } 
	    
				
	    Page<Object> productPage = filterRepository.findByCategory(idCategory, keyWord, minPrice, maxPrice, colorFilter, sizeFilter, pageable);
	    //
	    List<Category> categories = categoryRepository.findAll();
	    
	    List<Color> colors = colorRepository.findAll();
	    List<Size> sizes = sizeRepository.findAll();
	    //
	    model.addAttribute("colorFilterC", colorFilterC);
	    model.addAttribute("sizeFilterC", sizeFilterC);
	    model.addAttribute("colors", colors);
	    model.addAttribute("sizes", sizes);
	    model.addAttribute("priceMin", priceMin);
	    model.addAttribute("priceMax", priceMax);
	    model.addAttribute("priceMinvl", priceMinvl);
	    model.addAttribute("priceMaxvl", priceMaxvl);
	    model.addAttribute("categories", categories);
	    model.addAttribute("listItem", productPage);
	    model.addAttribute("currentPage", currentPage);
	    model.addAttribute("totalPages", productPage.getTotalPages());
	    model.addAttribute("pageNumbers", getPageNumbers2(productPage));

	request.setAttribute("view", "Product.jsp");
	return "user/font-end/index";
}

private List<Integer> getPageNumbers2(Page<Object> productPage) {
    int totalPages = productPage.getTotalPages();
    List<Integer> pageNumbers = new ArrayList<>();
    for (int i = 0; i < totalPages; i++) {
        pageNumbers.add(i);
    }
    return pageNumbers;
}

private List<Integer> getPageNumbers1(Page<Product> productPage) {
    int totalPages = productPage.getTotalPages();
    List<Integer> pageNumbers = new ArrayList<>();
    for (int i = 0; i < totalPages; i++) {
        pageNumbers.add(i);
    }
    return pageNumbers;
}

@GetMapping("/home/profile")
public String showProfile(Model model) {
    String username = (String) session.getAttribute("username");
    System.out.println("Session username: " + username);
    
    try {
        Account account = profileRepository.findByUsername(username);

        if (account != null) {
            model.addAttribute("account", account);
        }
     // Lấy danh sách tỉnh/thành phố từ API
        List<Location> provinces = locationService.getAllProvinces();
        for (Location location : provinces) {
            System.out.println("Thành phố nè: " + location);
        }
        model.addAttribute("provinces", provinces);
        List<Address> addresses = account != null ? account.getAddresses() : null;
        model.addAttribute("addresses", addresses);
        request.setAttribute("view", "Profile.jsp");
    } catch (Exception e) {
        model.addAttribute("error", "Lỗi khi tải thông tin tài khoản. Vui lòng thử lại sau.");
    }

    return "user/font-end/index";
}

@GetMapping("/home/cart")
public String  cartViews() {
	request.setAttribute("view", "Cart.jsp");
	return "user/font-end/index";
} 



@GetMapping("/home/news")
public String  newsViews() {
	request.setAttribute("view", "News.jsp");
	return "user/font-end/index";
}


@GetMapping("/home/policy")
public String  policyViews() {
	request.setAttribute("view", "FranchisePolicy.jsp");
	return "user/font-end/index";
}

@GetMapping("/home/about")
public String  aboutViews() {
	request.setAttribute("view", "About.jsp");
	return "user/font-end/index";
}

@GetMapping("/home/contact")
public String  contactViews() {
	request.setAttribute("view", "Contact.jsp");
	return "user/font-end/index";
}



@GetMapping("/home/login")
public String  loginViews() {
	request.setAttribute("view", "Login.jsp");
	return "user/font-end/index";
}

@GetMapping("/home/register")
public String  registerViews() {
	request.setAttribute("view", "Register.jsp");
	return "user/font-end/index";
}

@GetMapping("/home/payment_guide")
public String  payment_guideViews() {
	request.setAttribute("view", "PaymentGuide.jsp");
	return "user/font-end/index";
}





}


