package com.jimini.yegerina.main;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.jimini.yegerina.common.base.BaseController;
import com.jimini.yegerina.goods.service.GoodsService;
import com.jimini.yegerina.goods.vo.GoodsVO;

@Controller("mainController")
@EnableAspectJAutoProxy
// AspectJ를 활용한 AOP(Aspect-Oriented Programming)를 자동으로 활성화하기 위한 어노테이션
// AOP는 프로그래밍에서 공통 관심사(Cross-cutting Concerns)를 모듈화하고 코드의 재사용성과 유지 보수성을 향상시키기 위한 패러다임
// 자동으로 AspectJ 프록시를 생성하고 AOP를 적용하는데 필요한 설정을 수행
// @Aspect 어노테이션이 지정된 클래스가 감지되어 Aspect로 등록되며, 해당 Aspect 클래스에 정의된 어드바이스(Advice)들이 적용
// Spring에서 AOP를 활용하려는 경우 꼭 사용해야 하는 중요한 설정 
public class MainController extends BaseController {
	
	@Autowired
	private GoodsService goodsService;
	
	//메인페이지
	@RequestMapping(value = "/main/main.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response)throws Exception {
		
		HttpSession session;
		ModelAndView mav = new ModelAndView();
		String viewName = (String) request.getAttribute("viewName");
		mav.setViewName(viewName);
		
		
		session=request.getSession();
//		session.setAttribute("side_menu", "user");
		Map<String,List<GoodsVO>> goodsMap=goodsService.listGoods();
		// 주입받은 goodsService를 사용하여 그안에 있는 listGoods메서드를 사용.
		mav.addObject("goodsMap", goodsMap);
		// goodsMap(KEY)에 goodsMap(value)-변수 값을 modelAndView객체에 추가
		// JSP에서 데이터를 사용하기 위해 mav에 추가 - 표현언어를 사용하여 데이터를 추출 가능
		
		
		return mav;
	}
	
}
