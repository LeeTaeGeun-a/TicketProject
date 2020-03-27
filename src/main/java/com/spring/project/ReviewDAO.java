package com.spring.project;

public interface ReviewDAO {
	
	ReviewDTO selectOne(ReviewDTO reviewDto);
	int insert(ReviewDTO reviewDto);
	void delete(ReviewDTO reviewDto);

}
