package com.itbank.jogiyo.customer.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.jogiyo.dto.LoginDTO;

@Service
public class CustomerMapper {
	@Autowired
	private SqlSession sqlSession;
	
	 public LoginDTO cMypageList(String id) {
	        return sqlSession.selectOne("customer.cMypageList", id);
	    }

}
