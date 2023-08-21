package com.jimini.yegerina.mypage.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.jimini.yegerina.member.vo.MemberVO;
import com.jimini.yegerina.order.vo.OrderVO;

@Repository("myPageDAO")
public class MyPageDAOImpl implements MyPageDAO{
	@Autowired
	private SqlSession sqlSession;

	public List<OrderVO> selectMyOrderGoodsList(String member_id) throws DataAccessException{
		List<OrderVO> orderGoodsList=(List)sqlSession.selectList("mapper.mypage.selectMyOrderGoodsList",member_id);
		return orderGoodsList;
	}

	@Override
	public List selectMyOrderInfo(String order_id) throws DataAccessException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<OrderVO> selectMyOrderHistoryList(Map dateMap) throws DataAccessException {
		List<OrderVO> myOrderHistList=(List)sqlSession.selectList("mapper.mypage.selectMyOrderHistoryList",dateMap);
		return myOrderHistList;
	}

	@Override
	public void updateMyInfo(Map memberMap) throws DataAccessException {
		System.out.println(memberMap.get("memberId") + " : DAO로 넘어온 MEMBERid");
		sqlSession.update("mapper.mypage.updateMyInfo",memberMap);
		
	}

	@Override
	public MemberVO selectMyDetailInfo(String member_id) throws DataAccessException {
		MemberVO memberVO=(MemberVO)sqlSession.selectOne("mapper.mypage.selectMyDetailInfo",member_id);
		System.out.println(memberVO.getHp1() + " : 수정하기 반영된 전화번호");
		return memberVO;
	}

	@Override
	public void updateMyOrderCancel(String orderId) throws DataAccessException {
		sqlSession.update("mapper.mypage.updateMyOrderCancel",orderId);
		
	}
	
	//반품
	public void updateMyOrderReturn(String orderId) throws DataAccessException{
		sqlSession.update("mapper.mypage.updateMyOrderReturn",orderId);
	}
	
	//교환
	public void updateMyOrderExchange(String orderId) throws DataAccessException{
		sqlSession.update("mapper.mypage.updateMyOrderExchange",orderId);
	}	
	
	
	@Override
	public void deleteMember(String memberId) throws DataAccessException {
		sqlSession.delete("mapper.mypage.deleteMembercart",memberId);
		sqlSession.delete("mapper.mypage.deleteMemberorder",memberId);
		sqlSession.delete("mapper.mypage.deleteMember",memberId);
	}

}
