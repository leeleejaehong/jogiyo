package com.itbank.jogiyo.customer.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itbank.jogiyo.customer.service.CustomerMapper;
import com.itbank.jogiyo.dto.LoginDTO;

@Controller
public class CustomerController {
	@Autowired
	private CustomerMapper customerMapper;
	
	@RequestMapping("/customer/mypage.do")
	public String listCustomer(HttpServletRequest req) {
        LoginDTO userId = (LoginDTO) req.getSession().getAttribute("jId");
        
        // 사용자 ID로 사용자 정보 조회
        LoginDTO user = customerMapper.cMypageList(userId.getId());
        
        // 모델에 사용자 정보를 추가
        req.setAttribute("customer", user); //customer로 정보 저장. => 불러올때 customer.~ 이렇게 표시
        
        // mypage.jsp로 이동
        return "customer/mypage";
    }

	}
	

