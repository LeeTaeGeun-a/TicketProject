package com.spring.project;

import org.apache.ibatis.annotations.Param;

public interface MberDAO {
	MberDTO selectOne(@Param("mberId") String mberId);
	MberDTO selectOneAll(@Param("mberId") String mberId);
	void insert(MberDTO dto);
	int update(MberDTO dto);
}
