package com.spring.project;

import java.io.File;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service("pblBiz")
public class PblprfrBizImpl implements PblprfrBiz{
	
	@Autowired
	PblprfrDAO	pblDao;
	@Autowired
	PblprfrQebc	pblQebc;
	@Autowired
	ScrinngQebc scrinngQebc;
	@Autowired
	IntrstDAO 	intrstDao; 
	@Autowired
	CommonBiz commonBiz;
	
	final int MAXSIZE = 10; // 한 페이지에 보여줄 공연 수 

	
	public PblprfrBizImpl() {}
	
	public PblprfrDTO bizSelectOne(String pblprfrId)
	{
		PblprfrDTO pblDto = pblDao.selectOne(pblprfrId);
		
		return pblDto;
	}
	
	@Override
	public PblprfrJoinDTO bizSelectJoinOne(String pblprfrId) {
		
		PblprfrJoinDTO pblJoinDto = pblQebc.selectJoinOne(pblprfrId);
		
		return pblJoinDto;
	}
	
	
	@Override
	public HashMap<String,Object> bizSelectOneForManage(String pblprfrId) {
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		PblprfrJoinDTO pblJoinDto = pblQebc.selectJoinOne(pblprfrId);
		
		HashMap<String,String> periodMap = commonBiz.procPeriod(pblJoinDto.getPeriod());
		String startDate = periodMap.get("startDate");
		String endDate   = periodMap.get("endDate");
		
		map.put("startDate" 	, startDate);
		map.put("endDate"  	 	, endDate);
		map.put("pblJoinDto"	, pblJoinDto);
		
		return map;
	}

	@Override
	public HashMap<String,Object> bizSelectOneForUser(String pblprfrId , HttpSession session) {
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		PblprfrJoinDTO pblJoinDto = pblQebc.selectJoinOne(pblprfrId);
		//등급 한글로 전환 로직
		String grade = pblJoinDto.getGrade();
		switch(grade)
		{
			case "A":
				grade = "전체이용가";
			case "T":
				grade = "12세이용가";
			case "F":
				grade = "15세이용가";
			case "N":
				grade = "성인등급";	
		}
		pblJoinDto.setGrade(grade);
		//------------------------------
		
		String minDate = scrinngQebc.getMinDate(pblprfrId);
		String maxDate = scrinngQebc.getMaxDate(pblprfrId);
		
		int resMinDate = commonBiz.calDate(minDate);
		int resMaxDate = commonBiz.calDate(maxDate);
		
		//추천공연 목록 뽑아오는 메서드
		List<PblprfrJoinDTO> recomendPblList = getRecomendList(pblJoinDto.getTheatId(), pblJoinDto.getPblprfrId());
		
		//해당 연극이 찜 하기 선택되었는지 확인하는 로직
		String id = (String) session.getAttribute("loginedId");
		int instRes = 0;
		if(id != null)
		{
			IntrstDTO intrstDto = new IntrstDTO();
			intrstDto.setMberId(id);
			intrstDto.setPblprfrId(pblprfrId);
			IntrstDTO checkDTO = intrstDao.selectOne(intrstDto);
			if(checkDTO != null)
			{
				instRes = 1;
			}
		}
		
		map.put("instRes", instRes);
		map.put("pblJoinDto", pblJoinDto);
		map.put("minDate", resMinDate);
		map.put("maxDate", resMaxDate);
		map.put("recomendPbl" , recomendPblList);		
		return map;
	}
	
	
	@Override
	public int insertForm() {
		
		String gMaxNum = pblQebc.maxNum();
		int maxNum = 0;
		
		if(gMaxNum != null)
		{
			maxNum = Integer.parseInt(gMaxNum);
			maxNum += 1; 
		}
		
		
		return maxNum;
	}

