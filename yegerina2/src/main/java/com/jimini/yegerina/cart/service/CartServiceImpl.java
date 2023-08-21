package com.jimini.yegerina.cart.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jimini.yegerina.cart.dao.CartDAO;
import com.jimini.yegerina.cart.vo.CartVO;
import com.jimini.yegerina.goods.vo.GoodsVO;

@Service("cartService")
@Transactional(propagation=Propagation.REQUIRED)
public class CartServiceImpl implements CartService {

	@Autowired
	private CartDAO cartDAO;
	
	// 장바구니 목록 정보
	@Override
	public Map<String, List> myCartList(CartVO cartVO) throws Exception {
		Map<String,List> cartMap=new HashMap<String,List>();
		
		System.out.println(cartVO + " : 컨트롤러에서 가져온 cartVO");
		System.out.println(cartVO.getMemberId() + " : 컨트롤러에서 가져온 cartVO멤버 아이디");
		
		List<CartVO> myCartList=cartDAO.selectCartList(cartVO);
		System.out.println(myCartList + " : myCartList에 들어있는 정보");
		
		if(myCartList.size()==0){ //카트에 저장된 상품이없는 경우 null반환
			return null;
		}
		
		// 장바구니 상품정보 
		List<GoodsVO> myGoodsList=cartDAO.selectGoodsList(myCartList);
		System.out.println(myGoodsList.toString() + " : myGoodsList에 들어있는 정보");
		cartMap.put("myCartList", myCartList);
		cartMap.put("myGoodsList",myGoodsList);
		return cartMap;
	}

	
	
	//카트 등록전에 이미 등록된 제품인지 판별
	public boolean findCartGoods(CartVO cartVO) throws Exception{
		
		System.out.println(cartVO + " : findCarteGoods에 들어온 cartVO");
		return cartDAO.selectCountInCart(cartVO);
		
	}

	
	
	
	// 장바구니에 상품 추가
	@Override
	public void addGoodsInCart(CartVO cartVO) throws Exception {
		cartDAO.insertGoodsInCart(cartVO);
		
	}

	@Override
	public boolean modifyCartQty(CartVO cartVO) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public void removeCartGoods(int cartId) throws Exception {
		cartDAO.deleteCartGoods(cartId);
		
	}

}
