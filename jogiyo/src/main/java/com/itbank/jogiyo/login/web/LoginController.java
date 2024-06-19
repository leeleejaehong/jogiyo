package com.itbank.jogiyo.login.web;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

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

	@RequestMapping("/login/loginSuccess.do")
	public String loginSuccess(HttpServletRequest req) {
		req.setAttribute("msg","로그인 성공 하였습니다");
		req.setAttribute("url", "/");
		return "message";
	}
	
	@RequestMapping("/login/loginFail.do")
	public String loginFail(HttpServletRequest req) {
		req.setAttribute("msg","로그인 실패 하였습니다");
		req.setAttribute("url", "/login/login.do");
		return "message";
	}
	
	@RequestMapping("/login/join_membership.do")
	public String join_membership() {
		
		return "/login/join_membership";
	}
	@RequestMapping("/login/id_find.do")
	public String id_find(HttpServletRequest req, LoginDTO dto) {
		return "login/id_find";
	}

	@RequestMapping(value="/login/id_find_result.do", method=RequestMethod.POST)
    public String id_find_result(@RequestParam Map<String, String> params,
                               HttpServletRequest req) {
		String phone1 = params.get("phone1");
        String phone2 = params.get("phone2");
        String phone3 = params.get("phone3");
        String phone = phone1 + "-" + phone2 + "-" + phone3;
        String name = params.get("name");
        params.put("phone", phone);
        
        // 이름과 전화번호로 ID를 찾는 메서드를 호출합니다
        LoginDTO find = loginmapper.id_find(params);
        if (find!=null) {
        	String id = find.getId();
            req.setAttribute("msg", "아이디를 찾았습니다!");
            req.setAttribute("url", "/login/id_find_ff.do?id="+id);
			/* req.setAttribute("id", id); */
        } else {
            req.setAttribute("msg", "입력하신 정보와 일치하는 아이디가 없습니다.");
            req.setAttribute("url", "login.do");
        }
        return "message";
    }

	@RequestMapping("/login/id_find_ff.do")
    public String id_find_ff(HttpServletRequest req) {
		String id = req.getParameter("id");
		req.setAttribute("id", id);
		return "/login/id_find_result";
	}
	

	
	@RequestMapping("/login/pw_find.do")
	public String pw_find(HttpServletRequest req, LoginDTO dto) {
		List<LoginDTO> find = loginmapper.listaccount();
		req.setAttribute("find", find);
		return "/login/pw_find";
	}
	
	@RequestMapping("/login/pw_find_ok.do")
	public String pw_find_result(@RequestParam Map<String, String> params,
							HttpServletRequest req) {
		String phone1 = params.get("phone1");
		String phone2 = params.get("phone3");
		String phone3 = params.get("phone3");
		String phone = phone1 + "-" + phone2 + "-" + phone3;
		
		params.put("phone" ,phone);
		String name = params.get("name");
		String id = params.get("id");
		
		LoginDTO pfind = loginmapper.pw_find(params);
		if (pfind != null) {
			String pw = pfind.getPasswd();
			req.setAttribute("msg", "비밀번호를 찾았습니다!");
			req.setAttribute("url", "/login/pw_find_result.do?pw="+pw);
		}else {
			req.setAttribute("msg", "입력하신 정보와 일치하는 비밀번호가 없습니다.");
			req.setAttribute("url", "login.do");
		}
		return "message";
	}
	
	@RequestMapping("/login/pw_find_result.do")
	public String pw_ff(HttpServletRequest req) {
		String pw = req.getParameter("pw");
		req.setAttribute("pw", pw);
		return "/login/pw_find_result";
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