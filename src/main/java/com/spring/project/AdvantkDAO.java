package com.spring.project;

import org.apache.ibatis.annotations.Param;

public interface AdvantkDAO {
	
	void insert(AdvantkDTO advantkDto);
	void update(AdvantkDTO advantkDto);
	AdvantkDTO selectOne(@Param("advantkId") String advantkId);
}
