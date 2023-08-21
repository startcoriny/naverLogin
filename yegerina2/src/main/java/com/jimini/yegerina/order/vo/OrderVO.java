package com.jimini.yegerina.order.vo;

import org.springframework.stereotype.Component;

@Component("orderVO")

public class OrderVO {
	private int order_seq_num; //주문상품일련번호
	private int orderId; //주문번호
	private int goodsId; //상품번호
	private String goodsTitle; //상품이름
	private int goodsSalesPrice; //상품판매가격
	private String goodsFileName; //상품이미지파일이름
	private int orderGoodsQty; //상품주문수량
	private String delivery_state;  // 상품 배송 상태
	private String memberId; //주문자 아이디
	private String orderer_hp; //주문자휴대폰번호
	private String receiver_name; //수령자이름
	private String receiver_hp1; //수령자휴대폰번호
	private String delivery_address; // 수령자배송주소
	private String pay_method; // 경제방법
	private String card_com_name; //결체카드회사이름
	private String pay_orderer_hp_num; //결제휴대폰번호
	private String card_pay_month; //결제할부개월수
	private String pay_order_time; //결제시간
	private String delivery_message; //배송메세지
	
	
	
	public OrderVO() {

	}
	
	
	
	
	public String getDelivery_message() {
		return delivery_message;
	}




	public void setDelivery_message(String delivery_message) {
		this.delivery_message = delivery_message;
	}




	public int getOrder_seq_num() {
		return order_seq_num;
	}
	public void setOrder_seq_num(int order_seq_num) {
		this.order_seq_num = order_seq_num;
	}
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public int getGoodsId() {
		return goodsId;
	}
	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}
	public String getGoodsTitle() {
		return goodsTitle;
	}
	public void setGoodsTitle(String goodsTitle) {
		this.goodsTitle = goodsTitle;
	}
	public int getGoodsSalesPrice() {
		return goodsSalesPrice;
	}
	public void setGoodsSalesPrice(int goodsSalesPrice) {
		this.goodsSalesPrice = goodsSalesPrice;
	}
	public String getGoodsFileName() {
		return goodsFileName;
	}
	public void setGoodsFileName(String goodsFileName) {
		this.goodsFileName = goodsFileName;
	}
	public int getOrderGoodsQty() {
		return orderGoodsQty;
	}
	public void setOrderGoodsQty(int orderGoodsQty) {
		this.orderGoodsQty = orderGoodsQty;
	}
	public String getDelivery_state() {
		return delivery_state;
	}
	public void setDelivery_state(String delivery_state) {
		this.delivery_state = delivery_state;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getOrderer_hp() {
		return orderer_hp;
	}
	public void setOrderer_hp(String orderer_hp) {
		this.orderer_hp = orderer_hp;
	}
	public String getReceiver_name() {
		return receiver_name;
	}
	public void setReceiver_name(String receiver_name) {
		this.receiver_name = receiver_name;
	}
	public String getReceiver_hp1() {
		return receiver_hp1;
	}
	public void setReceiver_hp1(String receiver_hp1) {
		this.receiver_hp1 = receiver_hp1;
	}
	public String getDelivery_address() {
		return delivery_address;
	}
	public void setDelivery_address(String delivery_address) {
		this.delivery_address = delivery_address;
	}
	public String getPay_method() {
		return pay_method;
	}
	public void setPay_method(String pay_method) {
		this.pay_method = pay_method;
	}
	public String getCard_com_name() {
		return card_com_name;
	}
	public void setCard_com_name(String card_com_name) {
		this.card_com_name = card_com_name;
	}
	public String getPay_orderer_hp_num() {
		return pay_orderer_hp_num;
	}
	public void setPay_orderer_hp_num(String pay_orderer_hp_num) {
		this.pay_orderer_hp_num = pay_orderer_hp_num;
	}
	public String getCard_pay_month() {
		return card_pay_month;
	}
	public void setCard_pay_month(String card_pay_month) {
		this.card_pay_month = card_pay_month;
	}
	public String getPay_order_time() {
		return pay_order_time;
	}
	public void setPay_order_time(String pay_order_time) {
		this.pay_order_time = pay_order_time;
	}
	
	
	

}

