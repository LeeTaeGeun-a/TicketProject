package com.spring.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface AdvantkQebc {
	List<AdvantkDTO> data4myPage(String mberId,int start,int max);//마이페이지용 조회
	List<AdvantkJoinDTO> selectForUser(HashMap<String,Object> map);
	List<AdvantkDTO> selectForCancle(Map<String,Object> map); // 상연 취소 , 공연 취소 시 사용
	List<AdvantkJoinDTO> selectForAdmin(Map<String,Object> map);
	List<AdvantkJoinDTO> selectForMng();
	List<AdvantkDTO> selectForClose(@Param("nowTime") String nowTime);
	String getMaxAdvantkId();
	
}
