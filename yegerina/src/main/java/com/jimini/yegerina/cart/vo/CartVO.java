package com.jimini.yegerina.cart.vo;

import java.sql.Date;

import org.springframework.stereotype.Component;

@Component("cartVO")
public class CartVO {
	private String memberId; //회원아이디
	private int goodsId; // 상품번호
	private int cartId; // 장바구니번호
	private int cartGoodsQty; //상품개수
	private Date creDate; //생성일자
	
	
	public CartVO() {
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public int getCartId() {
		return cartId;
	}
	public void setCartId(int cartId) {
		this.cartId = cartId;
	}
	public int getCartGoodsQty() {
		return cartGoodsQty;
	}
	public void setCartGoodsQty(int cartGoodsQty) {
		this.cartGoodsQty = cartGoodsQty;
	}
	public Date getCreDate() {
		return creDate;
	}
	public void setCreDate(Date creDate) {
		this.creDate = creDate;
	}
	
	
	
	


	
	
	

}

