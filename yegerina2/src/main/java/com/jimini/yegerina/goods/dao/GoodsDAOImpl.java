package com.jimini.yegerina.goods.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.jimini.yegerina.goods.vo.GoodsVO;
import com.jimini.yegerina.goods.vo.ImageFileVO;

@Repository("goodsDAO")
public class GoodsDAOImpl  implements GoodsDAO{

	@Autowired
	private SqlSession sqlSession;

	
	
	
	// 상품 리스트 정보
	@Override
	public List<GoodsVO> selectGoodsList(String goodsStatus) throws DataAccessException {
		System.out.println(goodsStatus + " : 받아온 상품분류");
		List<GoodsVO> goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsList",goodsStatus);
		System.out.println(goodsList + " : 가져온 상품 정보 및 이미지");		
		return goodsList;
	}

	// 상품 리스트 정보
	@Override
	public List<GoodsVO> selectGoodsListnewItem(String goodsStatus) throws DataAccessException {
		System.out.println(goodsStatus + " : 받아온 상품분류");
		List<GoodsVO> goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsList_newItem",goodsStatus);
		System.out.println(goodsList + " : 가져온 상품 정보 및 이미지");		
		return goodsList;
	}

	
	
	
	
	// 카테고리별
	@Override
	public List<GoodsVO> selectGoodsByMenuGoods(String menuGoods) throws DataAccessException {
		ArrayList goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsByMenuGoods",menuGoods);
		 return goodsList;
	}	
	
	// 카테고리별아이템
	@Override
	public List<GoodsVO> selectGoodsByMenuGoodsitem(String menuGoodsitem) throws DataAccessException {
		ArrayList goodsList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsByMenuGoodsitem",menuGoodsitem);
		return goodsList;
	}	
	
	
	// 상품 상세 페이지
	@Override
	public GoodsVO selectGoodsDetail(String goods_id) throws DataAccessException {
		
		System.out.println(goods_id + " : dao로 넘어온 Goodsdetail 아이디 정보");
		
		GoodsVO goodsVO=(GoodsVO)sqlSession.selectOne("mapper.goods.selectGoodsDetail",goods_id);
		// 해당 상품의 정보를 가져옴.
		System.out.println(goodsVO + " : 쿼리문 돌아서 dao로 넘어온 Goodsdetail 아이디 정보");
		
		return goodsVO;
		
	}

	
	
	
	// 상세페이지 디테일 이미지 가져오기
	@Override
	public List<ImageFileVO> selectGoodsDetailImage(String goods_id) throws DataAccessException {
		System.out.println(goods_id + " : dao로 넘어온 GoodsdetailImage 아이디 정보");
		List<ImageFileVO> imageList=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsDetailImage",goods_id);
		// 해당 상품의 이미지 정보를 가져옴.
		return imageList;
	}
	
	
	
	
	@Override
	public List<String> selectKeywordSearch(String keyword) throws DataAccessException {
		   List<String> list=(ArrayList)sqlSession.selectList("mapper.goods.selectKeywordSearch",keyword);
		   return list;
	}


	
	
	@Override
	public List<GoodsVO> selectGoodsBySearchWord(String searchWord) throws DataAccessException {
		ArrayList list=(ArrayList)sqlSession.selectList("mapper.goods.selectGoodsBySearchWord",searchWord);
		 return list;
	}
	
	
	
	
	
}
