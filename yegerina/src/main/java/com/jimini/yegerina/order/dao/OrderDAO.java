package com.jimini.yegerina.order.dao;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.jimini.yegerina.order.vo.OrderVO;

public interface OrderDAO {
	public void insertNewOrder(List<OrderVO> myOrderList) throws DataAccessException;
	public void removeGoodsFromCart(List<OrderVO> myOrderList)throws DataAccessException;
}

