package com.spring.project;

public interface IntrstDAO {
	
	IntrstDTO selectOne(IntrstDTO intrstDto);
	void insert(IntrstDTO intrstDto);
	void delete(IntrstDTO intrstDto);

}
