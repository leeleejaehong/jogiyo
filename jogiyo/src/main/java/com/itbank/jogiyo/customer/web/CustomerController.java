package com.itbank.jogiyo.customer.web;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.servlet.ModelAndView;

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

	@RequestMapping(value = "/customer/cateList.do", method = RequestMethod.POST)
	public String jogiyoCateList(HttpServletRequest req, @RequestParam("cateid") int cateid) {
		List<ViewCateStoreDTO> catelist = customerMapper.cateStoreList(cateid);
		List<CategoryDTO> list2 = customerMapper.cateList();
		if (catelist == null) {
			catelist = new ArrayList<>();
		}
		req.setAttribute("cateStoreList", catelist);
		req.setAttribute("cateList", list2);
		return "customer/jogiyoCateList";
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

}
