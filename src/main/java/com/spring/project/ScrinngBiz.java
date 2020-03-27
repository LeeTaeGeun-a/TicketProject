package com.spring.project;

import java.util.List;
import java.util.Map;

public interface ScrinngBiz {
	
	Map<String,Object> bizSelectForManage(String pblId,int pageNum ,String searchDate);
	Map<String,Object> bizSelectDateForUser(String pblId, String pickedDate);
	int bizUpdateAt(String pblId, List<String> scrinngDtList);
	int bizInsertOneDate(String pblId,String scrDate, List<String> scrTimeList);
	int bizInsertPeriod(String pblId,String startDate,String endDate, List<String> scrTimeList);
	Map<String,Object> bizSelectForMng();
}
