package com.itbank.jogiyo.login.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.login.service.LoginMapper;

@Controller
public class LoginController {
	@Autowired
	private LoginMapper loginmapper;
	
	@RequestMapping("/login/login.do")
	public String login(HttpServletRequest req) {
		List<LoginDTO> list = loginmapper.listaccount();
		req.setAttribute("list", list);
		return "login/login";
	}
	@RequestMapping(value = "/login/loginOk.do", method=RequestMethod.POST)
	public String loginOk(HttpServletRequest req, LoginDTO dto) {
		if(loginmapper.isPassword(dto)) {
			LoginDTO jId = loginmapper.getAccount(dto.getId());
			req.getSession().setAttribute("jId", jId);
		}
		return "redirect:" + req.getContextPath() + "/index.do";
	}
	
	@RequestMapping("/login/logout.do")
	public String logout(HttpServletRequest req) {
		req.getSession().invalidate();
		return "redirect:" + req.getContextPath() + "/index.do";
	}
	
}
