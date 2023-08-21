package com.jimini.yegerina.goods.controller;

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
import org.springframework.web.servlet.ModelAndView;

import com.jimini.yegerina.common.base.BaseController;
import com.jimini.yegerina.goods.service.GoodsService;
import com.jimini.yegerina.goods.vo.GoodsVO;

import net.sf.json.JSONObject;


@Controller("goodsController")
@RequestMapping(value="/goods")
public class GoodsControllerImpl extends BaseController implements GoodsController  {

	@Autowired
	private GoodsService goodsService;
	

	//리스트페이지
	@Override
	@RequestMapping(value="menuGoods.do" ,method = RequestMethod.GET)
	public ModelAndView menuGoods(String menuGoods, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		List<GoodsVO> goodsList=goodsService.menuGoods(menuGoods);
		ModelAndView mav = new ModelAndView(viewName);
		//추출한 데이터와 카테고리명을 매핑하여 return.
		mav.addObject("goodsList", goodsList);
		mav.addObject("menuGoods", menuGoods);
		return mav;
	}

	//리스트페이지
	@Override
	@RequestMapping(value="menuGoodsitem.do" ,method = RequestMethod.GET)
	public ModelAndView menuGoodsitem(String menuGoodsitem, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.out.println(menuGoodsitem + " : 받아온 상품 상세 카테고리");
		String viewName=(String)request.getAttribute("viewName");
		List<GoodsVO> goodsList=goodsService.menuGoodsitem(menuGoodsitem);
		ModelAndView mav = new ModelAndView(viewName);
		//추출한 데이터와 카테고리명을 매핑하여 return.
		mav.addObject("goodsList", goodsList);
		mav.addObject("menuGoods", menuGoodsitem);
		return mav;
	}
	
	
	
	
	
	// 상품 상세 페이지
	@RequestMapping(value="/goodsDetail.do" ,method = RequestMethod.GET)
	public ModelAndView goodsDetail(@RequestParam("goods_id") String goods_id, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		System.out.println(goods_id + " : 받아온 goodsDetail아이디 정보");
		String viewName=(String)request.getAttribute("viewName");
//		HttpSession session=request.getSession();
		Map goodsMap=goodsService.goodsDetail(goods_id);
		
		
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("goodsMap", goodsMap);
//		GoodsVO goodsVO=(GoodsVO)goodsMap.get("goodsVO");
		return mav;
	}

	
	

	// 자동완성
	@Override
	@RequestMapping(value="/keywordSearch.do",method = RequestMethod.GET,produces = "application/text; charset=utf8")
	// produces : 요청을 처리한 결과를 어떤 미디어 타입으로 반환할 것인지 설정, 클라이언트에게 전달되는 응답의 미디어 타입을 설정하는 역할
	// application/text; charset=utf8 - text/plain미디어 타입
	// charset -  UTF-8 문자 인코딩을 사용하도록 지정
	public String keywordSearch(@RequestParam("keyword") String keyword, HttpServletRequest request, HttpServletResponse response)
	// 검색 결과가 HTML 페이지로 표시되어야 할 때는 @ResponseBody를 사용하지 않아도됌.
			throws Exception {
//		response.setContentType("text/html;charset=utf-8");
//		response.setCharacterEncoding("utf-8");
		System.out.println(keyword);
		
		
		if(keyword == null || keyword.equals(""))
		   return null ;
	
		keyword = keyword.toUpperCase();
		// toUpperCase() - 문자열을 모두 대문자로 변환하는 역할
	    List<String> keywordList =goodsService.keywordSearch(keyword);
	    
	 // 최종 완성될 JSONObject 선언(전체)
		JSONObject jsonObject = new JSONObject();
		// Java에서 JSON 데이터를 다루기 위해 JSON-java 라이브러리에서 제공하는 클래스
		// JSON 객체를 생성
		// JSON은 데이터를 효율적으로 교환하기 위한 경량 데이터 형식으로 많은 웹 및 애플리케이션에서 사용
		
		jsonObject.put("keyword", keywordList);
		 		
	    String jsonInfo = jsonObject.toString();
	    System.out.println(jsonInfo);
	    return jsonInfo ;

	}

	
	//검색을 눌렀을때 검색되는 경로
	@Override
	@RequestMapping(value="/searchGoods.do" ,method = RequestMethod.GET)
	public ModelAndView searchGoods(@RequestParam("searchWord") String searchWord, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String viewName=(String)request.getAttribute("viewName");
		
		System.out.println(searchWord + " : searchGoods에서 받아온 searchWord");
		
		List<GoodsVO> goodsList=goodsService.searchGoods(searchWord);
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("searchWord",searchWord);
		mav.addObject("goodsList", goodsList);
		return mav;
	}

}
