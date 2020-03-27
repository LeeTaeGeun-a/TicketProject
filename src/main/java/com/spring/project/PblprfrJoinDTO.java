package com.spring.project;

public class PblprfrJoinDTO {

	//공연 정보
	
	private String pblprfrId;
	private String theatId;
	private String scrinngRmId;
	private String pblNm;
	private String price;
	private String actor;
	private String dirc;
	private String genre;
	private String runTime;
	private String period;
	private String titleImgLc;
	private String detailImgLc;
	private String pblprfrAt;
	private String grade;
	private double totScore;
	
	// 극장 관련 정보
	private String theatName;
	private String theatLoc;
	private String theatTel;
	
	
	public String getPblprfrId() {
		return pblprfrId;
	}
	public void setPblprfrId(String pblprfrId) {
		this.pblprfrId = pblprfrId;
	}
	public String getTheatId() {
		return theatId;
	}
	public void setTheatId(String theatId) {
		this.theatId = theatId;
	}
	public String getPblNm() {
		return pblNm;
	}
	public void setPblNm(String pblNm) {
		this.pblNm = pblNm;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getActor() {
		return actor;
	}
	public void setActor(String actor) {
		this.actor = actor;
	}
	public String getDirc() {
		return dirc;
	}
	public void setDirc(String dirc) {
		this.dirc = dirc;
	}
	public String getGenre() {
		return genre;
	}
	public void setGenre(String genre) {
		this.genre = genre;
	}
	public String getRunTime() {
		return runTime;
	}
	public void setRunTime(String runTime) {
		this.runTime = runTime;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String getPblprfrAt() {
		return pblprfrAt;
	}
	public void setPblprfrAt(String pblprfrAt) {
		this.pblprfrAt = pblprfrAt;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public double getTotScore() {
		return totScore;
	}
	public void setTotScore(double totScore) {
		this.totScore = totScore;
	}
	public String getTheatName() {
		return theatName;
	}
	public void setTheatName(String theatName) {
		this.theatName = theatName;
	}
	public String getTheatLoc() {
		return theatLoc;
	}
	public void setTheatLoc(String theatLoc) {
		this.theatLoc = theatLoc;
	}
	public String getTheatTel() {
		return theatTel;
	}
	public void setTheatTel(String theatTel) {
		this.theatTel = theatTel;
	}
	
	public String getScrinngRmId() {
		return scrinngRmId;
	}
	public void setScrinngRmId(String scrinngRmId) {
		this.scrinngRmId = scrinngRmId;
	}
	public String getTitleImgLc() {
		return titleImgLc;
	}
	public void setTitleImgLc(String titleImgLc) {
		this.titleImgLc = titleImgLc;
	}
	public String getDetailImgLc() {
		return detailImgLc;
	}
	public void setDetailImgLc(String detailImgLc) {
		this.detailImgLc = detailImgLc;
	}

	@Override
	public String toString() {
		
		String res="{pblprfrId:"+pblprfrId+",theatId:"+theatId+"}";
		
		return res;
	}
	
	
	
	
	
	
}
