package com.jimini.yegerina.goods.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.jimini.yegerina.goods.dao.GoodsDAO;
import com.jimini.yegerina.goods.vo.GoodsVO;
import com.jimini.yegerina.goods.vo.ImageFileVO;

@Service("goodsService")
@Transactional(propagation=Propagation.REQUIRED)
public class GoodsServiceImpl implements GoodsService{

	@Autowired
	private GoodsDAO goodsDAO;
	
	
	
	
	// 상품 리스트 나열
	@Override
	public Map<String, List<GoodsVO>> listGoods() throws Exception {

		Map<String,List<GoodsVO>> goodsMap=new HashMap<String,List<GoodsVO>>();
		
		
		List<GoodsVO> goodsList=goodsDAO.selectGoodsList("best20");
		goodsMap.put("BEST_20",goodsList);
		// best20이라는 문자열을 찾아서 goodsList에 모든 best20을 담아 BEST_20이라는 KEY값의 value로 Map으로 저장.
		
		System.out.println(goodsMap.toString() + " : 받아온 best20list");
		
		goodsList=goodsDAO.selectGoodsListnewItem("newItem");
		goodsMap.put("NEW_ITEM",goodsList);
		// newItem이라는 문자열을 찾아서 goodsList에 모든 newItem을 담아 NEW_ITEM이라는 KEY값의 value로 Map으로 저장.
		System.out.println(goodsMap.toString() + " : 받아온 NEW_ITEMlist");
		
		return goodsMap;
	}


	// 카테고리별
	@Override
	public List<GoodsVO> menuGoods(String menuGoods) throws Exception {
		List goodsList = goodsDAO.selectGoodsByMenuGoods(menuGoods);
		return goodsList;
	}

	// 카테고리별아이템
	@Override
	public List<GoodsVO> menuGoodsitem(String menuGoodsitem) throws Exception {
		List goodsList = goodsDAO.selectGoodsByMenuGoodsitem(menuGoodsitem);
		return goodsList;
	}
	
	
	
	
	
	// 상품 상세 페이지
	@Override
	public Map goodsDetail(String goods_id) throws Exception {
		// goodsController에서 godsDetail을 호출하면 goods_id를 가지고 넘어와서 
		// selectGoodsDetail과 selectGoodsDetailImage의 정보를 가지고 반환.
		System.out.println(goods_id + " : 서비스로 넘어온 goodsDetail id정보");
		
		Map goodsMap=new HashMap();
		GoodsVO goodsVO = goodsDAO.selectGoodsDetail(goods_id);
		goodsMap.put("goodsVO", goodsVO);
		
		List<ImageFileVO> imageList =goodsDAO.selectGoodsDetailImage(goods_id);
		goodsMap.put("imageList", imageList);
		System.out.println(imageList + " : 쿼리문에서 받아온 selectGoodsDetailImage");
		return goodsMap;
		
	}

	
	
	
	
	@Override
	public List<String> keywordSearch(String keyword) throws Exception {
		
		List<String> list=goodsDAO.selectKeywordSearch(keyword);
		
		System.out.println(list + " : keyword서치리스트");
		
		return list;
	}

	@Override
	public List<GoodsVO> searchGoods(String searchWord) throws Exception {
		List goodsList=goodsDAO.selectGoodsBySearchWord(searchWord);
		return goodsList;
	}

}
