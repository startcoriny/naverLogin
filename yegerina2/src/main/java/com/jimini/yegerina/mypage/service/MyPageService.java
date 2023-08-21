package com.jimini.yegerina.mypage.service;

import java.util.List;
import java.util.Map;

import com.jimini.yegerina.member.vo.MemberVO;
import com.jimini.yegerina.order.vo.OrderVO;

public interface MyPageService {
	public List<OrderVO> listMyOrderGoods(String member_id) throws Exception;
	public List findMyOrderInfo(String order_id) throws Exception;
	public List<OrderVO> listMyOrderHistory(Map dateMap) throws Exception;
	public MemberVO  modifyMyInfo(Map memberMap) throws Exception;
	public void cancelOrder(String order_id) throws Exception;
	public MemberVO myDetailInfo(String member_id) throws Exception;
	public void returnOrder(String order_id) throws Exception;
	public void exchangeOrder(String order_id) throws Exception;
	void deleteMember(String memberId) throws Exception;
}
