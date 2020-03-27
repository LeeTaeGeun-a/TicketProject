package com.spring.project;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface SeatQebc {

	public List<SeatDTO> selectUseY(@Param("theatId")String theatId, @Param("scrRmId") String scrRmId);
	List<SeatDTO> selectAll(SeatDTO seatDto);
	String maxNum(SeatDTO seatDto);
}
