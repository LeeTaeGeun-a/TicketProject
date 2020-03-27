package com.spring.project;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface PblprfrQebc {

	public List<PblprfrJoinDTO> selectForRank(@Param("maxSize") int maxSize);
	public List<PblprfrJoinDTO> selectForAdvanktkRank(@Param("maxSize") int maxSize);
	public List<PblprfrJoinDTO> selectForRecomend(@Param("maxSize") int maxSize, @Param("theatId")String theatId);
	public List<PblprfrJoinDTO> selectList(HashMap<String, Object> voMap); // 공연검색메서드 
	public List<PblprfrJoinDTO> selectForManage(HashMap<String,Object> map);
	public List<PblprfrDTO> 	selectInstPblInfo(HashMap<String,Object> map);
	public List<PblprfrDTO>     selectForClose(@Param("nowTime") String nowTime);
	public PblprfrJoinDTO selectJoinOne(String pblprfrId);
	public String maxNum();
	
}
