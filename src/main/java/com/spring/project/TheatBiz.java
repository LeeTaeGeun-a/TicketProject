package com.spring.project;

import java.util.HashMap;
import java.util.List;

public interface TheatBiz {
	
	TheatDTO bizSelectOne(String theatId); 
	HashMap<String,Object> bizSelectNm (String searchWord, int pageNum);
	HashMap<String,Object> bizSelectLoc(String searchWord, int pageNum);
	public List<TheatDTO> bizSelectAll();
	public int bizInsert(TheatDTO dto ,String[] scrRmNm,String[] totSeat,String[] seatRow,String[] seatCol);
	public TheatDTO bizUpdateForm(int theatId);
	public int bizUpdate(TheatDTO dto);

}
