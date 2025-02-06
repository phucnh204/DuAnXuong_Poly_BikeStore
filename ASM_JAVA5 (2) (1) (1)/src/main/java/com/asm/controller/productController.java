package com.asm.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.apache.coyote.http11.filters.SavedRequestInputFilter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import com.asm.model.Category;
import com.asm.model.Color;
import com.asm.model.PhotoProduct;
import com.asm.model.Product;
import com.asm.model.ProductDetail;
import com.asm.model.Size;
import com.asm.repository.CategoryRepository;
import com.asm.repository.ColorRepository;
import com.asm.repository.PhotoProductRepository;
import com.asm.repository.ProductDetailRepository;
import com.asm.repository.ProductRepository;
import com.asm.repository.SizeRepository;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;

@Controller
public class productController {
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
	CategoryRepository categoryRepository;
	@Autowired
	ServletContext servletContext;
	@Autowired
	PhotoProductRepository photoProductRepository;

	String error = "";
	String success = "";

	@GetMapping("/product/detail/{id}")
	public String DetailViews(Model model, @PathVariable("id") Integer id) {
		Product product = productRepository.findById(id).orElse(null);

		List<Object[]> colors = colorRepository.findColorByProductSQL(id);
		List<Size> sizes = sizeRepository.findSizeByProductSQL(id);
		List<String> photoUrls = productRepository.findAllPhotoSQL(id);
		List<Object[]> detailPd = productRepository.findDetailSQL(id);

		if (detailPd.isEmpty()) {
			return "user/font-end/ErrorPage";
		}

		Object[] detail = detailPd.get(0);
		Integer colorId = (Integer) detail[2];
		Integer sizeId = (Integer) detail[3];

		// Lấy giá dựa vào colorId và sizeId
		List<ProductDetail> productDetails = productDetailRepository.findPriceBTSQL(id, colorId, sizeId);
		if (!productDetails.isEmpty()) {
			model.addAttribute("price", productDetails.get(0).getPrice());
		}
				model.addAttribute("photos", photoUrls);
		model.addAttribute("sizes", sizes);
		model.addAttribute("colors", colors);
		model.addAttribute("detail", detail);
		model.addAttribute("colorId", colorId);
		model.addAttribute("sizeId", sizeId);
		model.addAttribute("product", product);

		request.setAttribute("view", "ProductDetail.jsp");
		return "user/font-end/index";
	}

	@GetMapping("/product/detail/{id}/{colorId}/{sizeId}")
	public String DetailViews1(Model model, @PathVariable("id") Integer id, @PathVariable("colorId") Integer colorId,
			@PathVariable("sizeId") Integer sizeId) {
		Product product = productRepository.findById(id).orElse(null);

		if (product == null) {
			return "user/font-end/ErrorPage";
		}

		List<String> photoUrls = productRepository.findAllPhotoSQL(id);
		List<Object[]> colors = colorRepository.findColorByProductSQL(id);
		List<Size> sizes = sizeRepository.findSizeByProductSQL(id);

		// Lấy giá dựa vào colorId và sizeId
		List<ProductDetail> productDetails = productDetailRepository.findPriceBTSQL(id, colorId, sizeId);
		if (!productDetails.isEmpty()) {
			model.addAttribute("price", productDetails.get(0).getPrice());
		}
		String mes =  cartDetailController.messageProduc;
		cartDetailController cartDetailController = new cartDetailController();
		model.addAttribute("messageProduc", mes);
		System.out.println("thông báo: "+cartDetailController.messageProduc);

		model.addAttribute("photos", photoUrls);
		model.addAttribute("sizes", sizes);
		model.addAttribute("colors", colors);
		model.addAttribute("colorId", colorId);
		model.addAttribute("sizeId", sizeId); 
		model.addAttribute("product", product);

		request.setAttribute("view", "ProductDetail.jsp");
		return "user/font-end/index";
	}

	@GetMapping("/demoswiper/{id}")
	public String DemoSwiper(Model model, @PathVariable("id") Integer id) {
		List<String> photoUrls = productRepository.findAllPhotoSQL(id);
		model.addAttribute("photos", photoUrls);
		return "user/font-end/demoSwiper";
	}

	@GetMapping("/errorpage")
	public String ErrorPageView() {
		return "user/font-end/ErrorPage";
	}

