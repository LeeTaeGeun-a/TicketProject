package com.spring.project;


public interface MberInqDao {
	MberInqDTO selectOne(MberInqDTO dto);
	void insert(MberInqDTO dto);
	void update(MberInqDTO dto);
	void delete(MberInqDTO dto);
}
