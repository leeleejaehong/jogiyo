package com.itbank.jogiyo.dto;

import org.springframework.web.multipart.MultipartFile;

public class StoreDTO {
	private int storeid;
	private String storename;
	private MultipartFile file;
	private int cateid;
	private String storecontent;
	private String id;
	private double lat;
	private double har;
	private String img;
	private int couponid;
	public int getStoreid() {
		return storeid;
	}
	public void setStoreid(int storeid) {
		this.storeid = storeid;
	}
	public String getStorename() {
		return storename;
	}
	public void setStorename(String storename) {
		this.storename = storename;
	}
	public int getCateid() {
		return cateid;
	}
	public void setCateid(int cateid) {
		this.cateid = cateid;
	}
	public String getStorecontent() {
		return storecontent;
	}
	public void setStorecontent(String storecontent) {
		this.storecontent = storecontent;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public double getLat() {
		return lat;
	}
	public void setLat(double lat) {
		this.lat = lat;
	}
	public double getHar() {
		return har;
	}
	public void setHar(double har) {
		this.har = har;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public int getCouponid() {
		return couponid;
	}
	public void setCouponid(int couponid) {
		this.couponid = couponid;
	}
	public MultipartFile getFile() {
		return file;
	}
	public void setFile(MultipartFile file) {
		this.file = file;
	}

	
	
	
}
