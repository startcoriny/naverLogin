package com.jimini.yegerina.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.jimini.yegerina.common.base.BaseController;
import com.jimini.yegerina.member.vo.MemberVO;
import com.jimini.yegerina.mypage.service.MyPageService;
import com.jimini.yegerina.order.vo.OrderVO;

@Controller("myPageController")
@RequestMapping(value="/mypage")
public class MyPageControllerImpl extends BaseController  implements MyPageController{
	@Autowired
	private MyPageService myPageService;
	
	@Autowired
	private MemberVO memberVO;

	
	
	@Override
	@RequestMapping(value="/myPageForm.do" ,method = RequestMethod.GET)
	public ModelAndView myPageMain(@RequestParam(required = false,value="message")  String message,
			   HttpServletRequest request, HttpServletResponse response)  throws Exception {
		HttpSession session=request.getSession();
		session=request.getSession();
		session.setAttribute("side_menu", "my_page"); //마이페이지 사이드 메뉴로 설정한다.
		
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String member_id=memberVO.getMemberId();
		
		List<OrderVO> myOrderList=myPageService.listMyOrderGoods(member_id);
		
		mav.addObject("message", message);
		mav.addObject("myOrderList", myOrderList);

		return mav;
	}

	@Override
	public ModelAndView myOrderDetail(String order_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@RequestMapping(value="/cancelMyOrder.do" ,method = RequestMethod.POST)
	public ModelAndView cancelMyOrder(@RequestParam("orderId")  String orderId,
			                         HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		myPageService.cancelOrder(orderId);
		mav.addObject("message", "cancel_order");
		mav.setViewName("redirect:/mypage/listMyOrderHistory.do");
		return mav;
	}

	
	//반품

	@RequestMapping(value="/returnMyOrder.do" ,method = RequestMethod.POST)
	public ModelAndView returnMyOrder(@RequestParam("orderId")  String orderId,
			                         HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		//주문 id order_id로 db삭제 후 returning_goods message 리턴
		myPageService.returnOrder(orderId);
		mav.addObject("message", "returning_goods");
		mav.setViewName("redirect:/mypage/listMyOrderHistory.do");
		return mav;
	}
	
	
	//교환
	@RequestMapping(value="/exchangeMyOrder.do" ,method = RequestMethod.POST)
	public ModelAndView exchangeMyOrder(@RequestParam("orderId")  String orderId,
			                         HttpServletRequest request, HttpServletResponse response)  throws Exception {
		ModelAndView mav = new ModelAndView();
		//주문 id order_id로 db삭제 후 exchange_goods message 리턴
		myPageService.exchangeOrder(orderId);
		mav.addObject("message", "exchange_goods");
		mav.setViewName("redirect:/mypage/listMyOrderHistory.do");
		return mav;
	}
	
	
	
	
	@Override
	@RequestMapping(value="/listMyOrderHistory.do" ,method = RequestMethod.GET)
	public ModelAndView listMyOrderHistory(@RequestParam Map<String, String> dateMap,
			                               HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String  memberId=memberVO.getMemberId();
		
		String fixedSearchPeriod = dateMap.get("fixedSearchPeriod");
		String beginDate=null,endDate=null;
		
		String [] tempDate=calcSearchPeriod(fixedSearchPeriod).split(",");
		beginDate=tempDate[0];
		endDate=tempDate[1];
		dateMap.put("beginDate", beginDate);
		dateMap.put("endDate", endDate);
		dateMap.put("memberId", memberId);
		List<OrderVO> myOrderHistList=myPageService.listMyOrderHistory(dateMap);
		System.out.println(myOrderHistList.toString() + " : 받아온 주문리스트목록들 정보");
		
		String beginDate1[]=beginDate.split("-"); //검색일자를 년,월,일로 분리해서 화면에 전달합니다.
		String endDate1[]=endDate.split("-");
		mav.addObject("beginYear",beginDate1[0]);
		mav.addObject("beginMonth",beginDate1[1]);
		mav.addObject("beginDay",beginDate1[2]);
		mav.addObject("endYear",endDate1[0]);
		mav.addObject("endMonth",endDate1[1]);
		mav.addObject("endDay",endDate1[2]);
		mav.addObject("myOrderHistList", myOrderHistList);
		return mav;
	}	

	@RequestMapping(value="/myDetailInfo.do" ,method = RequestMethod.GET)
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}	

	@Override
	@RequestMapping(value="/modifyMyInfo.do" ,method = RequestMethod.POST)
	public ResponseEntity modifyMyInfo(
			@RequestParam("memberPw")  String memberPw,
			@RequestParam("hp1")  String hp1,
			@RequestParam("zipcode")  String zipcode,
			@RequestParam("address")  String address,
			@RequestParam("subaddress")  String subaddress,
			               HttpServletRequest request, HttpServletResponse response)  throws Exception {
		Map<String,String> memberMap=new HashMap<String,String>();
		
		HttpSession session=request.getSession();
		memberVO=(MemberVO)session.getAttribute("memberInfo");
		String  memberId=memberVO.getMemberId();
		
		//받아온 정보 memberMap에 put
		memberMap.put("memberPw",memberPw);
		memberMap.put("hp1",hp1);
		memberMap.put("zipcode",zipcode);
		memberMap.put("address",address);
		memberMap.put("subaddress",subaddress);
		memberMap.put("memberId", memberId);
		
		//memberMap을 가지고 db수정
		memberVO=(MemberVO)myPageService.modifyMyInfo(memberMap);
		
		//수정된 회원 정보를 다시 세션에 저장한다.
		session.removeAttribute("memberInfo");
		session.setAttribute("memberInfo", memberVO);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		
		//완료후 message mod_success 리턴
		message  = "mod_success";
		resEntity =new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		return resEntity;
	}	
	
	
	
	@Override
	@RequestMapping(value = "/deleteMember.do",method = RequestMethod.POST)
	public ResponseEntity deleteMember(@RequestParam("memberId") String memberId, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		myPageService.deleteMember(memberId);
		
		String message = null;
		ResponseEntity resEntity = null;
		HttpHeaders responHeaders = new HttpHeaders();
		
		message = "delete_success";
		resEntity = new ResponseEntity(message,responHeaders,HttpStatus.OK);
		return resEntity;
	}

	
}
