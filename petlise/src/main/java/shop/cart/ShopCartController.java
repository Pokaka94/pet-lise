package shop.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import jakarta.servlet.http.HttpSession;

@Controller
public class ShopCartController {

	@Autowired
	ShopCartService service;

	@GetMapping("/shopcart")
	public ModelAndView cartList(HttpSession session) {
		ShopCartDTO dto = new ShopCartDTO();
		ModelAndView mv = new ModelAndView();
		String user_id = session.getAttribute("user_id").toString();
		List<ShopCartDTO> cart = service.getCartList(user_id);
		
		dto.setUser_id(user_id);
		mv.addObject("cart", cart);
		mv.setViewName("/shop/shopCart");
		return mv;
	}
	
	@GetMapping("/getUserId")
	@ResponseBody
	public Map<String, Object> getUserId(HttpSession session) {
	    String user_id = (String) session.getAttribute("user_id");

	    Map<String, Object> response = new HashMap<>();
	    response.put("user_id", user_id);

	    return response;
	}

	@PostMapping("/deletecartlist")
	@ResponseBody
	public String cartDelete(@RequestParam("product_name") String product_name) {
		int result = service.deleteCartList(product_name);
		return "{\"result\":\"" + result + "\"}";
	}

	@PostMapping("/savecartlist")
	@ResponseBody
	public String saveCartList(@RequestBody ShopCartDTO dto) {
		int result = service.saveCartList(dto);
		return "{\"result\":\"" + result + "\"}";
	}
}
