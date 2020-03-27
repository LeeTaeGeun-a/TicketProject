package com.spring.project;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ScrinngQebc {
	
	List<ScrinngDTO> selectForUser(@Param("pblId") String pblprfrId);
	List<ScrinngDTO> selectForManage(HashMap<String,Object> scrMap);
	List<ScrinngJoinDTO> selectForMng(@Param("crtTime") String crtTime);
	String getMinDate(@Param("pblId") String pblprfrId);
	String getMaxDate(@Param("pblId") String pblprfrId);
	List<ScrinngDTO> selectForClose(@Param("nowTime") String nowTime);


}
