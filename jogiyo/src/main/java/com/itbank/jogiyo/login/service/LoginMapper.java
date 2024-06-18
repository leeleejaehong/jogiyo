package com.itbank.jogiyo.login.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itbank.jogiyo.dto.LoginDTO;

@Service
@Transactional(readOnly = true)
public class LoginMapper {
	@Autowired
	private SqlSession sqlSession;
	private final PasswordEncoder bcryptPasswordEncoder;
	
	public LoginMapper(PasswordEncoder bcryptPasswordEncoder) {
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
	}
	
	public List<LoginDTO> listaccount(){
		List<LoginDTO> list = sqlSession.selectList("login.listAccount");
		return list;
	}
	
	public boolean isPassword(LoginDTO dto) {
		return sqlSession.selectOne("login.isPassword", dto);
	}
	
	public LoginDTO getAccount(String id) {
		LoginDTO dto = sqlSession.selectOne("login.getAccount", id);
		return dto;
	}
	
	public LoginDTO join_membership(LoginDTO dto) {
		LoginDTO join_membership = sqlSession.selectOne("login.join_membership", dto);
		return join_membership;
	}
	
	public int join_membership_ok(LoginDTO dto) {
		dto.setPasswd(bcryptPasswordEncoder.encode(dto.getPasswd()));
		int res = sqlSession.insert("login.join_membership_ok", dto);
		return res;
	}
	
	public int checkId(String id) {
		return sqlSession.selectOne("checkId", id);
	}
	public LoginDTO id_find(Map<String, String> params) {
	    LoginDTO id_find = sqlSession.selectOne("login.id_find", params);
	    return id_find;
	}
	
	public LoginDTO pw_find(Map<String, String> params) {
		LoginDTO pw_find = sqlSession.selectOne("login.pw_find", params);
		return pw_find;
	}
}