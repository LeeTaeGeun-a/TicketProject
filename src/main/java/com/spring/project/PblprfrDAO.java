package com.spring.project;

public interface PblprfrDAO {
	
	public PblprfrDTO selectOne(String pblprfrId);
	public void insert(PblprfrDTO pblDto);
	public void update(PblprfrDTO pblDto);
	
}
