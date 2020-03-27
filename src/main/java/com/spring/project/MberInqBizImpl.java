package com.spring.project;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("inqBiz")
public class MberInqBizImpl implements MberInqBiz{
	
	@Autowired
	MberInqDao	inqDao;
	@Autowired
	MberInqQebc	inqQebc;
	@Autowired 
	CommonBiz 	commonBiz;
	@Override
	public Map<String,Object> bizSelectAll(String mberId, int pageNum) {
		
		final int MAXSIZE = 10;
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		map.put("mberId", mberId);
		
		List<MberInqDTO> totInqList = inqQebc.selectForUser(map);
		List<MberInqDTO> inqList = null;
		
		int totInqCount = totInqList.size();
		if(totInqCount != 0) 
		{
			int startRow  = (pageNum - 1) * MAXSIZE +1 ;
			
			map.put("maxSize" , MAXSIZE);
			map.put("startRow", startRow);
			
			inqList = inqQebc.selectForUser(map);
		}
		
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totInqCount, 5, MAXSIZE);
		
		
		resMap.put("inqList", inqList);
		resMap.put("totInqCount", totInqCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));
		
		return resMap;
	}
	@Override
	public MberInqDTO bizSelectOne(String mberId, String inqryNo) {
		MberInqDTO dto = new MberInqDTO();
		dto.setMberId(mberId);
		dto.setInqryNo(inqryNo);
		
		dto = inqDao.selectOne(dto);
		
		return dto;
	}
	@Override
	public int bizUpdate(MberInqDTO dto) {
		int res = 0;
		
		MberInqDTO inq = inqDao.selectOne(dto);
		inq.setInqrySj(dto.getInqrySj());
		inq.setContent(dto.getContent());
		
		inqDao.update(inq);
		res = 1;
		if(inq.getReStep() == 2)
		{
			res=4;
		}
		return res;
	}
	@Override
	public int bizDelete(MberInqDTO dto) {
		int res = 0;
		inqDao.delete(dto);
		res = 1;
		return res;
	}

	@Override//회원
	public int bizInsert(MberInqDTO dto) {
		int res = 0;

		String max= inqQebc.getMaxNum();
		int maxNum;
		if(max == null)
		{
			maxNum = 1;
		}else
		{
			maxNum = Integer.parseInt(max)+1;
		}
		String sMaxNum = String.valueOf(maxNum);
		dto.setInqryNo(sMaxNum);
		dto.setRefrnNo(maxNum);
		dto.setReStep(1);
		dto.setAnswerAt("N");
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		Calendar time = Calendar.getInstance();
		
		String registDate = format1.format(time.getTime());

		dto.setRegistDate(registDate);
		
		inqDao.insert(dto);
		
		res = 1;
		return res;
	}
	@Transactional
	@Override//관리자 답변
	public int bizAnswerInsert(MberInqDTO dto, String askMberId, String inqryNo) {
		int res = 0;
		String max= inqQebc.getMaxNum();
		int maxNum;
		if(max == null)
		{
			maxNum = 1;
		}else
		{
			maxNum = Integer.parseInt(max)+1;
		}
		String sMaxNum = String.valueOf(maxNum);
		dto.setInqryNo(sMaxNum);
		dto.setReStep(2);
		dto.setAnswerAt("Y");
		dto.setRefrnNo(Integer.parseInt(inqryNo));
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd");
		Calendar time = Calendar.getInstance();
		
		String registDate = format1.format(time.getTime());

		dto.setRegistDate(registDate);
		
		MberInqDTO org = new MberInqDTO();
		org.setMberId(askMberId);
		org.setInqryNo(inqryNo);
		org = inqDao.selectOne(org);
		org.setAnswerAt("Y");
		inqDao.update(org);
		
		inqDao.insert(dto);
		
		res = 1;
		return res;
	}
	@Override
	public List<MberInqDTO> mberInqSelect(MberInqDTO dto) {
		String sInqNo = dto.getInqryNo();
		int refrnNo = Integer.parseInt(sInqNo);
		
		dto.setRefrnNo(refrnNo);
		List<MberInqDTO> list = inqQebc.mberInqSelect(dto);
		
		return list;
	}
	@Override
	public Map<String,Object> bizSelectForMng(String cmb, String search, String cmbAt,int pageNum) {
		
		final int MAXSIZE = 10;
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		List<MberInqDTO> inqList = null;
		List<MberInqDTO> totInqList = null;
		
		

		if("id".equals(cmb)) {
			if(search == null )
			{
				search = "%";
			}else
			{
				search +=  "%";
			}
			
			map.put("mberId", search);
			totInqList = inqQebc.mngInqIdSelect(map);
		}
		else if("at".equals(cmb))
		{
			map.put("answerAt", cmbAt);
			totInqList = inqQebc.mngInqAnswerAtSelect(map);
		}

		int totInqCount = totInqList.size();
		
		if(totInqCount != 0) 
		{
			int startRow  = (pageNum - 1) * MAXSIZE +1 ;
			
			map.put("maxSize" , MAXSIZE);
			map.put("startRow", startRow);
			
			if("id".equals(cmb)) {

				inqList = inqQebc.mngInqIdSelect(map);
			}
			else if("at".equals(cmb))
			{
				inqList = inqQebc.mngInqAnswerAtSelect(map);
			}
		}

		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totInqCount, 5, MAXSIZE);

		
		resMap.put("inqList", inqList);
		resMap.put("totInqCount", totInqCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));
		
		return resMap;
	}
	@Override
	public Map<String, Object> bizMngSelect(int pageNum) {
		final int MAXSIZE = 10;
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> resMap = new HashMap<String, Object>();

		List<MberInqDTO> inqList = null;
		
		int totInqCount = inqQebc.countInq();
		if(totInqCount != 0) 
		{
			int startRow  = (pageNum - 1) * MAXSIZE +1 ;
			
			map.put("maxSize" , MAXSIZE);
			map.put("startRow", startRow);
			
			inqList = inqQebc.mngInqSelectAll(map);
		}
		
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totInqCount, 5, MAXSIZE);
		
		
		resMap.put("inqList", inqList);
		resMap.put("totInqCount", totInqCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));
		
		return resMap;
	}
	@Override
	public MberInqJoinDTO bizAnswerForm(String inqryNo) {
		
		MberInqJoinDTO dto = inqQebc.inqAnswerForMng(inqryNo);
		return dto;
	}
	@Override
	public MberInqDTO bizAnswerSelect(String inqryNo) {
		int no = Integer.parseInt(inqryNo);
		MberInqDTO dto = inqQebc.answerFind(no);
		return dto;
	}
	@Override
	public List<MberInqDTO> bizSelectForMng1() {
		List<MberInqDTO> list = inqQebc.selectForMng();
		return list;
	}
}
