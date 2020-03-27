package com.spring.project;

import java.util.List;

public interface ScrinngRmBiz {
	
	List<ScrinngRmDTO> selectOpnngAll(String theatId);
	public List<ScrRmJoinDTO> bizSelectAll(String theatId);
	public int bizInsert(String theatId ,String[] scrRmNm,String[] totSeat,String[] seatRow,String[] seatCol);
	public int bizUpdate(ScrinngRmDTO dto);
	public ScrinngRmDTO bizUpdateForm(String theatId,String scrRmId);

}