	@Override
	public int bizInsert(PblprfrDTO pblDto , HttpServletRequest requset) {
		
		int res = 0;
		
		PblprfrDTO ckPblDto = pblDao.selectOne(pblDto.getPblprfrId());
		if(ckPblDto != null)
		{
			return res;
		}
		
		try {
			// 기간 처리
			String period = commonBiz.procPeriod(pblDto.getStartPeriod(), pblDto.getEndPeriod());
			pblDto.setPeriod(period);
			
			// 이미지 업로드 처리
			pblDto = commonBiz.procImgUpload(pblDto,requset);
			pblDao.insert(pblDto);
			res = 1;
		}catch (Exception e) {
			res = 0;
		}
		
		return res;
	}


	@Override
	public int bizUpdate(PblprfrDTO pblDto, String ckTitleImg, String ckDetailImg , HttpServletRequest request) {
		
		int res = 0;
		
		String pblId = pblDto.getPblprfrId();
		
		PblprfrDTO ckPblDto = pblDao.selectOne(pblId);
		if(ckPblDto == null)
		{
			return res;
		}
		try 
		{
			// 기간처리
			String period = commonBiz.procPeriod(pblDto.getStartPeriod(), pblDto.getEndPeriod());
			pblDto.setPeriod(period);
			// 이미지 처리
			
			String originTitleImgLc  = ckPblDto.getTitleImgLc();
			String originDetailImgLc = ckPblDto.getDetailImgLc();
			
			MultipartFile upTitleImg  = pblDto.getTitleImg();
			MultipartFile upDetailImg = pblDto.getDetailImg();
			
			if(!(upTitleImg.isEmpty()) || (upTitleImg.isEmpty() && "delete".equals(ckTitleImg))) 
			{
				 deleteImgFile(originTitleImgLc,request);
			}
			
			if(!(upDetailImg.isEmpty()) || (upDetailImg.isEmpty() && "delete".equals(ckDetailImg)))
			{
				deleteImgFile(originDetailImgLc,request);
			}
			
			pblDto = commonBiz.procImgUpload(pblDto,request);

			if(originTitleImgLc != null && "noChange".equals(ckTitleImg))
			{
				pblDto.setTitleImgLc(originTitleImgLc);
			}
			if(originDetailImgLc != null && "noChange".equals(ckDetailImg))
			{
				pblDto.setDetailImgLc(originDetailImgLc);
			}
			
			pblDao.update(pblDto);
			res = 1;
		}
		catch(Exception e)
		{
			res = 0;
			e.printStackTrace();
		}	
		return res;
	}

	//추가한 메서드들
	
	@Override
	public Map<String,Object> bizSelectForHome() {
		int maxSize = 10; // 홈화면에서 보여줄 공연 갯수
		
		Map<String,Object> map = new HashMap<String,Object>();
		List<PblprfrJoinDTO> rankList = pblQebc.selectForRank(7);
		List<PblprfrJoinDTO> adRankList = pblQebc.selectForAdvanktkRank(maxSize);
		
		map.put("rankList", rankList);
		map.put("adRankList", adRankList);
		
		return map;
	}

	@Override
	public HashMap<String, Object> bizSelectList(String genre, String area, String schedule, String sWord ,int pageNum) {
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		HashMap<String, Object> voMap  = new HashMap<String, Object>();
		ArrayList<String> areaList     = new ArrayList<String>();
//		CommonBiz commonBiz = new CommonBiz();
		int totPblCount = 0;
		
		switch(genre) 
		{
		case "drama": 
			genre = "연극";	
			break;
		
		case "musical":
			genre = "뮤지컬";
			break;
		
		case "concert":
			genre = "콘서트";
			break;
		
		case "childdrama":
			genre = "아동극";
			break;

		default:
			break;
		}
		
		switch(area)
		{
		case "area01":
			areaList.add("경기%");
			areaList.add("서울%");
			break;
		
		case "area02":
			areaList.add("충청%");
			areaList.add("대전%");
			break;
			
		case "area03":
			areaList.add("경상%");
			areaList.add("대구%");
			areaList.add("부산%");
			break;
		
		case "area04":
			areaList.add("전라%");
			areaList.add("광주%");
			areaList.add("전주%");
			break;
			
		case "area05":
			area = "etc";
			break;
			
		default:
			break;
		
		}

		if(!("all".equals(sWord)))
		{
			sWord =sWord+"%";
		}
		voMap.put("sWord", sWord);
		voMap.put("genre", genre);
		voMap.put("area", area);
		voMap.put("areaList", areaList);
		
		// 날짜 처리 관련 로직
		if("all".equals(schedule))
		{
			voMap.put("date", schedule);
		}
		else
		{
			Calendar calendar = Calendar.getInstance();
			
			if("tomorrow".equals(schedule))
			{
				calendar.add(Calendar.DATE, 1);
			}
			
			int year  = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH)+1;
			int day	  = calendar.get(Calendar.DATE);
			String rMonth = String.valueOf(month);
			if(month<10) 
			{
				rMonth="0"+rMonth;
			}
			
			String date = String.valueOf(year)+"."+rMonth+"."+String.valueOf(day);
			voMap.put("date", date+"%");
		}
		
