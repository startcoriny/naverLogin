package com.jimini.yegerina.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.jimini.yegerina.member.vo.MemberVO;

public class ViewNameInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private SqlSession sqlSession;

	@Autowired
	private MemberVO memberVO;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {

		HttpSession session = request.getSession();

		try {
			memberVO = (MemberVO) session.getAttribute("memberInfo");
			String memberId = memberVO.getMemberId();
			System.out.println(memberId + " : 받아온 회원아이디");

			// 장바구니 갯수 카운트
			int cartCount = 0;
			cartCount = sqlSession.selectOne("mapper.counts.cartLen", memberId);
			System.out.println(cartCount + " : 장바구니 갯수@@@@@@@@@@@@@@@");
			session.setAttribute("cartCount", cartCount);

			// 결제완료 갯수 카운트
			int paycomplete = 0;
			paycomplete = sqlSession.selectOne("mapper.counts.paycompletelen", memberId);
			System.out.println(paycomplete + " : 결제완료 갯수@@@@@@@@@@@@@@@");
			session.setAttribute("paycomplete", paycomplete);
			
			// 배송중 개수 카운트
			int deliveringCount = 0;
			deliveringCount=sqlSession.selectOne("mapper.counts.deliveringLen",memberId);
			System.out.println(deliveringCount + " : 배송중 갯수@@@@@@@@@@@@@@@");
			session.setAttribute("deliveringCount", deliveringCount);
			
			
			// 구매확정 개수 카운트
			int Purchase_completed = 0;
			Purchase_completed=sqlSession.selectOne("mapper.counts.Purchase_completed",memberId);
			System.out.println(Purchase_completed + " : 구매확정 갯수@@@@@@@@@@@@@@@");
			session.setAttribute("Purchase_completed", Purchase_completed);
			
			
			
			
			if(memberId.equals("admin") == true) {
				int goodsLen = 0;
				goodsLen=sqlSession.selectOne("mapper.counts.goodsLen");
				session.setAttribute("goodsLen", goodsLen);
				
				int ordersLen = 0;
				ordersLen=sqlSession.selectOne("mapper.counts.ordersLen");
				session.setAttribute("ordersLen", ordersLen);
				
				int membersLen = 0;
				membersLen=sqlSession.selectOne("mapper.counts.membersLen");
				session.setAttribute("membersLen", membersLen);
				
				Long totalSales = 0L;
				totalSales=(Long)sqlSession.selectOne("mapper.counts.totalSales");
				session.setAttribute("totalSales", totalSales);
				
				
			}
			
		} catch (Exception e) {
		}
		try {
			String viewName = getViewName(request);
			request.setAttribute("viewName", viewName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	   @Override
	   public void postHandle(HttpServletRequest request, HttpServletResponse response,
	                           Object handler, ModelAndView modelAndView) throws Exception {
	   }

	   @Override
	   public void afterCompletion(HttpServletRequest request, HttpServletResponse response,
	                                    Object handler, Exception ex)    throws  Exception {
	   }
	   
	   private String getViewName(HttpServletRequest request) throws Exception {
			String contextPath = request.getContextPath();
			String uri = (String) request.getAttribute("javax.servlet.include.request_uri");
			if (uri == null || uri.trim().equals("")) {
				uri = request.getRequestURI();
			}

			int begin = 0;
			if (!((contextPath == null) || ("".equals(contextPath)))) {
				begin = contextPath.length();
			}

			int end;
			if (uri.indexOf(";") != -1) {
				end = uri.indexOf(";");
			} else if (uri.indexOf("?") != -1) {
				end = uri.indexOf("?");
			} else {
				end = uri.length();
			}

			String fileName = uri.substring(begin, end);
			if (fileName.indexOf(".") != -1) {
				fileName = fileName.substring(0, fileName.lastIndexOf("."));
			}
			if (fileName.lastIndexOf("/") != -1) {
				fileName = fileName.substring(fileName.lastIndexOf("/",1), fileName.length());
			}
			return fileName;
		}
	}