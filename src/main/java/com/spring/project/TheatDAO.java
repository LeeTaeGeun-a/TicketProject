package com.spring.project;

public interface TheatDAO {
	
	TheatDTO selectOne(String theatId);
	void insert(TheatDTO theatDto);
	void update(TheatDTO theatDto);

}
