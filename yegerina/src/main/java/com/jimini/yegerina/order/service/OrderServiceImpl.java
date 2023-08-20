package com.jimini.yegerina.order.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jimini.yegerina.order.dao.OrderDAO;
import com.jimini.yegerina.order.vo.OrderVO;

@Service("orderService")
@Transactional(propagation=Propagation.REQUIRED)
public class OrderServiceImpl implements OrderService {
	@Autowired
	private OrderDAO orderDAO;

	// 결제
	public void addNewOrder(List<OrderVO> myOrderList) throws Exception{
		//주문 상품 주가.
		orderDAO.insertNewOrder(myOrderList);
		
		//카트에서 주문 상품추가 후 제거한다.
		orderDAO.removeGoodsFromCart(myOrderList);
	}	

}