	@GetMapping("/admin")
	public String adminProduct(Model model, HttpServletRequest request,
			@RequestParam("pageNo") Optional<Integer> pageNo, @RequestParam("pageSize") Optional<Integer> pageSize,
			@RequestParam("activeTab") Optional<String> activeTab,
			@RequestParam(value = "resetError", required = false) boolean resetError) {

		if (resetError) {
			error = "";
			success = "";
		}

		if (!error.isEmpty()) {
			model.addAttribute("error", error);
		} else {
			model.addAttribute("error", "");
		}

		if (!success.isEmpty()) {
			model.addAttribute("success", success);
		} else {
			model.addAttribute("success", "");
		}

		Product product = new Product();
		int currentPage = pageNo.orElse(0);
		int pageSizeValue = pageSize.orElse(5);
		String activeTabValue = activeTab.orElse("product-edition");
		Pageable pageable = PageRequest.of(currentPage, pageSizeValue, Sort.by("name").ascending());

		Page<Product> productList = productRepository.findAll(pageable);
		List<Category> categories = categoryRepository.findAllbyStatus();

		model.addAttribute("product", product);
		model.addAttribute("productlist", productList.getContent());
		model.addAttribute("categories", categories);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", productList.getTotalPages());
		model.addAttribute("pageNumbers", getPageNumbers(productList));
		model.addAttribute("activeTab", activeTabValue);

		request.setAttribute("view", "bikeProduct.jsp");
		return "admin/font-end/index";
	}

	private List<Integer> getPageNumbers(Page<Product> productPage) {
		int totalPages = productPage.getTotalPages();
		List<Integer> pageNumbers = new ArrayList<>();
		for (int i = 0; i < totalPages; i++) {
			pageNumbers.add(i);
		}
		return pageNumbers;
	}

