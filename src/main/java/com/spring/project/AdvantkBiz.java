package com.spring.project;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

public interface AdvantkBiz {
	
	public Map<String,Object> bizSelectForUser(String mberId, int pageNum);
	public Map<String,Object> bizAdvantkInsertForm(HttpSession session ,AdvantkDTO advantkDto);
	public Map<String,Object> bizAdvantkInsert(AdvantkDTO advantkDto, List<String> ckedSeats);
	public Map<String,Object> bizSelectAdtkDetail(String advantkId);
	public int bizCancleAdvantk(String advantkId);
	public Map<String,Object> bizSelectForAdmin(int pageNum ,String condition, String sWord);
	public List<AdvantkJoinDTO> bizSelectForMng();
	public int closeProc();
}
