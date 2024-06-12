package com.itbank.jogiyo.login.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.login.service.LoginMapper;

@Controller
public class LoginController {
	@Autowired
	private LoginMapper loginmapper;
	
	@RequestMapping("/login/login.do")
	public String login(HttpServletRequest req) {
		return "login/login";
	}
	@RequestMapping(value = "/login/loginOk.do", method=RequestMethod.POST)
	public String loginOk(HttpServletRequest req, LoginDTO dto) {
		if(loginmapper.isPassword(dto)) {
			LoginDTO jId = loginmapper.getAccount(dto.getId());
			req.getSession().setAttribute("jId", jId);
			req.setAttribute("msg", "로그인 성공");
			req.setAttribute("url", "/index.do");
			return "message";
			}
		req.setAttribute("msg", "로그인 실패");
		req.setAttribute("url", "/index.do");
		return "message";
	}
		
	
	@RequestMapping("/login/logout.do")
	public String logout(HttpServletRequest req) {
		req.getSession().invalidate();
		return "redirect:" + req.getContextPath() + "/index.do";
	}
	
	@RequestMapping("/login/join_membership.do")
	public String join_membership(HttpServletRequest req) {
		
		return "/login/join_membership";
	}
	
	@RequestMapping("/login/id_find.do")
	public String id_find(HttpServletRequest req, LoginDTO dto) {
		List<LoginDTO> list = loginmapper.listaccount();
		req.setAttribute("list", list);
		return "/login/id_find";
	}
	
	@RequestMapping("/login/pw_find.do")
	public String pw_find(HttpServletRequest req, LoginDTO dto) {
		List<LoginDTO> list = loginmapper.listaccount();
		req.setAttribute("list", list);
		return "/login/pw_find";
	}
	
	@RequestMapping(value = "/login/join_membership_ok.do", method=RequestMethod.POST)
	public String joinMember(HttpServletRequest req, LoginDTO dto) {
		dto.setPhone(req.getParameter("phone1")+"-"+req.getParameter("phone2")+"-"+req.getParameter("phone3"));
		int res = loginmapper.join_membership_ok(dto);
		if (res>0) {
			req.setAttribute("msg","회원가입이 되셨습니다.");
			req.setAttribute("url", "login.do");
		}else {
			req.setAttribute("msg", "회원가입이 실패하셨습니다.");
			req.setAttribute("url", "login.do");
		}
		return "message";
	}
	
	@ResponseBody
	@RequestMapping("/login/idCheck.do")
	public String chekId(@RequestParam("jid") String id) {
		int res = loginmapper.checkId(id);
		if (res == 0) {
			return "OK";
		}else {
			return "NO";
		}
	}
}