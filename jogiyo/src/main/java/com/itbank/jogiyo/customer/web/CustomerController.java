package com.itbank.jogiyo.customer.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itbank.jogiyo.customer.service.CustomerMapper;
import com.itbank.jogiyo.dto.BasketDTO;
import com.itbank.jogiyo.dto.CategoryDTO;
import com.itbank.jogiyo.dto.CouponDTO;
import com.itbank.jogiyo.dto.DeliveryDTO;
import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.MenuDTO;
import com.itbank.jogiyo.dto.NoticeDTO;
import com.itbank.jogiyo.dto.OrderDTO;
import com.itbank.jogiyo.dto.ReviewDTO;
import com.itbank.jogiyo.dto.StoreDTO;
import com.itbank.jogiyo.dto.ViewCateStoreDTO;
import com.itbank.jogiyo.dto.ViewStoreDTO;
import com.itbank.jogiyo.login.service.LoginMapper;
import com.itbank.jogiyo.properties.PropertyReader;
import com.itbank.jogiyo.util.UploadFile;

@Controller
public class CustomerController {
	@Autowired
	private CustomerMapper customerMapper;
	@Autowired
	private LoginMapper loginMapper;
	private UploadFile uploadFile;

	@RequestMapping("/customer/mypage.do")
	public String listCustomer(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		LoginDTO user = customerMapper.cMypageList(authentication.getName());
		req.setAttribute("customer", user);
		return "customer/mypage";
	}

	@RequestMapping(value = "/customer/update.do", method = RequestMethod.POST)
	public String updateCustomer(HttpServletRequest req, LoginDTO dto) {
		req.setAttribute("customer", dto);
		return "customer/updateCustomer";
	}

	@RequestMapping(value = "/customer/updateOk.do", method = RequestMethod.POST)
	public ModelAndView updateCustomerOk(HttpServletRequest req, LoginDTO dto) {
		ModelAndView mav = new ModelAndView();
		int res = customerMapper.updateCustomer(dto);
		if (res > 0) {
			mav.addObject("msg", "회원수정 완료");
			mav.addObject("url", "/customer/mypage.do");
			mav.setViewName("message");
		} else {
			mav.addObject("msg", "회원 수정 실패");
			mav.addObject("url", "/customer/mypage.do");
			mav.setViewName("message");
		}
		return mav;
	}

	@RequestMapping("/customer/secession.do")
	public ModelAndView secessionCustomer(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		ModelAndView mav = new ModelAndView();
		int res = customerMapper.secessionCustomer(authentication.getName());
		if (res > 0) {
			mav.addObject("msg", "탈퇴성공");
			mav.addObject("url", "/login/logout.do");
			mav.setViewName("message2");
		} else {
			mav.addObject("msg", "탈퇴실패");
			mav.addObject("url", "/");
			mav.setViewName("message");
		}
		return mav;
	}

	@RequestMapping("/customer/basket.do")
	public String BasketList(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<BasketDTO> list = customerMapper.basket(authentication.getName());
		req.setAttribute("basket", list);
		return "customer/basket";
	}

	@RequestMapping("/customer/pastOrder.do")
	public String listPastOrder(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<OrderDTO> pOrder = customerMapper.pastOrder(authentication.getName());
		req.setAttribute("porder", pOrder);
		// req.setAttribute("path", fileDir);
		return "customer/pastOrder";
	}

	@RequestMapping("/customer/coupon.do")
	public String cCouponList(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<CouponDTO> coupon = customerMapper.customerCoupon(authentication.getName());
		req.setAttribute("cCoupon", coupon);
		return "customer/coupon";
	}

	@RequestMapping(value = "/customer/viewStore.do")
	public String viewStore(HttpServletRequest req, @RequestParam("storeid") int storeid,
			@RequestParam(value = "isReview", required = false) String isReview) {
		StoreDTO dto = customerMapper.viewStore(storeid);
		List<ViewStoreDTO> menuList = customerMapper.viewStoreInfo(storeid);
		Map<String, List<ViewStoreDTO>> menuMap = new HashMap<>();
		for (ViewStoreDTO menu : menuList) {
			if (!menuMap.containsKey(menu.getJstorename())) {
				menuMap.put(menu.getJstorename(), new ArrayList<>());
			}
			menuMap.get(menu.getJstorename()).add(menu);
		}
		List<ReviewDTO> review = new ArrayList<>();
		review = customerMapper.listReview(storeid);
		if (isReview != null && isReview.equals("ok")) {
			req.setAttribute("isReview", isReview);
		}
		if (review.size() != 0 || review.isEmpty()) {
			req.setAttribute("review", review);
		}
		req.setAttribute("store", dto);
		req.setAttribute("menuMap", menuMap);
		PropertyReader reader = new PropertyReader();
		String key = reader.getProperty("kakao_key");
		req.setAttribute("key", key);
		return "customer/viewStore";
	}

