package com.jimini.yegerina.goods.vo;

import java.sql.Date;

public class ImageFileVO {
	private int imageId;
	private int goodsId; 
	private String regId;
	private String fileType;
	private Date creDate;
	private String fileName;

	
	
	public ImageFileVO() {
 
	}



	public int getImageId() {
		return imageId;
	}



	public void setImageId(int imageId) {
		this.imageId = imageId;
	}



	public int getGoodsId() {
		return goodsId;
	}



	public void setGoodsId(int goodsId) {
		this.goodsId = goodsId;
	}



	public String getFileName() {
		return fileName;
	}



	public void setFileName(String fileName) {
		this.fileName = fileName;
	}



	public String getFileType() {
		return fileType;
	}



	public void setFileType(String fileType) {
		this.fileType = fileType;
	}



	public String getRegId() {
		return regId;
	}



	public void setRegId(String regId) {
		this.regId = regId;
	}



	public Date getCredDate() {
		return creDate;
	}



	public void setCredate(Date creDate) {
		this.creDate = creDate;
	}

	

	

}