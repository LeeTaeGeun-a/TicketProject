package com.spring.project;

public interface ScedSeatDAO {
	
	void update(ScedSeatDTO scedSeatDto);
	void insert(ScedSeatDTO scedSeatDto);
	ScedSeatDTO selectOne(ScedSeatDTO scedSeatDto);
	
	

}
