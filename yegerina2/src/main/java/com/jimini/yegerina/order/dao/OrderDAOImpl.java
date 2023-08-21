package com.jimini.yegerina.order.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.jimini.yegerina.order.vo.OrderVO;

@Repository("orderDAO")
public class OrderDAOImpl implements OrderDAO {
	@Autowired
	private SqlSession sqlSession;

	
	
	
	// 결제하기
	public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException{
		int order_id=selectOrderID();
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO =(OrderVO)myOrderList.get(i);
			orderVO.setOrderId(order_id);
			sqlSession.insert("mapper.order.insertNewOrder",orderVO);
		}
		
	}

	
	
	
	// 주문번호 생성
	private int selectOrderID() {
		return sqlSession.selectOne("mapper.order.selectOrderID");
	}
	
	
	
	
	// 카트목록 삭제
	public void removeGoodsFromCart(OrderVO orderVO)throws DataAccessException{
		sqlSession.delete("mapper.order.deleteGoodsFromCart",orderVO);
	}
	
	
	
	
	// 카트목록 삭제
	public void removeGoodsFromCart(List<OrderVO> myOrderList)throws DataAccessException{
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO =(OrderVO)myOrderList.get(i);
			sqlSession.delete("mapper.order.deleteGoodsFromCart",orderVO);		
		}
	}
}
