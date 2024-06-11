package com.itbank.jogiyo.admin.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.jogiyo.dto.NoticeDTO;

@Service
public class AdminMapper3 {
	@Autowired
	private SqlSession sqlSession;
	
	public int insertNotice(NoticeDTO dto) {
		int res = sqlSession.insert("notice.insertNotice", dto);
		return res;
	}
	

}
