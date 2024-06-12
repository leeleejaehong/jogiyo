package com.itbank.jogiyo.customer.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itbank.jogiyo.dto.CouponDTO;
import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.OrderDTO;
import com.itbank.jogiyo.dto.StoreDTO;
import com.itbank.jogiyo.dto.ViewStoreDTO;

@Service
public class CustomerMapper {
	@Autowired
	private SqlSession sqlSession;
	
	 public LoginDTO cMypageList(String id) {
	        return sqlSession.selectOne("customer.cMypageList", id);
	    }
	 
	 public int updateCustomer(LoginDTO dto) {
		 return sqlSession.update("customer.updateCustomer", dto);
		 
	 }
	 public int secessionCustomer(LoginDTO id) {
		 return sqlSession.delete("customer.secessionCustomer",id);
	 }
	 
	 public List<OrderDTO> pastOrder(String id) {
		 return sqlSession.selectList("customer.pastOrderList",id);
	 }
	 
	 public List<CouponDTO> customerCoupon(String id) {
		 return sqlSession.selectList("customer.customerCoupon",id);
	 }
	 
	 public StoreDTO viewStore(int storeid) {
		 return sqlSession.selectOne("customer.viewStore",storeid);
	 }
	 
	 public List<ViewStoreDTO> viewStoreInfo(int storeid) {
		 return sqlSession.selectList("customer.viewStoreInfo", storeid);
	 }
}