package com.spring.project;

import java.util.Map;

import javax.servlet.http.HttpSession;

public interface IntrstListBiz {
	
	int bizInsertInst(String pblprfrId, HttpSession session);
	int bizDeleteInst(String pblprfrId, HttpSession session);
	Map<String,Object> bizSelectAll(String mberId, int pageNum);
}
