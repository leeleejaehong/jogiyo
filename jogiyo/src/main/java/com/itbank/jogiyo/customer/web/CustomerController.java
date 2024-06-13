package com.itbank.jogiyo.customer.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.jogiyo.customer.service.CustomerMapper;
import com.itbank.jogiyo.dto.CouponDTO;
import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.OrderDTO;
import com.itbank.jogiyo.dto.StoreDTO;
import com.itbank.jogiyo.dto.ViewStoreDTO;
import com.itbank.jogiyo.util.UploadFile;

@Controller
public class CustomerController {
	@Autowired
	private CustomerMapper customerMapper;
	private UploadFile uploadFile; 
	
	@RequestMapping("/customer/mypage.do")
	public String listCustomer(HttpServletRequest req) {
        LoginDTO userId = (LoginDTO) req.getSession().getAttribute("jId");
        LoginDTO user = customerMapper.cMypageList(userId.getId());
        req.setAttribute("customer", user); 
        return "customer/mypage";
    }
	@RequestMapping(value = "/customer/update.do", method = RequestMethod.POST)
	public ModelAndView updateCustomerOk(HttpServletRequest req , LoginDTO dto) {
		ModelAndView mav = new ModelAndView();
		int res = customerMapper.updateCustomer(dto);
		if (res>0) {
			mav.addObject("msg","회원수정 완료");
			mav.addObject("url","/customer/mypage.do");
			mav.setViewName("message");
		}else {
			mav.addObject("msg", "회원 수정 실패");
			mav.addObject("url","/customer/mypage.do");
			mav.setViewName("message");
		}
	 return mav;
	}
	
	@RequestMapping("/customer/secession.do")
	public ModelAndView secessionCustomer(HttpServletRequest req) {
		LoginDTO id = (LoginDTO) req.getSession().getAttribute("jId");
		ModelAndView mav = new ModelAndView();
		int res = customerMapper.secessionCustomer(id);
		mav.addObject("msg","탈퇴성공");
		mav.addObject("url","/index.do");
		mav.setViewName("message");
		req.getSession().invalidate();
		return mav;
	} 
	
	@RequestMapping("/customer/pastOrder.do")
	public String listPastOrder(HttpServletRequest req) {
		//String fileDir = "D:\\uploads\\";
        LoginDTO userId = (LoginDTO) req.getSession().getAttribute("jId");
        List<OrderDTO> pOrder = customerMapper.pastOrder(userId.getId()); 
        req.setAttribute("porder", pOrder); 
       
        //req.setAttribute("path", fileDir);
        return "customer/pastOrder";
    }
	
	@RequestMapping("/customer/basket.do")
	public String BasketList(HttpServletRequest req) {
		return "customer/basket";
	}
	 
	@RequestMapping("/customer/coupon.do")
	public String cCouponList(HttpServletRequest req) {
		LoginDTO userId = (LoginDTO) req.getSession().getAttribute("jId");
		List<CouponDTO> coupon = customerMapper.customerCoupon(userId.getId());
		req.setAttribute("cCoupon", coupon);  
		return "customer/coupon";
	}
	
	@RequestMapping(value="/customer/viewStore.do", method = RequestMethod.POST)
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
}
	 