	@RequestMapping("/customer/storeList.do")
	public String jogiyoStoreList(HttpServletRequest req, @RequestParam(value = "cateId", required = false) String cateId) {
		List<StoreDTO> list = new ArrayList<>();
		if(cateId != null) {
			list = customerMapper.storeListByCate(cateId);
		}else {
			list = customerMapper.storeList();
		}
		List<CategoryDTO> list2 = customerMapper.cateList();
		req.setAttribute("cateList", list2);
		req.setAttribute("storeList", list);
		return "customer/jogiyoStoreList";
	}

	@RequestMapping(value = "/customer/basketList.do", method = RequestMethod.POST)
	public String OrderBasketList(HttpServletRequest req, @RequestParam("sub") String menuid,
			@RequestParam("sub2") String storename) {
		List<MenuDTO> list = customerMapper.basketList(menuid);
		req.setAttribute("basket", list);
		req.setAttribute("storename", storename);
		return "customer/basket";
	}

	@ResponseBody
	@RequestMapping(value = "customer/listCate.ajax", produces = "text/plain;charset=UTF-8", method = RequestMethod.POST)
	public String listAccount(HttpServletRequest req, @RequestParam("sel") String sel) {
		List<StoreDTO> catelist = customerMapper.cateStoreList(sel);
		List<CategoryDTO> list2 = customerMapper.cateList();
		if (catelist == null) {
			catelist = new ArrayList<>();
		}
		Gson gson = new Gson();
		JsonArray jArray = new JsonArray();
		Iterator<StoreDTO> it = catelist.iterator();
		while (it.hasNext()) {
			StoreDTO dto = it.next();
			JsonObject object = new JsonObject();
			object.addProperty("storeid", dto.getStoreid());
			object.addProperty("storename", dto.getStorename());
			object.addProperty("cateid", dto.getCateid());
			object.addProperty("storecontent", dto.getStorecontent());
			object.addProperty("id", dto.getId());
			object.addProperty("img", dto.getImg());
			object.addProperty("couponid", dto.getCouponid());
			object.addProperty("address", dto.getAddress());
			// object.addProperty("file", dto.getFile());
			object.addProperty("detailaddress", dto.getDetailaddress());
			object.addProperty("extraaddress", dto.getExtraaddress());
			object.addProperty("postcode", dto.getPostcode());
			object.addProperty("catename", dto.getCatename());
			object.addProperty("lat", dto.getLat());
			object.addProperty("har", dto.getHar());
			jArray.add(object);
		}
		String json = gson.toJson(jArray);
		req.setAttribute("cateList", list2);
		return json;
	}

	@ResponseBody
	@RequestMapping(value = "customer/checkPasswd.ajax", produces = "text/plain;charset=UTF-8", method = RequestMethod.POST)
	public String ChekcPass(@RequestParam("id") String id, @RequestParam("passwd") String passwd) {
		LoginDTO dto = new LoginDTO();
		dto.setId(id);
		dto.setPasswd(passwd);
		if (loginMapper.isPass(dto)) {
			return "ok";
		} else {
			return "nok";
		}
	}

	@ResponseBody
	@RequestMapping(value = "customer/insertBasket.ajax", method = RequestMethod.POST, consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> insertBasket(@RequestBody BasketDTO[] baksets) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		int res = 0;
		for (BasketDTO basket : baksets) {
			basket.setId(authentication.getName());
			basket.setTotprice(basket.getTotprice() * basket.getQty());
			res += customerMapper.insertBasket(basket);
		}
		String msg = "장바구니에 물품을 " + res + "개 만큼 담았습니다. \n장바구니 페이지로 이동하시겠습니까?";
		return ResponseEntity.ok(msg);
	}

