package com.itbank.jogiyo.admin.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.itbank.jogiyo.admin.service.AdminMapper3;
import com.itbank.jogiyo.dto.NoticeDTO;

@Controller
public class AdminController3 {
	@Autowired
	private AdminMapper3 adminmapper;
	
	@RequestMapping("admin/notice.do")
	public String notice() {
		return "admin/notice";
	}

	@RequestMapping(value = "admin/insertNotice.do", method = RequestMethod.POST)
	public String insertNotice(HttpServletRequest req, NoticeDTO dto) {
		int res = adminmapper.insertNotice(dto);
		return "redirect:/admin/listNotice.do";
	}
	

	
}
