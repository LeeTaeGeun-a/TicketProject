package com.spring.project;

import java.util.Map;

import javax.servlet.http.HttpSession;

public interface ReviewBiz {
	
	int insertReview(HttpSession session, ReviewDTO reviewDto);
	Map<String,Object> selectReviewAboutPbl(String pblprfrId,int pageNum);
	int deleteReview(ReviewDTO reviewDto);

}
