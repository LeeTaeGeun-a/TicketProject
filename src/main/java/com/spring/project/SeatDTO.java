package com.spring.project;

public class SeatDTO {
	
	private String theatId;
	private String scrRmId;
	private String seatRow;
	private String seatCol;
	private String usefulAt;
	
	public String getTheatId() {
		return theatId;
	}
	public void setTheatId(String theatId) {
		this.theatId = theatId;
	}
	public String getScrRmId() {
		return scrRmId;
	}
	public void setScrRmId(String scrRmId) {
		this.scrRmId = scrRmId;
	}
	public String getSeatRow() {
		return seatRow;
	}
	public void setSeatRow(String seatRow) {
		this.seatRow = seatRow;
	}
	public String getSeatCol() {
		return seatCol;
	}
	public void setSeatCol(String seatCol) {
		this.seatCol = seatCol;
	}
	public String getUsefulAt() {
		return usefulAt;
	}
	public void setUsefulAt(String usefulAt) {
		this.usefulAt = usefulAt;
	}
	

}