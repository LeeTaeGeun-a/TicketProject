package com.spring.project;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("advnBiz")
public class AdvantkBizImpl implements AdvantkBiz{
	
	@Autowired
	AdvantkDAO 	 advantkDao;
	
	@Autowired
	AdvantkQebc  advantkQebc;
	
	@Autowired
	PblprfrQebc  pblQebc;
	
	@Autowired
	PblprfrDAO   pblDao;
	
	@Autowired
	ScrinngDAO   scrinngDao;
	
	@Autowired
	ScrinngQebc  scrinngQebc;
	
	@Autowired
	ScrinngRmDAO scrinngRmDao;
	
	@Autowired
	ScedSeatQebc scedSeatQebc;
	
	@Autowired
	ScedSeatDAO  scedSeatDao;
	
	@Autowired
	MberDAO		 mberDao;
	
	@Autowired
	CommonBiz	 commonBiz;
	
	
	@Override
	public Map<String,Object> bizAdvantkInsertForm(HttpSession session, AdvantkDTO advantkDto) {
		
		Map<String,Object> advntkMap = new HashMap<String,Object>();
		String mberId = (String) session.getAttribute("loginedId");
		String pblId  = advantkDto.getPblprfrId();
		String scrTime= advantkDto.getScrinngDt();
		
		// 공연정보 가져오기
		PblprfrJoinDTO pblJoinDto = pblQebc.selectJoinOne(pblId);
	
		// 좌석정보 가져오기
		ScedSeatDTO scedSeatDto = new ScedSeatDTO();
		scedSeatDto.setTheatId(pblJoinDto.getTheatId());
		scedSeatDto.setScrinngRmId(pblJoinDto.getScrinngRmId());
		scedSeatDto.setScrinngDt(advantkDto.getScrinngDt());
		List<ScedSeatDTO> scedSeatList = scedSeatQebc.selectForAdvntk(scedSeatDto);
		int maxRow = scedSeatQebc.selectMaxRow(scedSeatDto);
		int maxCol = scedSeatQebc.selectMaxCol(scedSeatDto);
		
		//회원정보 가져오기
		MberDTO mberDto = mberDao.selectOne(mberId);
		
		advntkMap.put("pblJoinDto", pblJoinDto);
		advntkMap.put("scrTime", scrTime);
		advntkMap.put("scedSeatList", scedSeatList);
		advntkMap.put("mberDto", mberDto);
		advntkMap.put("maxRow", maxRow);
		advntkMap.put("maxCol", maxCol);
			
		return advntkMap;
	}

	@Transactional
	@Override
	public Map<String,Object> bizAdvantkInsert(AdvantkDTO advantkDto, List<String> ckedSeats) {
		
		int res = 0;
		Map<String ,Object> resMap = new HashMap<String,Object>();
		resMap.put("res", res);

		//현재 시간 구해서 예매일시 넣기
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd/HH:mm");
		String now = dateformat.format(new Date());
		
		//공연 ID를 이용해 극장 ID 상영관ID 등 가져오기
		PblprfrJoinDTO pblJoinDto = pblQebc.selectJoinOne(advantkDto.getPblprfrId());
		
		//좌석스케줄 좌석상태 수정 을 위한 dto
		ScedSeatDTO scedSeatDto = new ScedSeatDTO();
		scedSeatDto.setTheatId		(pblJoinDto.getTheatId());
		scedSeatDto.setScrinngRmId	(pblJoinDto.getScrinngRmId());
		scedSeatDto.setScrinngDt	(advantkDto.getScrinngDt());
		
		for(String ckSeat : ckedSeats)
		{
			String ckSeatArr[] = ckSeat.split("-");
			String row = ckSeatArr[0];
			String col = ckSeatArr[1];
				
			//좌석스케줄 상태 업데이트
			scedSeatDto.setSeatRow(row);
			scedSeatDto.setSeatCol(col);
			ScedSeatDTO ckScedSeatDto = scedSeatDao.selectOne(scedSeatDto);
			if(ckScedSeatDto == null)
			{
				// 에러발생;
				return resMap;
			}
			ckScedSeatDto.setAdvnAt("N");
			scedSeatDao.update(ckScedSeatDto);
		}	
		
		//예매인서트 처리 
		String seats="";
		for(int i=0 ;i<ckedSeats.size();i++)
		{
			seats = seats+ckedSeats.get(i);
			if(i != ckedSeats.size()-1) {
				seats =  seats + ",";
			}
			
		}

		String advantkId = advantkQebc.getMaxAdvantkId();
		if(advantkId == null)
		{
			advantkId = "1";
		}
		else 
		{
			int advId = Integer.parseInt(advantkId);
			advId = advId +1;
			advantkId = String.valueOf(advId);
		}
		
		advantkDto.setAdvantkId(advantkId);
		advantkDto.setAdvantkDt(now);
		advantkDto.setAdvantkSeats(seats);
		advantkDto.setAdvantkNmrs(ckedSeats.size());
		advantkDto.setAdvantkSt("F");
		
		AdvantkDTO ckAdvanDto = advantkDao.selectOne(advantkId);
		if(ckAdvanDto != null)
		{
			// 에러발생;
			return resMap;
		}
		advantkDao.insert(advantkDto);
		
		
		//상연의 사용가능 좌석수 수정 을 위한 Dto
		ScrinngDTO scrDto = new ScrinngDTO();
		scrDto.setPblprfrId(advantkDto.getPblprfrId());
		scrDto.setScrinngDt(advantkDto.getScrinngDt());
		
		//상연 이용가능 좌석수 업데이트 처리
		ScrinngDTO ckScrDto = scrinngDao.selectOne(scrDto);
		
		if(ckScrDto == null)
		{
			//에러발생;
			return resMap;
		}
		int useAbleSeatNum = ckScrDto.getUseAbleSeatNum();
		useAbleSeatNum = useAbleSeatNum - ckedSeats.size();
		ckScrDto.setUseAbleSeatNum(useAbleSeatNum);
		scrinngDao.update(ckScrDto);
		
		resMap.put("res", 1);
		resMap.put("advantkId", advantkId);
		
		return resMap;
	}

