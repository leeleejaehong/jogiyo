package com.itbank.jogiyo.store.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.MenuDTO;
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
	public LoginDTO getOwner(String id) {
		LoginDTO owner = sqlSession.selectOne("store.getOwner", id);
		return owner;
	}
	public int updateOwner(LoginDTO dto) {
		return sqlSession.update("store.editOwner", dto);	
	}
	public int deleteOwner(String id) {
		return sqlSession.delete("store.deleteOwner", id);
	}
	public List<StoreDTO> findStore(String storename){
		List<StoreDTO>list = sqlSession.selectList("store.findStore" , storename);
		return list;
	}
	public int updateStore(StoreDTO dto) {
		return sqlSession.update("store.updateStore", dto);
	}
	public int deleteStore(String storename) {
		return sqlSession.delete("store.deleteStore", storename);
	}
	public int findcateid(int storeid) {
		int cateid= sqlSession.selectOne("store.findcateid",storeid);
		return cateid;
	}
	public int addMenu(MenuDTO dto) {
		return sqlSession.insert("store.addMenu",dto);
	}
	public List<MenuDTO> listMenu(int storeid){
		List<MenuDTO>list=sqlSession.selectList("store.listMenu",storeid);
		return list;
	}
	public int deleteMenu(int menuid) {
		return sqlSession.delete("store.deleteMenu", menuid);
	}
	public List<MenuDTO> getMenu(int menuid){
		List<MenuDTO>list =sqlSession.selectList("store.getMenu", menuid);
		return list;
	}
	public int editMenu(MenuDTO dto) {
		return sqlSession.update("store.editMenu",dto);
	}
}