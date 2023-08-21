package com.jimini.yegerina.order.service;

import java.util.List;

import com.jimini.yegerina.order.vo.OrderVO;

public interface OrderService {
	public void addNewOrder(List<OrderVO> myOrderList) throws Exception;
	
	
}
