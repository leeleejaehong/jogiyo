package com.itbank.jogiyo.store.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.jogiyo.dto.StoreDTO;

@Service
public class StoreMapper {

	@Autowired
	private SqlSession sqlSession;
	
	public List<StoreDTO> listStore(){
		List<StoreDTO> list = sqlSession.selectList("store.listStore");
		return list;
	}
	public int addStore(StoreDTO dto) {
		return sqlSession.insert("store.addStore" , dto);
	}
	public List<StoreDTO> getStore(String id){
		List<StoreDTO> slist= sqlSession.selectList("store.getStore" , id);		
		return slist;
	}
}
