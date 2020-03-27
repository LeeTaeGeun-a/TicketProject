package com.spring.project;

public class ReviewDTO {
	private String pblprfrId;
	private String registDt;
	private String mberId;
	private String content;
	private int    score;
	
	
	public String getPblprfrId() {
		return pblprfrId;
	}
	public void setPblprfrId(String pblprfrId) {
		this.pblprfrId = pblprfrId;
	}
	public String getRegistDt() {
		return registDt;
	}
	public void setRegistDt(String registDt) {
		this.registDt = registDt;
	}
	public String getMberId() {
		return mberId;
	}
	public void setMberId(String mberId) {
		this.mberId = mberId;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	
	
	
}