	@RequestMapping(value = "customer/insertReview.do", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public ModelAndView insertReview(HttpServletRequest req, ReviewDTO dto) {
		UploadFile uploadFile = new UploadFile();
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		ModelAndView mav = new ModelAndView();
		int res = 0;
		if (uploadFile.uploadFile(dto.getFile())) {
			dto.setImg(uploadFile.getFullName());
			dto.setId(authentication.getName());
			res = customerMapper.insertReview(dto);
		}
		if (res > 0) {
			mav.addObject("msg", "리뷰작성 완료");
			mav.addObject("url", "/customer/viewStore.do?storeid=" + dto.getStoreid());
			mav.setViewName("message");
		} else {
			mav.addObject("msg", "리뷰 작성 실패");
			mav.addObject("url", "/customer/viewStore.do?storeid=" + dto.getStoreid());
			mav.setViewName("message");

		}
		return mav;
	}

	@ResponseBody
	@RequestMapping(value = "customer/addOrder.ajax", method = RequestMethod.POST, consumes = "application/json")
	public String addOrder(@RequestBody Map<String, Object> itemsObject) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		try {
			// itemsObject에서 데이터 추출 및 주문 데이터로 변환
			String menuname = "";
			DeliveryDTO delivery = new DeliveryDTO();
			for (Map.Entry<String, Object> entry : itemsObject.entrySet()) {
				Map<String, Object> item = (Map<String, Object>) entry.getValue();
				menuname += entry.getKey() + " ";
				OrderDTO order = new OrderDTO();
				order.setId(authentication.getName());
				order.setIndate(String.valueOf(System.currentTimeMillis())); // 현재 시간으로 설정

				// 값이 문자열인지 확인하고 변환
				int quantity = customerMapper.convertToInt(item.get("quantity"));
				int total = customerMapper.convertToInt(item.get("total"));
				int menuID = customerMapper.convertToInt(item.get("menuID"));
				int storeid = customerMapper.convertToInt(item.get("storeid"));
				int cateid = customerMapper.convertToInt(item.get("cateid"));
				String address = (String)item.get("address");
				order.setQty(quantity);
				order.setTotprice(total);
				order.setStoreid(storeid); // 실제 storeID로 설정
				order.setCateid(cateid); // 실제 cateID로 설정
				order.setMenuid(menuID);
				delivery.setDestiaddress(address);
				delivery.setStoreid(storeid);
				customerMapper.addOrder(order);
			}
			delivery.setMenuname(menuname);
			delivery.setId(authentication.getName());
			customerMapper.insertDelivery(delivery);
			int seq = customerMapper.seqDelivery();
			customerMapper.deleteCartItems(authentication.getName());
			return Integer.toString(seq-1);
		} catch (Exception e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
	@RequestMapping("/customer/viewDelivery.do")
	public String viewDelivery(@RequestParam("deliveryid") int deliveryid, HttpServletRequest req) {
		PropertyReader reader = new PropertyReader();
		String key = reader.getProperty("kakao_key");
		req.setAttribute("key", key);
		DeliveryDTO dto = customerMapper.viewDelivery(deliveryid);
		req.setAttribute("delivery", dto);
		return "customer/deliveryStatus";
	}

	@RequestMapping("/customer/notice.do")
	public String noticeList(HttpServletRequest req) {
		List<NoticeDTO> list = customerMapper.listNotice();
		req.setAttribute("list", list);
		return "customer/listNotice";
	}
	
	@RequestMapping("/customer/viewNotice.do")
	public String viewNotice(HttpServletRequest req, @RequestParam("notiid") int notiid) {
		NoticeDTO dto = customerMapper.viewNotice(notiid);
		req.setAttribute("dto", dto);
		return "customer/viewNotice";
	}
	@RequestMapping("customer/listDelivery.do")
	public String listDelivery(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		List<DeliveryDTO> dlist = customerMapper.listDelivery(authentication.getName());
		req.setAttribute("dlist", dlist);
		return "customer/listDelivery";
	}
	 //장바구니 삭제
    @RequestMapping(value = "/customer/BasketDelete.do", method = RequestMethod.POST) 
     public ModelAndView BasketDelete(HttpServletRequest req, @RequestParam("basketid") String basketid) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        int list = customerMapper.basketDelete(basketid); 
        ModelAndView mav = new ModelAndView();
         if (list > 0) {
            mav.addObject("msg", "장바구니에서 삭제 성공");
            mav.addObject("url", "/customer/basket.do");
            mav.setViewName("message");
         } else {
            mav.addObject("msg", "장바구니에서 삭제 실패");
            mav.addObject("url", "/customer/basket.do");
            mav.setViewName("message");
         }
         return mav;
     }
    //과거 주문내역 삭제
    
    @RequestMapping(value = "/customer/orderDelete.do", method =RequestMethod.POST) 
     public ModelAndView OrderDelete(HttpServletRequest req, @RequestParam("orderid") String orderid) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        int list = customerMapper.orderDelete(orderid); 
        ModelAndView mav = new ModelAndView();
         if (list > 0) {
            mav.addObject("msg", "주문내역 삭제 성공");
            mav.addObject("url", "/customer/pastOrder.do");
            mav.setViewName("message");
         } else {
            mav.addObject("msg", "주문내역 삭제 실패");
            mav.addObject("url", "/customer/pastOrder.do");
            mav.setViewName("message");
         }
         return mav;
     }
    //바로결제경로
    @RequestMapping("customer/directPay.do")
    public String directPayPage(Model model) {
         // 결제 페이지로 이동
         return "customer/directPay";
     }
    
