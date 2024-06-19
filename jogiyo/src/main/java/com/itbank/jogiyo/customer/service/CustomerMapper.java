package com.itbank.jogiyo.customer.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.itbank.jogiyo.dto.CategoryDTO;
import com.itbank.jogiyo.dto.CouponDTO;
import com.itbank.jogiyo.dto.LoginDTO;
import com.itbank.jogiyo.dto.MenuDTO;
import com.itbank.jogiyo.dto.OrderDTO;
import com.itbank.jogiyo.dto.StoreDTO;
import com.itbank.jogiyo.dto.ViewCateStoreDTO;
import com.itbank.jogiyo.dto.ViewStoreDTO;

@Service
public class CustomerMapper {
	@Autowired
	private SqlSession sqlSession;
	private final PasswordEncoder bcryptPasswordEncoder;
	
	public CustomerMapper(PasswordEncoder bcryptPasswordEncoder) {
		this.bcryptPasswordEncoder = bcryptPasswordEncoder;
	}
	
	public LoginDTO cMypageList(String id) {
		return sqlSession.selectOne("customer.cMypageList", id);
	}

	public int updateCustomer(LoginDTO dto) {
		dto.setPasswd(bcryptPasswordEncoder.encode(dto.getPasswd()));
		return sqlSession.update("customer.updateCustomer", dto);

	}

	public int secessionCustomer(String id) {
		return sqlSession.delete("customer.secessionCustomer", id);
	}

	public List<OrderDTO> pastOrder(String id) {
		return sqlSession.selectList("customer.pastOrderList", id);
	}

	public List<CouponDTO> customerCoupon(String id) {
		return sqlSession.selectList("customer.customerCoupon", id);
	}

	public StoreDTO viewStore(int storeid) {
		return sqlSession.selectOne("customer.viewStore", storeid);
	}

	public List<ViewStoreDTO> viewStoreInfo(int storeid) {
		return sqlSession.selectList("customer.viewStoreInfo", storeid);
	}

	public List<StoreDTO> storeList() {
		return sqlSession.selectList("customer.storeList");
	}

	public List<CategoryDTO> cateList() {
		return sqlSession.selectList("customer.cateList");
	}
	
	public List<StoreDTO> cateStoreList(String sel){
	       return sqlSession.selectList("customer.cateStoreList", sel);
	}
	public List<MenuDTO> basketList(String menuid){
	       String str = menuid;
	          String[] arr = str.split(",");
	          List<Integer> menuIds = new ArrayList<>();
	          for (String cut : arr) {
	             System.out.println(cut.trim());
	             menuIds.add(Integer.parseInt(cut));
	          }
	          // MyBatis 쿼리에 List<Integer>를 전달하여 결과 반환
	          return sqlSession.selectList("customer.basketList", menuIds);
	      }
}