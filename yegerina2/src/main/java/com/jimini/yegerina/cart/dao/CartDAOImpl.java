package com.jimini.yegerina.cart.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.jimini.yegerina.cart.vo.CartVO;
import com.jimini.yegerina.goods.vo.GoodsVO;

@Repository("cartDAO")
public class CartDAOImpl implements  CartDAO {

	@Autowired
	private SqlSession sqlSession;
	
	
	
	
	// 장바구니 목록정보
	@Override
	public List<CartVO> selectCartList(CartVO cartVO) throws DataAccessException {
		System.out.println(cartVO + " : 카트 DAO에 들어온 cartVO정보");		
		List<CartVO> cartList =(List)sqlSession.selectList("mapper.cart.selectCartList",cartVO);
		return cartList;
	}

	
	
	
	// 장바구니 상품조회
	@Override
	public List<GoodsVO> selectGoodsList(List<CartVO> cartList) throws DataAccessException {
		
		List<GoodsVO> myGoodsList;
		myGoodsList = sqlSession.selectList("mapper.cart.selectGoodsList",cartList);
		return myGoodsList;
	}

	
	
	//카트 등록전에 이미 등록된 제품인지 판별
	@Override
	public boolean selectCountInCart(CartVO cartVO) throws DataAccessException {
		String  result =sqlSession.selectOne("mapper.cart.selectCountInCart",cartVO);
		System.out.println(result + " : selectCountInCart의 result정보" );
		
		return Boolean.parseBoolean(result);
	}

	
	
	
	//장바구니 상품 추가
	@Override
	public void insertGoodsInCart(CartVO cartVO) throws DataAccessException {
		
		// 장바구니 아이디 생성
		int cart_id=selectMaxCartId();
		
		cartVO.setCartId(cart_id);
		sqlSession.insert("mapper.cart.insertGoodsInCart",cartVO);
		
	}

	@Override
	public void updateCartGoodsQty(CartVO cartVO) throws DataAccessException {
		// TODO Auto-generated method stub
		
	}

	
	
	
	// 장바구니 삭제
	@Override
	public void deleteCartGoods(int cartId) throws DataAccessException {
		sqlSession.delete("mapper.cart.deleteCartGoods",cartId);
		
	}
	
	
	
	
	// 장바구니 아이디 생성메서드
	private int selectMaxCartId() throws DataAccessException{
		int cartId =sqlSession.selectOne("mapper.cart.selectMaxCartId");
		return cartId;
	}

}
