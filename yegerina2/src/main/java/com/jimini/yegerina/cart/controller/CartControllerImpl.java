package com.jimini.yegerina.cart.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.jimini.yegerina.cart.service.CartService;
import com.jimini.yegerina.cart.vo.CartVO;
import com.jimini.yegerina.common.base.BaseController;
import com.jimini.yegerina.member.vo.MemberVO;

@Controller("cartController")
@RequestMapping(value="/cart")
public class CartControllerImpl extends BaseController implements CartController{
	
	@Autowired
	private CartService cartService;
	@Autowired
	private CartVO cartVO;
	@Autowired
	private MemberVO memberVO;
		
	
	// 장바구니 목록 조회
	@RequestMapping(value="/myCartList.do" ,method = RequestMethod.GET)
	public ModelAndView myCartMain(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");
		System.out.println(memberVO + " : session에 들어간 memberInfo정보");
		
		String member_id=memberVO.getMemberId();
		cartVO.setMemberId(member_id);
		System.out.println(memberVO.getMemberId() + " : cartVO에 들어간 getMemberId()정보");
		
		Map<String ,List> cartMap=cartService.myCartList(cartVO);	
		session.setAttribute("cartMap", cartMap);
		//장바구니 목록 화면에서 상품 주문 시 사용하기 위해서 장바구니 목록을 세션에 저장.
		return mav;
	}

	
	
	
	// 상품 추가
	@RequestMapping(value="/addGoodsInCart.do" ,method = RequestMethod.POST,produces = "application/text; charset=utf8")
	public  @ResponseBody String addGoodsInCart(@RequestParam("goods_id") int goodsId,
	// @ResponseBody - JSON 형태의 응답 데이터를 생성하여 클라이언트에게 반환
												@RequestParam("cart_goods_qty") int cart_goods_qty,
			                    HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		System.out.println(goodsId + " : 받아온 장바구니 상품 id");
		System.out.println(cart_goods_qty + " : 받아온 장바구니 상품 cart_goods_qty");
		
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		//세션에서 memberInfo라는 이름으로 저장된 회원 정보 객체(MemberVO)를 가져옴
		String memberId=memberVO.getMemberId();
		System.out.println(memberId + " : 장바구니누른 회원 아이디");
		
		cartVO.setMemberId(memberId);
		cartVO.setGoodsId(goodsId);
		cartVO.setMemberId(memberId);
		cartVO.setCartGoodsQty(cart_goods_qty);
		
		
		System.out.println(cartVO.toString()+ " : cartVO에 들어간 제품정보");
		
		boolean isAreadyExisted=cartService.findCartGoods(cartVO);
		//카트 등록전에 이미 등록된 제품인지 판별
		System.out.println("isAreadyExisted정보 : "+isAreadyExisted);
		
		// 상품이 존재 할때
		if(isAreadyExisted==true){
			return "already_existed";
		// 상품이 존재하지 않을때
		}else{
			cartService.addGoodsInCart(cartVO);
			return "add_success";
		}	
	}

	
	
	
	
	@Override
	public String modifyCartQty(int goods_id, int cart_goods_qty, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	
	
	
	// 장바구니 상품 삭제
	@RequestMapping(value="/removeCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView removeCartGoods(@RequestParam("cart_id") int cart_id,
            HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		ModelAndView mav=new ModelAndView();
		cartService.removeCartGoods(cart_id);
		mav.setViewName("redirect:/cart/myCartList.do");		
		return mav;
	}

}