		List<PblprfrJoinDTO> totPblList = pblQebc.selectList(voMap); // 총 검색된 수를 구하기 위한 것
		List<PblprfrJoinDTO> pblList = null;
		
		totPblCount = totPblList.size();
		
		if(totPblCount != 0) 
		{
			int startRow  = (pageNum - 1) * MAXSIZE +1 ;
			
			voMap.put("maxSize" , MAXSIZE);
			voMap.put("startRow", startRow);
			
			pblList = pblQebc.selectList(voMap); // 진짜 화면에 뿌릴 거 가져오는 것
		}
		
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totPblCount, 5, MAXSIZE);
		
		resMap.put("pblList", pblList);
		resMap.put("totPblCount", totPblCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));

		return resMap;
	}


	@Override
	public HashMap<String,Object> bizSelectForManage(String sWord, int pageNum) {
		
		HashMap<String,Object> pblMap = new HashMap<String, Object>();
		HashMap<String,Object> dbMap  = new HashMap<String, Object>();
		int maxSize = 5;// 관리자 화면에서 검색시 보여줄 항목갯수
		int totPblCount = 0;
		if(!("all".equals(sWord)))
		{
			sWord = sWord + "%";
		}
		dbMap.put("sWord", sWord);
		List<PblprfrJoinDTO> totPblList = pblQebc.selectForManage(dbMap);
		List<PblprfrJoinDTO> pblList = null;
		totPblCount = totPblList.size();
		
		if(totPblCount != 0) 
		{
			int startRow  = (pageNum - 1) * maxSize +1 ;
			
			dbMap.put("maxSize" , maxSize);
			dbMap.put("startRow", startRow);
			
			pblList = pblQebc.selectForManage(dbMap); 
		}
		
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totPblCount, 5, maxSize);
		pblMap.put("pblList"	, pblList);
		pblMap.put("totPblCount", totPblCount);
		pblMap.put("pageCount"	, resPaging.get("pageCount"));
		pblMap.put("startPage"	, resPaging.get("startPage"));
		pblMap.put("endPage"	, resPaging.get("endPage"));
		
		return pblMap;
	}


	public void deleteImgFile(String imgFileLc, HttpServletRequest request)
	{
		
		if(imgFileLc == null) 
		{
			return;
		}
		String uploadPath = request.getSession().getServletContext().getRealPath("/resources/img"); 
		imgFileLc  = imgFileLc.substring(4);
		File imgFile = new File(uploadPath+imgFileLc);
		if(imgFile.exists())
		{
			imgFile.delete();
		}	
	}
	
	public List<PblprfrJoinDTO> getRecomendList(String theatId ,String pblId) {
		int maxSize = 4; // 추천화면에 보여줄 공연 갯수
		
		List<PblprfrJoinDTO> list = pblQebc.selectForRecomend(maxSize, theatId);
		
		for(int i=0; i <list.size();i++) 
		{
			PblprfrJoinDTO dto = list.get(i);
			if(pblId.equals(dto.getPblprfrId())) 
			{
				list.remove(i);
			}
			
		}
		
		return list;
	}

	

	
	
}
