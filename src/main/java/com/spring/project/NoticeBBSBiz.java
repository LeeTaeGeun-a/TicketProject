package com.spring.project;

import java.util.HashMap;

public interface NoticeBBSBiz {
	
	public HashMap<String,Object> bizSelectAll(int pageNum);
	public HashMap<String,Object> bizSelectAllKey(int pageNum,String searchKeyword);
	public int bizInsert(NoticeBBSDTO noticeBBSDto);
	public int bizUpdate(NoticeBBSDTO noticeBBSDto);
	public int bizDelete(String noticeNo);
	public NoticeBBSDTO bizUpdateForm(String noticeNo);

}
