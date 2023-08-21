package com.jimini.yegerina.order.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jimini.yegerina.common.base.BaseController;
import com.jimini.yegerina.goods.vo.GoodsVO;
import com.jimini.yegerina.member.vo.MemberVO;
import com.jimini.yegerina.order.service.OrderService;
import com.jimini.yegerina.order.vo.OrderVO;

@Controller("orderController")
@RequestMapping(value="/order")
public class OrderControllerImpl extends BaseController implements OrderController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private OrderVO orderVO;
	
	
	// 단일 상품 주문 결제정보창
	@RequestMapping(value="/orderEachGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderEachGoods(@ModelAttribute("orderVO") OrderVO _orderVO,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{
		
		request.setCharacterEncoding("utf-8");
		HttpSession session=request.getSession();
		session=request.getSession();
		System.out.println(orderVO + " : 받아온 주문 정보");
		System.out.println(orderVO.getGoodsTitle()+ " : 받아온 주문상품 이름");
		System.out.println(orderVO.getGoodsSalesPrice() + " : 받아온 주문상품 가격");
		System.out.println(orderVO.getOrderGoodsQty() + " : 받아온 주문상품 갯수");
		
		
		
		Boolean isLogOn=(Boolean)session.getAttribute("isLogOn");
		String action=(String)session.getAttribute("action");
		
		
		//로그인 여부 체크
		//이전에 로그인 상태인 경우는 주문과정 진행
		//로그아웃 상태인 경우 로그인 화면으로 이동한뒤 로그인하고나서 action에 있는 경로로 이동
		if(isLogOn==null || isLogOn==false){
			session.setAttribute("orderInfo", _orderVO);
			session.setAttribute("action", "/order/orderEachGoods.do");
			return new ModelAndView("redirect:/member/loginForm.do");
		}else{
			 if(action!=null && action.equals("/order/orderEachGoods.do")){
				orderVO=(OrderVO)session.getAttribute("orderInfo");
				session.removeAttribute("action");
			 }else {
				 orderVO=_orderVO;
			 }
		 }
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		List<OrderVO> myOrderList=new ArrayList<OrderVO>();
		myOrderList.add(orderVO);

		MemberVO memberInfo=(MemberVO)session.getAttribute("memberInfo");
		
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberInfo);
		return mav;
	}
	
	
	
	
	
	
	@RequestMapping(value="/orderAllCartGoods.do" ,method = RequestMethod.POST)
	public ModelAndView orderAllCartGoods( @RequestParam("cart_goods_qty")  String[] cart_goods_qty,
			                 HttpServletRequest request, HttpServletResponse response)  throws Exception{
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		Map cartMap=(Map)session.getAttribute("cartMap");
		List myOrderList=new ArrayList<OrderVO>();
		
		List<GoodsVO> myGoodsList=(List<GoodsVO>)cartMap.get("myGoodsList");
		MemberVO memberVO=(MemberVO)session.getAttribute("memberInfo");		
		
		for(int i=0; i<cart_goods_qty.length;i++){
			String[] cart_goods=cart_goods_qty[i].split(":");
			for(int j = 0; j< myGoodsList.size();j++) {
				GoodsVO goodsVO = myGoodsList.get(j);
				int goods_id = goodsVO.getGoodsId();
				if(goods_id==Integer.parseInt(cart_goods[0])) {
					OrderVO _orderVO=new OrderVO();
					String goods_title=goodsVO.getGoodsTitle();
					int goods_sales_price=goodsVO.getGoodsSalesPrice();
					String goods_fileName=goodsVO.getGoodsFileName();
					_orderVO.setGoodsId(goods_id);
					_orderVO.setGoodsTitle(goods_title);
					_orderVO.setGoodsSalesPrice(goods_sales_price);
					_orderVO.setGoodsFileName(goods_fileName);
					_orderVO.setOrderGoodsQty(Integer.parseInt(cart_goods[1]));
					myOrderList.add(_orderVO);
					break;
				}
			}
		}
		session.setAttribute("myOrderList", myOrderList);
		session.setAttribute("orderer", memberVO);
		return mav;
	}
	
	
	
	// 최종 결제하기
	@RequestMapping(value= {"/payToOrderGoods.do","/orderGoodsForm.do"} ,method = RequestMethod.POST)
	public ModelAndView payToOrderGoods(@RequestParam Map<String, String> receiverMap,
			                       HttpServletRequest request, HttpServletResponse response)  throws Exception{

		String viewName=(String)request.getAttribute("viewName");
		System.out.println(receiverMap.toString() + " : 받아온 최종 결제 정보");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session=request.getSession();
		MemberVO memberVO=(MemberVO)session.getAttribute("orderer");
		String member_id=memberVO.getMemberId();
		String orderer_name=memberVO.getMemberName();
		String orderer_hp = memberVO.getHp1();
		List<OrderVO> myOrderList=(List<OrderVO>) session.getAttribute("myOrderList");		
		
		
		for(int i=0; i<myOrderList.size();i++){
			OrderVO orderVO=(OrderVO)myOrderList.get(i);
			orderVO.setMemberId(member_id);
			orderVO.setReceiver_name(receiverMap.get("receiver_name"));
			
			orderVO.setReceiver_hp1(receiverMap.get("receiver_hp1"));
			
			orderVO.setDelivery_address(receiverMap.get("delivery_address"));
			orderVO.setDelivery_message(receiverMap.get("delivery_message"));
			orderVO.setPay_method(receiverMap.get("pay_method"));
			orderVO.setCard_com_name(receiverMap.get("card_com_name"));
			orderVO.setCard_pay_month(receiverMap.get("card_pay_month"));
			orderVO.setPay_orderer_hp_num(receiverMap.get("pay_orderer_hp_num"));	
			orderVO.setOrderer_hp(orderer_hp);	
			myOrderList.set(i, orderVO); //각 orderVO에 주문자 정보를 세팅한 후 다시 myOrderList에 저장한다.
		}//end for
		
	    orderService.addNewOrder(myOrderList);
		mav.addObject("myOrderInfo",receiverMap);//OrderVO로 주문결과 페이지에  주문자 정보를 표시한다.
		mav.addObject("myOrderList", myOrderList);
		return mav;
	}
}