     @ResponseBody
     @RequestMapping(value = "customer/directOrder.ajax", method = RequestMethod.POST, consumes = "application/json")
     public String directOrder(@RequestBody List<OrderDTO> orderList) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        DeliveryDTO delivery = new DeliveryDTO();
        String menuname = "";
        for(OrderDTO dto : orderList) {
           dto.setId(authentication.getName());
           menuname += dto.getMenuname()+ " ";
           System.out.println(dto.getMenuname());
           delivery.setDestiaddress(dto.getAddress());
           delivery.setStoreid(dto.getStoreid());
        }
        delivery.setMenuname(menuname);
        delivery.setId(authentication.getName());
        customerMapper.insertDelivery(delivery);
        int seq = customerMapper.seqDelivery();
           try {
                customerMapper.directOrder(orderList);
                return Integer.toString(seq-1);
            } catch (Exception e) {
                e.printStackTrace();
                return "error";
            }
        }

//  @ResponseBody
//  @RequestMapping(value = "/customer/kakaopay.ajax", method = RequestMethod.POST)
//  public KakaoPayReadyDTO KakaoPay(@RequestParam Map<String,Object> params) {
//      System.out.println("Received params: " + params);
//        KakaoPayReadyDTO res = customerMapper.kakaoPay(params);
//     
//  
//     return res;
//  }
//  @ResponseBody
//   @RequestMapping(value = "/api/kakaopay", method = RequestMethod.POST)
//   public String kakaoPay(@RequestBody Map<String, Object> params) {
//       String url = "https://open-api.kakaopay.com/v1/payment/ready";
//
//       HttpHeaders headers = new HttpHeaders();
//       headers.set("Content-Type", "application/json");
//       headers.set("Authorization", "KakaoAK SECRET_KEY_DEV9021211DB0E046ECE7E5FC9701CB1D019AE6B");
//
//       HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(params, headers);
//       RestTemplate restTemplate = new RestTemplate();
//       ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.POST, requestEntity, String.class);
//
//       return response.getBody();
//   }

//  @ResponseBody
//   @RequestMapping(value = "/api/kakaopay", method = RequestMethod.POST)
//  public ResponseEntity<?> kakaoPay(@RequestBody Map<String, Object> data) {
//     
//       try {
//           RestTemplate restTemplate = new RestTemplate();
//           HttpHeaders headers = new HttpHeaders();
//           headers.setContentType(MediaType.APPLICATION_JSON);
//           headers.set("Authorization",  "SECRET_KEY DEV9021211DB0E046ECE7E5FC9701CB1D019AE6B"); // Admin 키 입력
//           
//           Map<String, Object> params = new HashMap<>();
//           params.put("cid", "TC0ONETIME");
//           params.put("partner_order_id", "partner_order_id");
//           params.put("partner_user_id", "partner_user_id");
//           params.put("item_name", data.get("item_name"));
//           params.put("quantity", data.get("quantity"));
//           params.put("total_amount", data.get("total_amount"));
//           params.put("vat_amount", data.get("tax_free_amount"));
//           params.put("tax_free_amount", "0");
//           params.put("approval_url", "http://localhost:7080/kakaoPaySuccess");
//           params.put("cancel_url", "http://localhost:7080/kakaoPayCancel");
//           params.put("fail_url", "http://localhost:7080/kakaoPaySuccessFail");
//           HttpEntity<Map<String, Object>> entity = new HttpEntity<>(params, headers);
//           ResponseEntity<Map> response = restTemplate.exchange(
//               "https://open-api.kakaopay.com/online/v1/payment/ready",
//               HttpMethod.POST,
//               entity,
//               Map.class
//           );
//
//           return ResponseEntity.ok(response.getBody());
//       } catch (Exception e) {
//           e.printStackTrace();
//           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("카카오페이 요청 실패");
//       }
//   }
//
//  @GetMapping("/kakaoPaySuccess")
//   public String kakaoPaySuccess(@RequestParam("pg_token") String pg_token, Model model) {
//     Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//     List<BasketDTO> list = customerMapper.basket(authentication.getName());
//     //List<OrderDTO> order = customerMapper.addOrder(); 
//     
//       return "redirect:/customer/basket.do";
//   }
//  
//  
}
