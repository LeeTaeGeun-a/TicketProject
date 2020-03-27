package com.spring.project;

import java.util.HashMap;
import java.util.List;

public interface MberInqQebc {
	List<MberInqDTO> selectForUser(HashMap<String,Object> map);
	int countInq();
	String getMaxNum();
	List<MberInqDTO> mberInqSelect(MberInqDTO dto);
	List<MberInqDTO> mngInqAnswerAtSelect(HashMap<String,Object> map);
	List<MberInqDTO> mngInqSelectAll(HashMap<String,Object> map);
	List<MberInqDTO> mngInqIdSelect(HashMap<String,Object> map);
	MberInqJoinDTO inqAnswerForMng(String inqryNo);
	MberInqDTO answerFind(int no);
	List<MberInqDTO> selectForMng();
}

