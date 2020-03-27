package com.spring.project;

public class ScrRmJoinDTO {

	private String theatId;
	private String scrRmId;	
	private String theatNm;	
	private String scrRmNm;
	private int totSeat;	
	private String clsAt;
	
	public String getTheatId() {
		return theatId;
	}
	public void setTheatId(String theatId) {
		this.theatId = theatId;
	}
	public String getTheatNm() {
		return theatNm;
	}
	public void setTheatNm(String theatNm) {
		this.theatNm = theatNm;
	}
	public String getScrRmNm() {
		return scrRmNm;
	}
	public void setScrRmNm(String scrRmNm) {
		this.scrRmNm = scrRmNm;
	}
	public String getClsAt() {
		return clsAt;
	}
	public void setClsAt(String clsAt) {
		this.clsAt = clsAt;
	}
	public int getTotSeat() {
		return totSeat;
	}
	public void setTotSeat(int totSeat) {
		this.totSeat = totSeat;
	}
	public String getScrRmId() {
		return scrRmId;
	}
	public void setScrRmId(String scrRmId) {
		this.scrRmId = scrRmId;
	}	
	
}