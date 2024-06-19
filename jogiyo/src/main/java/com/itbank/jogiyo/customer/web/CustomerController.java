package com.itbank.jogiyo.customer.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.itbank.jogiyo.customer.service.CustomerMapper;
import com.itbank.jogiyo.dto.CategoryDTO;
import com.itbank.jogiyo.dto.CouponDTO;
import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.MenuDTO;
import com.itbank.jogiyo.dto.OrderDTO;
import com.itbank.jogiyo.dto.StoreDTO;
import com.itbank.jogiyo.dto.ViewCateStoreDTO;
import com.itbank.jogiyo.dto.ViewStoreDTO;
import com.itbank.jogiyo.util.UploadFile;

@Controller
public class CustomerController {
	@Autowired
	private CustomerMapper customerMapper;
	private UploadFile uploadFile;

	@RequestMapping("/customer/mypage.do")
	public String listCustomer(HttpServletRequest req) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		LoginDTO user = customerMapper.cMypageList(authentication.getName());
		req.setAttribute("customer", user);
		return "customer/mypage";
	}

	@RequestMapping(value = "/customer/update.do", method = RequestMethod.POST)
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
		mav.addObject("msg", "탈퇴성공");
		mav.addObject("url", "/index.do");
		mav.setViewName("message");
		req.getSession().invalidate();
		return mav;
	}

	@RequestMapping("/customer/basket.do")
	public String BasketList(HttpServletRequest req) {
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

	@RequestMapping(value = "/customer/viewStore.do", method = RequestMethod.POST)
	public String viewStore(HttpServletRequest req, @RequestParam("storeid") int storeid) {
		StoreDTO dto = customerMapper.viewStore(storeid);
		List<ViewStoreDTO> menuList = customerMapper.viewStoreInfo(storeid);
		Map<String, List<ViewStoreDTO>> menuMap = new HashMap<>();
		for (ViewStoreDTO menu : menuList) {
			if (!menuMap.containsKey(menu.getJstorename())) {
				menuMap.put(menu.getJstorename(), new ArrayList<>());
			}
			menuMap.get(menu.getJstorename()).add(menu);
		}
		req.setAttribute("store", dto);
		req.setAttribute("menuMap", menuMap);
		return "customer/viewStore";
	}

	@RequestMapping("/customer/storeList.do")
	public String jogiyoStoreList(HttpServletRequest req) {
		List<StoreDTO> list = customerMapper.storeList();
		List<CategoryDTO> list2 = customerMapper.cateList();
		req.setAttribute("cateList", list2);
		req.setAttribute("storeList", list);
		return "customer/jogiyoStoreList";

	}

	@RequestMapping(value = "/customer/basketList.do", method = RequestMethod.POST)
	public String OrderBasketList(HttpServletRequest req, @RequestParam("sub") String menuid,
			@RequestParam("sub2") String storename) {
		System.out.println(storename);
		List<MenuDTO> list = customerMapper.basketList(menuid);
		req.setAttribute("blist", list);
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
		System.out.println(json);
		return json;
	}
}
