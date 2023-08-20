package com.jimini.yegerina.admin.goods.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import com.jimini.yegerina.goods.vo.GoodsVO;
import com.jimini.yegerina.goods.vo.ImageFileVO;
import com.jimini.yegerina.order.vo.OrderVO;

@Repository("adminGoodsDAO")
public class AdminGoodsDAOImpl implements AdminGoodsDAO {
	@Autowired
	private SqlSession sqlSession;

	
	
	@Override
	public List<GoodsVO> selectNewGoodsList(Map condMap) throws DataAccessException {
		ArrayList<GoodsVO> goodsList = (ArrayList) sqlSession.selectList("mapper.admin.goods.selectNewGoodsList", condMap);
		return goodsList;
	}
	
	
	
	
	
	@Override
	public int insertNewGoods(Map newGoodsMap) throws DataAccessException {
		System.out.println(newGoodsMap + " : 받아온 새로운상품정보DAO");
		sqlSession.insert("mapper.admin.goods.insertNewGoods", newGoodsMap);
		return Integer.parseInt((String) newGoodsMap.get("goodsId"));
	}

	
	
	
	
	
	@Override
	public void insertGoodsImageFile(List fileList) throws DataAccessException {
		for (int i = 0; i < fileList.size(); i++) {
			ImageFileVO imageFileVO = (ImageFileVO) fileList.get(i);
			sqlSession.insert("mapper.admin.goods.insertGoodsImageFile", imageFileVO);
		}
	}


	
	
	@Override
	public GoodsVO selectGoodsDetail(int goodsId) throws DataAccessException {
		GoodsVO goodsBean = new GoodsVO();
		goodsBean = (GoodsVO) sqlSession.selectOne("mapper.admin.goods.selectGoodsDetail", goodsId);
		return goodsBean;
	}

	
	
	
	
	
	
	
	@Override
	public List selectGoodsImageFileList(int goodsId) throws DataAccessException {
		List imageList = new ArrayList();
		imageList = (List) sqlSession.selectList("mapper.admin.goods.selectGoodsImageFileList", goodsId);
		return imageList;
	}

	
	
	
	
	
	
	@Override
	public List<OrderVO> selectOrderGoodsList(Map condMap) throws DataAccessException {
		List<OrderVO> orderGoodsList = (ArrayList) sqlSession.selectList("mapper.admin.selectOrderGoodsList", condMap);
		return orderGoodsList;
	}


	@Override
	public void deleteGoods(int goodsId) {
		sqlSession.delete("mapper.admin.goods.deleteimages", goodsId);
		sqlSession.delete("mapper.admin.goods.deleteGoods", goodsId);
	}

	@Override
	public void modifyGoods(String goodsId, Map newGoodsMap) throws Exception {
		sqlSession.insert("mapper.admin.goods.modifyGoods", newGoodsMap);
	}

	
	
	
	
	@Override
	public void modifyImages(List imageFileList) throws Exception {
		for (int i = 0; i < imageFileList.size(); i++) {
			ImageFileVO imageFileVO = (ImageFileVO) imageFileList.get(i);
			sqlSession.insert("mapper.admin.goods.modifyimages", imageFileVO);
		}

	}





	@Override
	public void updateGoodsFileName(ArrayList<ImageFileVO> imageFileList) {
		
			ImageFileVO imageFileVO = (ImageFileVO) imageFileList.get(0);
			sqlSession.insert("mapper.admin.goods.updateGoodsFileName", imageFileVO);
		
		
	}

	
	
	
}
