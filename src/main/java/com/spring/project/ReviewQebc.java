package com.spring.project;

import java.util.List;
import java.util.Map;

public interface ReviewQebc {
	
	List<ReviewDTO> selectAboutPbl(String pblId);
	List<ReviewDTO> selectAboutPblPaging(Map<String,Object> map);

}
