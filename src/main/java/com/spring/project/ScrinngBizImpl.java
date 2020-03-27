package com.spring.project;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("scrBiz")
public class ScrinngBizImpl implements ScrinngBiz {
	
	@Autowired
	ScrinngDAO 	scrinngDao;
	@Autowired
	ScrinngQebc scrinngQebc;
	@Autowired
	PblprfrDAO 	pblDao;
	@Autowired
	SeatQebc   	seatQebc;
	@Autowired
	ScedSeatDAO scedSeatDao;
	@Autowired
	AdvantkQebc advantkQebc;
	@Autowired
	AdvantkDAO	advantkDao;
	@Autowired
	CommonBiz 	commonBiz;
	
	@Override
	public HashMap<String,Object> bizSelectForManage(String pblId,int pageNum ,String searchDate) {
		final int MAXSIZE = 10; // 상연테이블 한페이지당 상연정보 보여줄 갯수
		
		
		//달력에 기간 세팅하기 위한 처리
		PblprfrDTO pblDto = pblDao.selectOne(pblId);
		String period = pblDto.getPeriod();
		String spPeriod[] = period.split("~");

		int resMinDate = commonBiz.calDate(spPeriod[0]);
		int resMaxDate = commonBiz.calDate(spPeriod[1]);
		
		//상연 조회 처리
		HashMap<String,Object> scrMap 	 = new HashMap<String,Object>();
		HashMap<String,Object> resMap 	 = new HashMap<String,Object>();
		ArrayList<ScrinngDTO> scrList 	 = null;
		
		scrMap.put("pblId", pblId);
		if(!("all".equals(searchDate))){
			searchDate = searchDate+"%";
		}
		scrMap.put("searchDate", searchDate);
		ArrayList<ScrinngDTO> totScrList = (ArrayList<ScrinngDTO>) scrinngQebc.selectForManage(scrMap); // 총 검색된 수를 구하기 위한 것
		
		int totScrCount = totScrList.size();
		
		if(totScrCount != 0)
		{
			int startRow = (pageNum -1) * MAXSIZE +1;
			scrMap.put("maxSize"	, MAXSIZE);
			scrMap.put("startRow"	, startRow);
			scrList = (ArrayList<ScrinngDTO>) scrinngQebc.selectForManage(scrMap);
		}
		
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totScrCount, 5, MAXSIZE);
		
