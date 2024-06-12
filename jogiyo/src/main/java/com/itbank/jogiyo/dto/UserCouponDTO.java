package com.itbank.jogiyo.dto;

public class UserCouponDTO {
	private int usercid;
	private int couponid;
	private String id;
	private String indate;
	public int getUsercid() {
		return usercid;
	}
	public void setUsercid(int usercid) {
		this.usercid = usercid;
	}
	public int getCouponid() {
		return couponid;
	}
	public void setCouponid(int couponid) {
		this.couponid = couponid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIndate() {
		return indate;
	}
	public void setIndate(String indate) {
		this.indate = indate;
	}

}