package com.spring.project;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface NoticeBBSQebc {
	int count();
	List<NoticeBBSDTO> selectAllPage(@Param("start")int start,@Param("max")int max);
	List<NoticeBBSDTO> selectAllKey(@Param("start")int start,@Param("max")int max,@Param("searchKeyword")String searchKeyword);
	int keyCount(@Param("searchKeyword")String searchKeyword);
	String maxNum();
}
