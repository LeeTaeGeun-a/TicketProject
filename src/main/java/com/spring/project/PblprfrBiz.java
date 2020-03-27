package com.spring.project;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public interface PblprfrBiz {
	
	public PblprfrDTO bizSelectOne(String pblprfrId);
	public PblprfrJoinDTO bizSelectJoinOne(String pblprfrId);
	public HashMap<String,Object> bizSelectOneForUser(String pblprfrId,HttpSession session);
	public HashMap<String,Object> bizSelectOneForManage(String pblprfrId);
	public Map<String,Object> bizSelectForHome(); // 추가한거
	public HashMap<String,Object> bizSelectList(String genre, String area, String schedule ,String sWord , int pageNum);
	public HashMap<String,Object> bizSelectForManage(String sWord ,int pageNum);
	public int bizInsert(PblprfrDTO pblDto, HttpServletRequest request);
	public int bizUpdate(PblprfrDTO pblDto, String ckTitleImg , String ckDetailImg , HttpServletRequest request);
	public int insertForm();
	
	

}
