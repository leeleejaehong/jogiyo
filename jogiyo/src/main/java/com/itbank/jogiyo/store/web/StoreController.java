package com.itbank.jogiyo.store.web;

import java.awt.Window;
import java.awt.event.WindowStateListener;
import java.io.PrintStream;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.MenuDTO;
import com.itbank.jogiyo.dto.StoreDTO;
import com.itbank.jogiyo.login.service.LoginMapper;
import com.itbank.jogiyo.store.service.StoreMapper;
import com.itbank.jogiyo.util.UploadFile;

@Controller
public class StoreController {
	@Autowired
	private StoreMapper storemapper;
	private UploadFile uploadFile; 
	private LoginMapper loginmapper;
	
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
		}
		System.out.println(dto.getPostcode()+","+dto.getAddress()+","+dto.getDetailaddress()+","+dto.getExtraaddress());
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
		return mav;
		//가게 추가 
	}
	@RequestMapping("/store/ListStore.do")
	public String ListStore(HttpServletRequest req) {	
		HttpSession session = req.getSession();
		LoginDTO dto =  (LoginDTO)session.getAttribute("jId") ;		
		List<StoreDTO> slist = storemapper.getStore(dto.getId());
		req.setAttribute("getStore",slist);
	
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
		req.setAttribute("address", "서울 종로구 삼일대로 394");
		return "store/kakaomaptest";
	}
	@RequestMapping("/store/selectStore.do")
		public String selectStore(HttpServletRequest req) {
		String storename = req.getParameter("storename");
		String storeid=req.getParameter("storeid");
		req.setAttribute("storename", storename);
		req.setAttribute("storeid", storeid);
		return "store/selectStore";
	}
	@RequestMapping("/store/reviewStore.do")
	public String orderList(HttpServletRequest req) {
		return "store/reviewStore";
	}
	@RequestMapping("/store/storeMenu.do")
	public String storeMenu(HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		req.setAttribute("storeid",storeid);
		List<MenuDTO>mlist = storemapper.listMenu(Integer.parseInt(storeid));
		req.setAttribute("mlist",mlist);
		return "store/storeMenu";
	}
	@RequestMapping("/store/storeSales.do")
	public String storeSales(HttpServletRequest req) {
		return "store/storeSales";
	}
	@RequestMapping("/store/ownerInfo.do")
	public String ownerInfo(HttpServletRequest req) {
		HttpSession Session = req.getSession();
		LoginDTO dto = (LoginDTO)Session.getAttribute("jId");
		LoginDTO owner = storemapper.getOwner(dto.getId());
		req.setAttribute("owner", owner);
		return "store/ownerInfo";
	}
	@RequestMapping("/store/storeInfo.do")
	public String storeInfo(HttpServletRequest req) {
		
		HttpSession session = req.getSession();
		LoginDTO dto =  (LoginDTO)session.getAttribute("jId") ;		
		List<StoreDTO> slist = storemapper.getStore(dto.getId());
		req.setAttribute("getStore",slist);
		
		//이미지처리도해야됨
		return "store/storeInfo";
	}
	@RequestMapping("/store/addMenu.do")
	public String addMenu(HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		int cateid=storemapper.findcateid(Integer.parseInt(storeid));
		req.setAttribute("cateid", cateid);
		req.setAttribute("storeid", storeid);
		return "store/addMenu";
	}
	@RequestMapping(value="/store/addMenuPro.do", method=RequestMethod.POST)
	public String addMenuPro(@ModelAttribute MenuDTO dto,BindingResult result,HttpServletRequest req) {
		String storeid=req.getParameter("storeid");
		uploadFile = new UploadFile();
		if(uploadFile.uploadFile(dto.getFile())) {
			dto.setImg(uploadFile.getFullName());
		}
		if(result.hasErrors()) {
			System.out.println("메뉴dto구성중 오류발생");
		}
		int res = storemapper.addMenu(dto);
		
		if (res>0) {
			req.setAttribute("url", "/store/storeMenu.do?storeid="+storeid);
			req.setAttribute("msg","메뉴추가완료!");
			req.setAttribute("storeid", storeid);
		}else {
			req.setAttribute("url","/store/storeMenu.do");
			req.setAttribute("msg", "메뉴추가실패!");
			
		}
		return "message";
	}
	@RequestMapping("/store/editMenu.do")
	public String editMenu(HttpServletRequest req) {
		String menuid=req.getParameter("menuid");
		List<MenuDTO>getMenu=storemapper.getMenu(Integer.parseInt(menuid));
		req.setAttribute("getMenu", getMenu);
		return "store/editMenu";
	}
	@RequestMapping(value="/store/editMenuPro.do" ,method=RequestMethod.POST)
	public ModelAndView editMenuPro(@ModelAttribute MenuDTO dto,BindingResult result,HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		String storeid=req.getParameter("storeid");
		uploadFile = new UploadFile();
		try {	
		if(dto.getFile()!=null) {
			if(uploadFile.uploadFile(dto.getFile())) {
				dto.setImg(uploadFile.getFullName());
		}
			}
		}catch(IndexOutOfBoundsException e){
			e.printStackTrace();
		}
		
		if(result.hasErrors()) {
			System.out.println("dto생성중 오류발생");
		}
		
		int res=storemapper.editMenu(dto);
		if(res>0) {
			mav.addObject("msg","메뉴수정완료");
			mav.addObject("url","/store/storeMenu.do?storeid="+storeid);
			mav.setViewName("message");
		}else {
			mav.addObject("msg","메뉴수정실패");
			mav.addObject("url","/store/storeMenu.do?storeid="+storeid);
			mav.setViewName("message");
		}
		return mav;
	}
	@RequestMapping("/store/deleteMenu.do")
	public String deleteMenu(HttpServletRequest req) {
		String storeid = req.getParameter("storeid");
		String menuid=req.getParameter("menuid");
		int res=storemapper.deleteMenu(Integer.parseInt(menuid));
		if(res>0) {
			req.setAttribute("url","/store/storeMenu.do?storeid="+storeid);
			req.setAttribute("msg", "메뉴삭제완료");
		
		}else {
			req.setAttribute("url", "/store/storeMenu.do");
			req.setAttribute("msg", "메뉴삭제실패");
		}
		
		return "message";
	}
	@RequestMapping("/store/editStore.do")
	public String editStore(HttpServletRequest req) {
		String storename=req.getParameter("storename");
		List <StoreDTO>list=storemapper.findStore(storename);
		req.setAttribute("findStore",list);
		return "store/editStore";
	}
	@RequestMapping(value ="/store/editStorePro.do", method=RequestMethod.POST)
	public ModelAndView editStorePro(@ModelAttribute StoreDTO dto, BindingResult result) {
		ModelAndView mav = new ModelAndView();
		uploadFile = new UploadFile();
		try {	
		if(dto.getFile()!=null) {
			if(uploadFile.uploadFile(dto.getFile())) {
				dto.setImg(uploadFile.getFullName());
		}
			}
		}catch(IndexOutOfBoundsException e){
			e.printStackTrace();
		}
		if (result.hasErrors()) {
			
			dto.setCouponid(0);
		}
		
		//System.out.println(dto.getStorecontent()+","+dto.getCateid()+","+dto.getStorename()+","+
		//dto.getImg()+","+dto.getLat()+","+dto.getHar()+","+dto.getStoreid());
		int res = storemapper.updateStore(dto);
		if (res>0) {
			mav.addObject("msg" , "가게수정 완료!");
			mav.addObject("url" , "/store/storeInfo.do");
			mav.setViewName("message");
		}else {
			mav.addObject("msg" , "가게수정 실패! 관리자에게 문의해주세요");
			mav.addObject("url" , "/store/storeInfo.do");
			mav.setViewName("message");
		
		}
		return mav;
		
		
	}
	@RequestMapping("/store/editOwner.do")
	public ModelAndView editOwner(@ModelAttribute LoginDTO dto, BindingResult result) {
		if(result.hasErrors()) {
			dto.setGrade("미정");
		}
			
		int res=storemapper.updateOwner(dto);
		ModelAndView mav = new ModelAndView();
		if(res>0) {
			mav.addObject("msg","수정이 완료되었습니다");
			mav.addObject("url","/store/Myinfo.do");
			mav.setViewName("message");
		}else {
			mav.addObject("msg","수정실패 관리자에게 문의해주세요");
			mav.addObject("url","/store/Myinfo.do");
			mav.setViewName("message");
		}
		return mav;
	}
	@RequestMapping("/store/deleteOwner.do")
	public ModelAndView deleteOwner(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		HttpSession session = req.getSession();
		LoginDTO dto =  (LoginDTO) session.getAttribute("jId");
		String id = dto.getId();
		int res = storemapper.deleteOwner(id);
		if(res>0) {
			session.invalidate();
			mav.addObject("msg","탈퇴가 완료되었습니다");
			mav.addObject("url","/");
			mav.setViewName("message");
		}else {
			mav.addObject("msg","탈퇴실패 관리자에게 문의해주세요");
			mav.addObject("url","/");
			mav.setViewName("message");
		}
		return mav;
	}
	@RequestMapping("/store/deleteStore.do")
	public String deleteStore(HttpServletRequest req) {
		String storename = req.getParameter("storename");
		int res = storemapper.deleteStore(storename);
		if(res>0) {
			req.setAttribute("url", "/store/storeInfo.do");
			req.setAttribute("msg", "가게삭제완료");
		}
		return "message";
	}
}