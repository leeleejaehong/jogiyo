package com.itbank.jogiyo.login.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.jogiyo.dto.LoginDTO;

@Service
public class LoginMapper {
	@Autowired
	private SqlSession sqlSession;
	
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
	
	public LoginDTO id_find(LoginDTO dto) {
		LoginDTO id_find = sqlSession.selectOne("login.id_find", dto);
		return id_find;
	}
	
	public LoginDTO pw_find(LoginDTO dto) {
		LoginDTO pw_find = sqlSession.selectOne("login.pw_find", dto);
		return pw_find;
	}
	
	public int join_membership_ok(LoginDTO dto) {
		int res = sqlSession.insert("login.join_membership_ok", dto);

		return res;
	}
	
	public int checkId(String id) {
		return sqlSession.selectOne("checkId", id);
	}
}