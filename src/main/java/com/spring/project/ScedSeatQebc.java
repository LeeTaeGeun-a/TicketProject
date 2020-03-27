package com.spring.project;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ScedSeatQebc {
	
	List<ScedSeatDTO> selectForAdvntk(ScedSeatDTO scedSeatDto);
	List<ScedSeatDTO> selectAllcrtTime(@Param("theatId") String theatId,@Param("scrRmId") String scrRmId,@Param("seatCol") String seatCol,@Param("seatRow") String seatRow,@Param("crtTime") String crtTime);
	List<ScedSeatDTO> selectAllInsert(@Param("theatId") String theatId,@Param("scrRmId") String scrRmId,@Param("crtTime") String crtTime);
	int selectMaxRow(ScedSeatDTO scedSeatDto);
	int selectMaxCol(ScedSeatDTO scedSeatDto);


}
