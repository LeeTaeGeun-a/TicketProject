package com.spring.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("intrstBiz")
public class IntrstListBizImpl implements IntrstListBiz {
	
	@Autowired
	IntrstDAO intrstDao;
	@Autowired
	PblprfrQebc pblQebc;
	@Autowired
	CommonBiz commonBiz;
	

	@Override
	public int bizInsertInst(String pblprfrId, HttpSession session) {
		
		String mberId = (String) session.getAttribute("loginedId");
		IntrstDTO instDto = new IntrstDTO();
		instDto.setPblprfrId(pblprfrId);
		instDto.setMberId(mberId);
		
		IntrstDTO checkDto = intrstDao.selectOne(instDto);
		if(checkDto != null)
		{
			return 0;
		}
		
		intrstDao.insert(instDto);
		
		return 1;
	}

	@Override
	public int bizDeleteInst(String pblprfrId, HttpSession session) {
		
		String mberId = (String) session.getAttribute("loginedId");
		IntrstDTO instDto = new IntrstDTO();
		instDto.setPblprfrId(pblprfrId);
		instDto.setMberId(mberId);
		IntrstDTO checkDto = intrstDao.selectOne(instDto);
		if(checkDto == null)
		{
			return 0;
		}
		
		intrstDao.delete(instDto);
		
		return 1;
	}

	@Override
	public Map<String,Object> bizSelectAll(String mberId, int pageNum) {
		
		final int MAXSIZE = 10;
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		map.put("mberId", mberId);
		
		List<PblprfrDTO> totInstList = pblQebc.selectInstPblInfo(map);
		List<PblprfrDTO> intrstList = null;
		
		int totInstCount = totInstList.size();
		if(totInstCount != 0) 
		{
			int startRow  = (pageNum - 1) * MAXSIZE +1 ;
			
			map.put("maxSize" , MAXSIZE);
			map.put("startRow", startRow);
			
			intrstList = pblQebc.selectInstPblInfo(map);
		}
		
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totInstCount, 5, MAXSIZE);
		
		resMap.put("intrstList", intrstList);
		resMap.put("totInstCount", totInstCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));
		
		return resMap;
	}

}
