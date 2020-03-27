package com.spring.project;

public interface ScrinngDAO {
	
	void insert(ScrinngDTO scrinngDto);
	void update(ScrinngDTO scrinngDto);
	ScrinngDTO selectOne(ScrinngDTO scrinngDto);

}
