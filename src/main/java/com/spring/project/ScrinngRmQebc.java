package com.spring.project;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ScrinngRmQebc {

	List<ScrinngRmDTO> selectOpnngAll(@Param("theatId") String theatId);
	List<ScrinngRmDTO> selectAll();
	List<ScrRmJoinDTO> selectJoinAll(String theatId);
	String maxNum(String theatId);
}