	@Override
	public Map<String, Object> bizSelectForUser(String mberId, int pageNum) {
		
		final int MAXSIZE = 10;
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		map.put("mberId", mberId);
		
		List<AdvantkJoinDTO> totAdvantkList = advantkQebc.selectForUser(map);
		List<AdvantkJoinDTO> advantkList    = null;
		
		int totAdvantkCount = totAdvantkList.size();
		if(totAdvantkCount != 0) 
		{
			int startRow  = (pageNum - 1) * MAXSIZE +1 ;
			
			map.put("maxSize" , MAXSIZE);
			map.put("startRow", startRow);
			
			advantkList = advantkQebc.selectForUser(map);
		}
		if(advantkList != null)
		{
			// 취소가능 날짜 처리 로직
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
			Calendar calendar = Calendar.getInstance();
			List<String> cclPsDate = new ArrayList<String>();
			for(AdvantkJoinDTO joinDto : advantkList) 
			{
				String scrinngDt = joinDto.getScrinngDt();
				String scrDtArr[] = scrinngDt.split("/");
				String scrDate = scrDtArr[0];
				
				try{
					calendar.setTime(sdf.parse(scrDate));
					calendar.add(Calendar.DATE, -1); //하루빼기
					String canclePsdate = sdf.format(calendar.getTime());
					cclPsDate.add(canclePsdate);
				}catch(ParseException e) {
					e.printStackTrace();
				}
				
			}
			resMap.put("cclPsDate", cclPsDate);
		}
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totAdvantkCount, 5, MAXSIZE);
		
		
		resMap.put("advantkList", advantkList);
		resMap.put("totAdvantkCount", totAdvantkCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));
		
		return resMap;
	}

	@Override
	public Map<String,Object> bizSelectAdtkDetail(String advantkId) {
		
		Map<String,Object>  tkDetailMap = new HashMap<String,Object>();
		
		AdvantkDTO advantkDto = advantkDao.selectOne(advantkId);
		String pblId = advantkDto.getPblprfrId();
		PblprfrJoinDTO pblJoinDto = pblQebc.selectJoinOne(pblId);
		MberDTO mberDto = mberDao.selectOne(advantkDto.getMberId());
		ScrinngRmDTO scrRmDto = new ScrinngRmDTO();
		scrRmDto.setTheatId(pblJoinDto.getTheatId());
		scrRmDto.setScrRmId(pblJoinDto.getScrinngRmId());
		scrRmDto = scrinngRmDao.selectOne(scrRmDto);
		
		// 취소가능 날짜 처리 로직
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		Calendar calendar = Calendar.getInstance();
		String canclePsdate=null;
		try {
			String scrinngDt  = advantkDto.getScrinngDt();
			String scrDtArr[] = scrinngDt.split("/");
			String scrDate = scrDtArr[0];		
			calendar.setTime(sdf.parse(scrDate));
			calendar.add(Calendar.DATE, -1); //하루빼기
			canclePsdate = sdf.format(calendar.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}					
						
				
		tkDetailMap.put("canclePsDate", canclePsdate);
		tkDetailMap.put("advantkDto", advantkDto);
		tkDetailMap.put("pblJoinDto", pblJoinDto);
		tkDetailMap.put("scrRmDto", scrRmDto);
		tkDetailMap.put("mberDto"   , mberDto);
		
		return tkDetailMap;
	}

	@Transactional
	@Override
	public int bizCancleAdvantk(String advantkId) {
		
		final int FAILPK     = 0;
		final int SUCCESS	 = 1;
		final int FAILTODATE = 2;
		
		// pk로 데이터 존재하는지 체크
		AdvantkDTO advantkDto = advantkDao.selectOne(advantkId);
		if(advantkDto == null)
		{
			return FAILPK;
		}
		
		// 현재 날짜와 취소 가능 날짜 비교 하기
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		Calendar calendar = Calendar.getInstance();
		String now = sdf.format(new Date());
		String scrinngDt = advantkDto.getScrinngDt();
		scrinngDt = scrinngDt.substring(0, 10);
		
		try{
			calendar.setTime(sdf.parse(scrinngDt));
			calendar.add(Calendar.DATE, -1); //하루빼기
			String canclePsdate = sdf.format(calendar.getTime());
			Date nowDate  = sdf.parse(now);
			Date ccPsDate = sdf.parse(canclePsdate);
			long gap = ccPsDate.getTime()-nowDate.getTime();
			long gapNum= gap/(24*60*60*1000);
		
			if(gapNum < 0)
			{
				return FAILTODATE;
			}
			
		}catch(ParseException e) {
			e.printStackTrace();
		}
		
		//예매 취소 처리
		advantkDto.setAdvantkSt("C");
		advantkDao.update(advantkDto);
		
		//공연 ID를 이용해서 극장 ID, 상영관  ID가져오기
		PblprfrJoinDTO pblJoinDto = pblQebc.selectJoinOne(advantkDto.getPblprfrId());
		
		//좌석스케줄  좌석상태 변경하기
		ScedSeatDTO scedSeatDto = new ScedSeatDTO();
		scedSeatDto.setTheatId(pblJoinDto.getTheatId());
		scedSeatDto.setScrinngRmId(pblJoinDto.getScrinngRmId());
		scedSeatDto.setScrinngDt(advantkDto.getScrinngDt());
		
		String seats = advantkDto.getAdvantkSeats();
		String seatsArr[] = seats.split(",");
		for(int i=0; i<seatsArr.length ; i++)
		{
			String seatRC[] = seatsArr[i].split("-");
			String row = seatRC[0];
			String col = seatRC[1];
			
			scedSeatDto.setSeatRow(row);
			scedSeatDto.setSeatCol(col);
			
			ScedSeatDTO ckScSeDto = scedSeatDao.selectOne(scedSeatDto);
			if(ckScSeDto == null )
			{
				return FAILPK;
			}
			
			ckScSeDto.setAdvnAt("Y");
			scedSeatDao.update(ckScSeDto);
		}
		
		//상영관 사용가능좌석수 수정 하기
		ScrinngDTO scrDto = new ScrinngDTO();
		scrDto.setPblprfrId(advantkDto.getPblprfrId());
		scrDto.setScrinngDt(advantkDto.getScrinngDt());
		ScrinngDTO ckScrDto = scrinngDao.selectOne(scrDto);
		if(ckScrDto == null)
		{
			return FAILPK;
		}
		int useAbleSeatNum = ckScrDto.getUseAbleSeatNum();
		useAbleSeatNum = useAbleSeatNum + seatsArr.length;
		ckScrDto.setUseAbleSeatNum(useAbleSeatNum);
		scrinngDao.update(ckScrDto);
		
		return SUCCESS;
	}

	@Override
	public Map<String, Object> bizSelectForAdmin(int pageNum,String condition, String sWord) {
		
		final int MAXSIZE = 10;
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> resMap = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("sWord", sWord);
		if("period".equals(condition))
		{
			map.put("sWord",sWord+"%");
		}
			
		List<AdvantkJoinDTO> totAdvantkList = advantkQebc.selectForAdmin(map);
		List<AdvantkJoinDTO> advantkList    = null;
		
		int totAdvantkCount = totAdvantkList.size();
		if(totAdvantkCount != 0) 
		{
			int startRow  = (pageNum - 1) * MAXSIZE +1 ;
			
			map.put("maxSize" , MAXSIZE);
			map.put("startRow", startRow);
			
			advantkList = advantkQebc.selectForAdmin(map);
		}
		
		Map<String,Object> resPaging = commonBiz.bizPaging(pageNum, totAdvantkCount, 5, MAXSIZE);
		
		
		resMap.put("advantkList", advantkList);
		resMap.put("totAdvantkCount", totAdvantkCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));
		
		return resMap;
	}

	@Transactional
	@Override
	public int closeProc() {
		
		//현재 시간 구해오기
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd/HH:mm");
		String now = dateformat.format(new Date());
		
		List<AdvantkDTO> advantkList = advantkQebc.selectForClose(now);
		if(advantkList != null)
		{
			for(AdvantkDTO advanDto : advantkList)
			{
				advanDto.setAdvantkSt("E");
				advantkDao.update(advanDto);
			}
		}
		
		List<ScrinngDTO> scrList = scrinngQebc.selectForClose(now);
		if(scrList != null)
		{
			for(ScrinngDTO scrDto : scrList)
			{
				scrDto.setScrinngAt("N");
				scrinngDao.update(scrDto);
			}
		}
		
		now = now.substring(0, 10);
		List<PblprfrDTO> pblList = pblQebc.selectForClose(now);
		if(pblList != null)
		{
			for(PblprfrDTO pblDto : pblList)
			{
				pblDto.setPblprfrAt("N");
				pblDao.update(pblDto);
			}
		}
			
		return 1;
	}

	@Override
	public List<AdvantkJoinDTO> bizSelectForMng() {
		List<AdvantkJoinDTO> advantkList = advantkQebc.selectForMng();
		return advantkList;
	}

}
