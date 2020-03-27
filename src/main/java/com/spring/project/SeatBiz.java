package com.spring.project;

import java.util.List;

public interface SeatBiz {
	
	public List<SeatDTO> bizSelectAll(SeatDTO seatDto);
	public int bizInsert(String theatId,String scrRmId);
	public int bizInsertRow(String theatId,String scrRmId);
	public int bizInsertCol(String theatId,String scrRmId);
	public int bizUpdate(SeatDTO seatDto,String[] seatId);
}
