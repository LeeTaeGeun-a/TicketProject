package com.spring.project;

public interface ScrinngRmDAO {

	ScrinngRmDTO selectOne(ScrinngRmDTO scrinngRmDto);
	void insert(ScrinngRmDTO scrinngRmDto);
	void update(ScrinngRmDTO scrinngRmDto);
}
