package com.spring.project;

import java.util.List;
import java.util.Map;

public interface MberInqBiz {
	MberInqDTO bizSelectOne(String mberId, String inqryNo);
	int bizUpdate(MberInqDTO dto);
	int bizDelete(MberInqDTO dto);
	int bizInsert(MberInqDTO dto);
	int bizAnswerInsert(MberInqDTO dto,String askMberId, String inqryNo);
	Map<String,Object> bizSelectAll(String mberId, int pageNum);
	List<MberInqDTO> mberInqSelect(MberInqDTO dto);
	Map<String,Object> bizSelectForMng(String cmb, String search, String cmbAt,int pageNum);
	Map<String,Object> bizMngSelect(int pageNum);
	MberInqJoinDTO bizAnswerForm(String inqryNo);
	MberInqDTO bizAnswerSelect(String inqryNo);
	List<MberInqDTO> bizSelectForMng1();
}
