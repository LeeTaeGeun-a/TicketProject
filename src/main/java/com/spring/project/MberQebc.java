package com.spring.project;

import java.util.List;

public interface MberQebc {
	public List<MberDTO> selectAll(int tmp1,int tmp2);
	public List<MberDTO> selectNmAll(String input,int start, int max);
	public List<MberDTO> selectIdAll(String input,int start, int max);
	public MberDTO selectId(String mberNm,String mberEmail);
}
