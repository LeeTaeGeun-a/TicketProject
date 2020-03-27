package com.spring.project;

import org.apache.ibatis.annotations.Param;

public interface NoticeBBSDAO {
	public NoticeBBSDTO selectOne(@Param("noticeNo") String noticeNo);
	public void insert(NoticeBBSDTO dto);
	public int update(NoticeBBSDTO dto);
	public int delete(String noticeNo);
}