		resMap.put("maxDate", resMaxDate);
		resMap.put("minDate", resMinDate);
		resMap.put("scrList", scrList);
		resMap.put("totScrCount", totScrCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));
		
		
		return  resMap;
	}

	@Override
	public Map<String, Object> bizSelectDateForUser(String pblId, String pickedDate) {
		
		
		// 선택된 날짜를 데이터베이스 와 비교하기위해서 형식을 바꾸는 로직
		String cYear  	= pickedDate.substring(0, 4);
		String cMonth 	= pickedDate.substring(5, 7);
		String cDay		= pickedDate.substring(8,10);
		String cDate	= cYear+cMonth+cDay;
		
		Map<String,Object> map = new HashMap<String,Object>();
		List<ScrinngDTO> list = scrinngQebc.selectForUser(pblId);
		
		// 날짜가 일치할경우 시간값만 반환하기 위한 List
		List<String> scrTimeList = new ArrayList<String>();
		
		for(ScrinngDTO scrDto : list)
		{
			String gDate  = scrDto.getScrinngDt();
			String gYear  = gDate.substring(0,  4);
			String gMonth = gDate.substring(5,  7);
			String gDay	  = gDate.substring(8, 10);
			String gTime  = gDate.substring(11	 );
			gDate = gYear + gMonth + gDay;
			
			if(gDate.equals(cDate))
			{
				int num = scrDto.getUseAbleSeatNum(); 
				String seatNum = String.valueOf(num);
				scrTimeList.add(gTime + " "+ "잔여석:"  + seatNum);
			}	
			
		}
		map.put("scrTimeList", scrTimeList);
		
		return map;
	}
	
	
	@Transactional
	@Override
	public int bizUpdateAt(String pblId, List<String> scrinngDtList) {
		
		final int SUCCESS =1;
		final int FAIL    =0;
		
		ScrinngDTO scrDto = new ScrinngDTO();
		scrDto.setPblprfrId(pblId);
		for(String scrDate : scrinngDtList)
		{
			scrDto.setScrinngDt(scrDate);
			ScrinngDTO ckDto = scrinngDao.selectOne(scrDto);
			
			if(ckDto == null)
			{
				return FAIL;
			}
			
			String scrAt = ckDto.getScrinngAt();
			if("Y".equals(scrAt)) scrAt = "N";
			else if("N".equals(scrAt)) scrAt = "Y";
			ckDto.setScrinngAt(scrAt);
	
			if("N".equals(scrAt))
			{	
				// 상연 취소시 예매된것들이 있으면 취소시키기
				Map<String,Object> map = new HashMap<String,Object>();
				map.put("pblprfrId", pblId);
				map.put("scrinngDt", scrDate);
				List<AdvantkDTO> advantkList = advantkQebc.selectForCancle(map);
				
				// 좌석 상태 변경을 위한 dto 생성
				ScedSeatDTO scedSeatDto = new ScedSeatDTO();
				PblprfrDTO pblDto = pblDao.selectOne(pblId);
				String theatId = pblDto.getTheatId();
				String scrRmId = pblDto.getScrinngRmId();
				
				scedSeatDto.setTheatId(theatId);
				scedSeatDto.setScrinngRmId(scrRmId);
				scedSeatDto.setScrinngDt(scrDate);
				
				if(advantkList != null)
				{	
					
					for(AdvantkDTO advDto : advantkList)
					{
						
						if("F".equals(advDto.getAdvantkSt()))
						{
							advDto.setAdvantkSt("C");
							advantkDao.update(advDto);
							
							// 예약됐던 좌석 모두 'Y'로 변경
							String seats = advDto.getAdvantkSeats();
							String seatArr[] = seats.split(",");
							
							for(int i=0; i<seatArr.length;i++)
							{
								String seatRC[] = seatArr[i].split("-");
								String row = seatRC[0];
								String col = seatRC[1];
								
								scedSeatDto.setSeatRow(row);
								scedSeatDto.setSeatCol(col);
								
								ScedSeatDTO ckSeatDto = scedSeatDao.selectOne(scedSeatDto);
								if(ckSeatDto == null)
								{
									return FAIL;
								}
								ckSeatDto.setAdvnAt("Y");
								scedSeatDao.update(ckSeatDto);
							}
							
							int seatNum = ckDto.getUseAbleSeatNum();
							seatNum += seatArr.length;
							ckDto.setUseAbleSeatNum(seatNum);
						}	
					}
					
				}

			}
			
			// 상연 상태 변경
			scrinngDao.update(ckDto);
			
		}
		
		return SUCCESS;
	}

	@Transactional
	@Override
	public int bizInsertOneDate(String pblId, String scrDate, List<String> scrTimeList) {
		
		final int FAILSEAT=0;
		final int SUCCESS =1;
		final int FAILPK  =2;
		
		//사용가능 좌석수를 가져오기 위한 로직
		PblprfrDTO pblDto = pblDao.selectOne(pblId);
		String theatId = pblDto.getTheatId();
		String scrRmId = pblDto.getScrinngRmId();
		
		List<SeatDTO> seatList = seatQebc.selectUseY(theatId, scrRmId);
		
		int usefulSeatCount = seatList.size();
		
		if(usefulSeatCount == 0)
		{
			return FAILSEAT;
		}
		
		//---------------------------------------------------------------------
		ScrinngDTO scrDto = new ScrinngDTO();
		ScedSeatDTO scedSeatDto = new ScedSeatDTO();
		scrDto.setPblprfrId(pblId);
		for(String time : scrTimeList)
		{
				
			String scrDt = scrDate + "/" + time;
			scrDto.setScrinngDt(scrDt);

			ScrinngDTO checkDto =  scrinngDao.selectOne(scrDto);
			if(checkDto != null)
			{
				return FAILPK ;
			}
			scrDto.setUseAbleSeatNum(usefulSeatCount);
			scrDto.setScrinngAt("Y");
			scrinngDao.insert(scrDto);
			
			//좌석 스케즐 인서트---------------------------------------------
			for(SeatDTO seatDto : seatList)
			{
				scedSeatDto.setPblprfrId(pblId);
				scedSeatDto.setTheatId(theatId);
				scedSeatDto.setScrinngRmId(scrRmId);
				scedSeatDto.setScrinngDt(scrDt);
				scedSeatDto.setSeatRow(seatDto.getSeatRow());
				scedSeatDto.setSeatCol(seatDto.getSeatCol());
				scedSeatDto.setAdvnAt("Y");
				
				ScedSeatDTO ckScedSeatDto = scedSeatDao.selectOne(scedSeatDto);
				if(ckScedSeatDto != null)
				{
					return FAILPK;
				}
				scedSeatDao.insert(scedSeatDto);
			}
			//-----------------------------------------------------
		}
		
		return SUCCESS;
	}

	@Override
	public int bizInsertPeriod(String pblId, String startDate, String endDate, List<String> scrTimeList) {
		
		final int FAILSEAT=0;
		final int SUCCESS =1;
		final int FAILPK  =2;
		
		PblprfrDTO pblDto = pblDao.selectOne(pblId);
		String theatId = pblDto.getTheatId();
		String scrRmId = pblDto.getScrinngRmId();
		
		List<SeatDTO> seatList = seatQebc.selectUseY(theatId, scrRmId);
		
		int usefulSeatCount = seatList.size();
		if(usefulSeatCount == 0)
		{
			return FAILSEAT;
		}
		//기간처리 로직
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy.mm.dd");
			
			Date start = format.parse(startDate);
			Date end   = format.parse(endDate);	
			
			long calDate = start.getTime() - end.getTime();
			long calDateDays = calDate / (24*60*60*1000);
			calDateDays = Math.abs(calDateDays);
			
			ScrinngDTO scrDto = new ScrinngDTO();
			ScedSeatDTO scedSeatDto = new ScedSeatDTO();
			scrDto.setPblprfrId(pblId);
			for(int i = 0; i< calDateDays+1;i++)
			{
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(start);
				calendar.add(Calendar.DATE,i);
				Date date= calendar.getTime();
				String scrDate = format.format(date);
				
				for(String time : scrTimeList)
				{
						
					String scrDt = scrDate + "/" + time;
					scrDto.setScrinngDt(scrDt);

					ScrinngDTO checkDto =  scrinngDao.selectOne(scrDto);
					if(checkDto != null)
					{
						return FAILPK ;
					}
					scrDto.setUseAbleSeatNum(usefulSeatCount);
					scrDto.setScrinngAt("Y");
					scrinngDao.insert(scrDto);
					
					//좌석 스케즐 인서트---------------------------------------------
					for(SeatDTO seatDto : seatList)
					{
						scedSeatDto.setPblprfrId(pblId);
						scedSeatDto.setTheatId(theatId);
						scedSeatDto.setScrinngRmId(scrRmId);
						scedSeatDto.setScrinngDt(scrDt);
						scedSeatDto.setSeatRow(seatDto.getSeatRow());
						scedSeatDto.setSeatCol(seatDto.getSeatCol());
						scedSeatDto.setAdvnAt("Y");
						
						ScedSeatDTO ckScedSeatDto = scedSeatDao.selectOne(scedSeatDto);
						if(ckScedSeatDto != null)
						{
							return FAILPK;
						}
						scedSeatDao.insert(scedSeatDto);
					}
					//-----------------------------------------------------
				}
			}
		} catch (ParseException e) {
		
			e.printStackTrace();
		}
		
		//-----------
		return SUCCESS;
	}

	@Override
	public Map<String,Object> bizSelectForMng() {
		
		Map<String,Object> hm = new HashMap<String,Object>();
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd/HH:mm");
		Calendar time = Calendar.getInstance();
		
		String crtTime = format1.format(time.getTime());
		
		List<ScrinngJoinDTO> scrinngJoinDto = scrinngQebc.selectForMng(crtTime);
		
		int count = scrinngJoinDto.size();
		
		for(int i=0 ; i < (count-3);i++)
		{
		scrinngJoinDto.remove(0);
		}
		
		hm.put("count",count );
		hm.put("scrinngJoinDto",scrinngJoinDto );
		
		return hm;
	}
	
	

	


}
