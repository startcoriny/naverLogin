package com.jimini.yegerina.mypage.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface MyPageController {
	
	public ModelAndView myPageMain(@RequestParam(required = false,value="message")  String message,HttpServletRequest request, HttpServletResponse response)  throws Exception ;
	public ModelAndView myOrderDetail(@RequestParam("order_id")  String order_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView cancelMyOrder(@RequestParam("order_id")  String order_id,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView listMyOrderHistory(@RequestParam Map<String, String> dateMap,HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ModelAndView myDetailInfo(HttpServletRequest request, HttpServletResponse response)  throws Exception;
	public ResponseEntity modifyMyInfo(String member_pw, String hp1, String zipcode, String member_address, String subaddress,
			HttpServletRequest request, HttpServletResponse response) throws Exception;
	ModelAndView returnMyOrder(String order_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception;
	ModelAndView exchangeMyOrder(String order_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception;
	ResponseEntity deleteMember(String member_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception;
	
}
