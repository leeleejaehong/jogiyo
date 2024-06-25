package com.itbank.jogiyo.dto;

public class ReviewDTO {
	private int reviewid;
	private int storeid;
	private String revcotent;
	private String reply;
	private double grade;
	public int getReviewid() {
		return reviewid;
	}
	public void setReviewid(int reviewid) {
		this.reviewid = reviewid;
	}
	public int getStoreid() {
		return storeid;
	}
	public void setStoreid(int storeid) {
		this.storeid = storeid;
	}
	public String getRevcotent() {
		return revcotent;
	}
	public void setRevcotent(String revcotent) {
		this.revcotent = revcotent;
	}
	public String getReply() {
		return reply;
	}
	public void setReply(String reply) {
		this.reply = reply;
	}
	public double getGrade() {
		return grade;
	}
	public void setGrade(double grade) {
		this.grade = grade;
	}
	
	
}
