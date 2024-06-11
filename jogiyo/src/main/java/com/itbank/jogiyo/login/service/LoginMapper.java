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
}
