package com.jimini.yegerina.goods.vo;

import java.sql.Date;
import java.util.ArrayList;

public class GoodsVO {
	private int goodsId; //상품번호
	private String goodsSort; // 카테고리
	private String goodsStatus; // 상품분류
	private String goodsTitle; // 상품제목
	private String goodsWriterIntro; // 상품소개
	private int    goodsSalesPrice; // 상품판매가격
	private int goodsDeliveryPrice; // 배송비
	private Date   goodsDeliveryDate; // 상품배송일
	private String goodsFileName; // 이미지 파일명
	private Date goodsCreDate; // 상품생성일
	
	
	public GoodsVO() {

	}


	public int getGoodsId() {
		return goodsId;
	}

	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}

	public String getGoodsSort() {
		return goodsSort;
	}

	public void setGoodsSort(String goodsSort) {
		this.goodsSort = goodsSort;
	}

	public String getGoodsStatus() {
		return goodsStatus;
	}

	public void setGoodsStatus(String goodsStatus) {
		this.goodsStatus = goodsStatus;
	}

	public String getGoodsTitle() {
		return goodsTitle;
	}

	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}

	public String getGoodsWriterIntro() {
		return goodsWriterIntro;
	}

	public void setGoodsWriterIntro(String goodsWriterIntro) {
		this.goodsWriterIntro = goodsWriterIntro;
	}

	public int getGoodsSalesPrice() {
		return goodsSalesPrice;
	}

	public void setGoodsSalesPrice(int goodsSalesPrice) {
		this.goodsSalesPrice = goodsSalesPrice;
	}

	public int getGoodsDeliveryPrice() {
		return goodsDeliveryPrice;
	}

	public void setGoodsDeliveryPrice(int goodsDeliveryPrice) {
		this.goodsDeliveryPrice = goodsDeliveryPrice;
	}

	public Date getGoodsDeliveryDate() {
		return goodsDeliveryDate;
	}

	public void setGoodsDeliveryDate(Date goodsDeliveryDate) {
		this.goodsDeliveryDate = goodsDeliveryDate;
	}


	public String getGoodsFileName() {
		return goodsFileName;
	}


	public void setGoodsFileName(String goodsFileName) {
		this.goodsFileName = goodsFileName;
	}


	public Date getGoodsCreDate() {
		return goodsCreDate;
	}


	public void setGoodsCreDate(Date goodsCreDate) {
		this.goodsCreDate = goodsCreDate;
	}

	

}