	@PostMapping("/admin/product/insert")
	public String adminProductInsert(@Valid @ModelAttribute("product") Product product, BindingResult bindingResult,
			@RequestPart("photo") MultipartFile photo, @RequestParam("name") String nameBike,
			@RequestParam("trademark") String trademark, @RequestParam("description") String description) {
		boolean check = false;
//		if(bindingResult.hasErrors()) {
//			error = "Không được bỏ trống các trường (Tên xe, thương hiệu, mô trả)!";
//			System.out.println(error);
//			return "redirect:/admin";
//		}

		if (nameBike.isEmpty()) {
			error = "Tên xe không được bỏ trống!";
			check = true;
		} else if (trademark.isEmpty()) {
			error = "Thương hiệu không được bỏ trống!";
			check = true;
		} else if (description.isEmpty()) {
			error = "Mô tả không được bỏ trống!";
			check = true;
		}

		if (check == true) {
			return "redirect:/admin";
		} else {
			if (!photo.isEmpty()) {
				String fileName = photo.getOriginalFilename();
				String realPath = servletContext.getRealPath("/images/" + fileName);
				Path path = Path.of(realPath);
				if (!Files.exists(path)) {
					try {
						Files.createDirectories(path);
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
				File file = new File(realPath);
				try {
					photo.transferTo(file);
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				product.setPhoto(fileName);
			} else {
				product.setPhoto(product.getPhoto());
			}
			productRepository.saveAndFlush(product);
			error = "";
			success = "Sản phẩm mới đã được thêm thành công!";
			return "redirect:/admin";
		}
	}

	@GetMapping("/admin/product/edit/{id}")
	public String editProduct(Model model, @PathVariable("id") Integer id,
			@RequestParam("pageNo") Optional<Integer> pageNo, @RequestParam("pageSize") Optional<Integer> pageSize,
			@RequestParam("activeTab") Optional<String> activeTab) {
		Product product = productRepository.findById(id).get();
		int currentPage = pageNo.orElse(0);
		int pageSizeValue = pageSize.orElse(5);
		String activeTabValue = activeTab.orElse("product-edition");
		Pageable pageable = PageRequest.of(currentPage, pageSizeValue, Sort.by("name").ascending());

		Page<Product> productList = productRepository.findAll(pageable);
		List<Category> categories = categoryRepository.findAll();

		model.addAttribute("product", product);
		model.addAttribute("productlist", productList.getContent());
		model.addAttribute("categories", categories);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", productList.getTotalPages());
		model.addAttribute("pageNumbers", getPageNumbers(productList));
		model.addAttribute("activeTab", activeTabValue);

		request.setAttribute("view", "bikeProduct.jsp");
		return "admin/font-end/index";
	}

	@PostMapping("/admin/product/update")
	public String updateProduct(@Valid Model model, @ModelAttribute("product") Product product,
			BindingResult bindingResult, @RequestPart("photo") MultipartFile photo, @RequestParam("id") Integer id,
			@RequestParam("name") String nameBike, @RequestParam("trademark") String trademark,
			@RequestParam("description") String description) {
		boolean check = false;

		if (nameBike.isEmpty()) {
			error = "Tên xe không được bỏ trống!";
			check = true;
		} else if (trademark.isEmpty()) {
			error = "Thương hiệu không được bỏ trống!";
			check = true;
		} else if (description.isEmpty()) {
			error = "Mô tả không được bỏ trống!";
			check = true;
		}

		if (check == true) {
			return "redirect:/admin";
		} else {
			product.setId(id);

			// Retrieve the existing product from the database
			Optional<Product> existingProductOpt = productRepository.findById(id);
			if (existingProductOpt.isPresent()) {
				Product existingProduct = existingProductOpt.get();

				// If photo is not empty, update the photo
				if (!photo.isEmpty()) {
					String fileName = photo.getOriginalFilename();
					String realPath = servletContext.getRealPath("/images/" + fileName);
					Path path = Path.of(realPath);
					if (!Files.exists(path)) {
						try {
							Files.createDirectories(path);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
					File file = new File(realPath);
					try {
						photo.transferTo(file);
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
					product.setPhoto(fileName);
				} else {
					product.setPhoto(existingProduct.getPhoto());
				}

				// Update other fields
				product.setName(nameBike);
				product.setTrademark(trademark);
				product.setDescription(description);
				product.setQuantity(existingProduct.getQuantity());
				// Save the updated product
				productRepository.saveAndFlush(product);
				success = "Sản phẩm đã được cập nhật thành công!";
			} else {
				error = "Sản phẩm không tồn tại!";
			}

			return "redirect:/admin";
		}
	}

	@GetMapping("/admin/product/addphoto/{id}")
	public String addPhotoProduct(Model model, @PathVariable("id") Integer id,
			@RequestParam("pageNo") Optional<Integer> pageNo, @RequestParam("pageSize") Optional<Integer> pageSize,
			@RequestParam("activeTab") Optional<String> activeTab) {

		int currentPage = pageNo.orElse(0);
		int pageSizeValue = pageSize.orElse(5);
		String activeTabValue = activeTab.orElse("product-edition");
		Pageable pageable = PageRequest.of(currentPage, pageSizeValue, Sort.by("id").ascending());

		Page<PhotoProduct> photoProducts = photoProductRepository.findAllPhotoSQL(pageable, id);
		PhotoProduct photoProduct = new PhotoProduct();
		Product product = productRepository.findById(id).get();
		model.addAttribute("product", product);
		model.addAttribute("photoProduct", photoProduct);
		model.addAttribute("photoProducts", photoProducts.getContent());
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("totalPages", photoProducts.getTotalPages());
		model.addAttribute("pageNumbers", getPageNumbers1(photoProducts));
		model.addAttribute("activeTab", activeTabValue);

		request.setAttribute("view", "addphoto.jsp");
		return "admin/font-end/index";
	}

	private List<Integer> getPageNumbers1(Page<PhotoProduct> productPage) {
		int totalPages = productPage.getTotalPages();
		List<Integer> pageNumbers = new ArrayList<>();
		for (int i = 0; i < totalPages; i++) {
			pageNumbers.add(i);
		}
		return pageNumbers;
	}

	@PostMapping("/admin/product/addphoto/insert")
	public String adminAddPhotoInsert(@Valid @ModelAttribute("photoProduct") PhotoProduct photoProduct,
			BindingResult bindingResult, @RequestParam("photo") MultipartFile[] photos,
			@RequestParam("id") Integer id) {
		// Kiểm tra xem photoProduct có sản phẩm nào được liên kết hay không
		Product product = productRepository.findById(id).get();
		photoProduct.setProduct(product);

		if (photos != null && photos.length > 0) {
			for (MultipartFile photo : photos) {
				String fileName = photo.getOriginalFilename();
				// Tạo đường dẫn thư mục dựa trên ID sản phẩm
				String folderPath = servletContext.getRealPath("/images/" + photoProduct.getProduct().getId());
				Path path = Path.of(folderPath);
				if (!Files.exists(path)) {
					try {
						Files.createDirectories(path);
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
				// Tạo đường dẫn đầy đủ cho file ảnh
				String filePath = folderPath + "/" + fileName;
				File file = new File(filePath);
				try {
					photo.transferTo(file);
				} catch (IllegalStateException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}

				// Tạo một đối tượng mới của PhotoProduct cho mỗi ảnh
				PhotoProduct newPhotoProduct = new PhotoProduct();
				newPhotoProduct.setProduct(photoProduct.getProduct());
				newPhotoProduct.setImage(photoProduct.getProduct().getId() + "/" + fileName); // Lưu đường dẫn tương đối
				// Lưu đối tượng mới vào cơ sở dữ liệu
				photoProductRepository.save(newPhotoProduct);
			}
		}
		return "redirect:/admin";
	}

	@GetMapping("/admin/product/photo/delete/{id}")
	public String deletePhotoDetail(Model model, @PathVariable("id") Integer id) {
		PhotoProduct photoProduct = photoProductRepository.findById(id).get();
		photoProductRepository.delete(photoProduct);
		request.setAttribute("view", "bikeProductDetail.jsp");
		return "redirect:/admin";

	}

}
