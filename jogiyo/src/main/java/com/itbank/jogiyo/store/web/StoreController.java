package com.itbank.jogiyo.store.web;

import java.awt.Window;
import java.awt.event.WindowStateListener;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.StoreDTO;
import com.itbank.jogiyo.properties.PropertyReader;
import com.itbank.jogiyo.store.service.StoreMapper;
import com.itbank.jogiyo.util.UploadFile;

@Controller
public class StoreController {
	@Autowired
	private StoreMapper storemapper;
	private UploadFile uploadFile; 
	
	@RequestMapping("/store/store.do")
	public String listStore(HttpServletRequest req) {
		List<StoreDTO> list = storemapper.listStore();
		req.setAttribute("list", list);
		return "store/store";
	}
	@RequestMapping(value="/store/AddStore.do" , method = RequestMethod.GET)
	public String AddStore(HttpServletRequest req) {
		return "store/AddStore";
		
	}
	@RequestMapping(value ="/store/AddStore.do", method = RequestMethod.POST)
	public ModelAndView AddStoreOk(HttpServletRequest req , StoreDTO dto) {
		ModelAndView mav = new ModelAndView();
		uploadFile = new UploadFile();
		if(uploadFile.uploadFile(dto.getFile())) {
			dto.setImg(uploadFile.getFullName());
		int res = storemapper.addStore(dto);
		if (res>0) {
			mav.addObject("msg" , "가게추가 완료!");
			mav.addObject("url" , "/store/ListStore.do");
			mav.setViewName("message");
		}else {
			mav.addObject("msg" , "가게추가 실패! 관리자에게 문의해주세요");
			mav.addObject("url" , "/store/ListStore.do");
			mav.setViewName("message");
		}
		}
		return mav;
		//가게 추가 
	}
	@RequestMapping("/store/ListStore.do")
	public String ListStore(HttpServletRequest req) {	
		String fileDir = "D:\\uploads\\";
		HttpSession session = req.getSession();
		LoginDTO dto =  (LoginDTO)session.getAttribute("jId") ;		
		List<StoreDTO> slist = storemapper.getStore(dto.getId());
		req.setAttribute("getStore",slist);
		req.setAttribute("path", fileDir);
		//이미지처리도해야됨
		return "store/ListStore";
		//세션에있는 아이디값으로 storeDTO값 받아오기
	}
	@RequestMapping("/store/Myinfo.do")
		public String MyInfo(HttpServletRequest req) {
		return "store/MyInfo";
	}
	@RequestMapping("/store/test.do")
		public String test(HttpServletRequest req) {
		PropertyReader reader = new PropertyReader();
		String key = reader.getProperty("kakao_key");
		req.setAttribute("key", key);
		req.setAttribute("address", "서울 종로구 삼일대로 394");
		return "store/kakaomaptest";
	}
	@RequestMapping("/store/selectStore.do")
		public String selectStore(HttpServletRequest req) {
		return "store/selectStore";
	}
	@RequestMapping("/store/reviewStore.do")
	public String orderList(HttpServletRequest req) {
		return "store/reviewStore";
	}
	@RequestMapping("/store/storeMenu.do")
	public String storeMenu(HttpServletRequest req) {
		return "store/storeMenu";
	}
	@RequestMapping("/store/storeSales.do")
	public String storeSales(HttpServletRequest req) {
		return "store/storeSales";
	}
	@RequestMapping("/store/ownerInfo.do")
	public String ownerInfo(HttpServletRequest req) {
		return "store/ownerInfo";
	}
	@RequestMapping("/store/storeInfo.do")
	public String storeInfo(HttpServletRequest req) {
		String fileDir = "D:\\uploads\\";
		HttpSession session = req.getSession();
		LoginDTO dto =  (LoginDTO)session.getAttribute("jId") ;		
		List<StoreDTO> slist = storemapper.getStore(dto.getId());
		req.setAttribute("getStore",slist);
		req.setAttribute("path", fileDir);
		//이미지처리도해야됨
		return "store/storeInfo";
	}
	@RequestMapping("/store/addMenu.do")
	public String addMenu(HttpServletRequest req) {
		return "store/addMenu";
	}
	@RequestMapping("/store/editMenu.do")
	public String editMenu(HttpServletRequest req) {
		return "store/editMenu";
	}
	@RequestMapping("/store/deleteMenu.do")
	public String deleteMenu(HttpServletRequest req) {
		return "store/deleteMenu";
	}
	@RequestMapping("/store/editStore.do")
	public String editStore(HttpServletRequest req) {
		
		return "store/editStore";
	}
}
