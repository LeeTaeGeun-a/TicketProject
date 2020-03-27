package com.spring.project;

import java.util.HashMap;
import java.util.List;

public interface TheatQebc{
	
	List<TheatDTO> selectNm(HashMap<String, Object> voMap);
	List<TheatDTO> selectLoc(HashMap<String, Object> voMap);
	List<TheatDTO> selectAll();
	String maxNum();
}
