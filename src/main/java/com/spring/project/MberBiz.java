package com.spring.project;

import java.util.HashMap;
import java.util.List;

public interface MberBiz {
	
	HashMap<String,Object> bizLogin(MberDTO dto);
	MberDTO bizSelectOne(String mberId);
	int bizInsert(MberDTO dto);
	int bizUpdate(MberDTO dto);
	int bizAtUpdate(String mberId);
	String bizIdFind(MberDTO dto);
	String bizPwfind(MberDTO dto);
	MberDTO bizMberCrtfc(MberDTO dto);
	HashMap<String, Object> bizMyPage(String mber_id);
	String bizPwConfirm(MberDTO dto);
	MberDTO bizUpdateForm(String mberId);
	List<MberDTO> bizSelectAll(String cmbValue,String input,int pageNum);
}
