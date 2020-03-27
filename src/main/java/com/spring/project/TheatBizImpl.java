package com.spring.project;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component("tBiz")
public class TheatBizImpl implements TheatBiz {

	@Autowired
	TheatDAO      theatDao;
	@Autowired
	TheatQebc     theatQebc;
	@Autowired
	CommonBiz     commonBiz;
	@Autowired
	ScrinngRmDAO  scrinngRmDao;
	@Autowired
	ScrinngRmQebc scrinngRmQebc;
	@Autowired
	SeatDAO       seatDao;
	@Autowired
	SeatQebc      seatQebc;
	
	
	final int MAXCNT = 5; // 한 페이지에 보여줄 극장 수 
	
	@Override
	public TheatDTO bizSelectOne(String theatId) {
		
		TheatDTO theatDto = theatDao.selectOne(theatId);
		
		return theatDto;
	}


	@Override
	public HashMap<String,Object> bizSelectNm(String searchWord, int pageNum) {
		
		HashMap<String,Object> voMap  = new HashMap<String,Object>();
		HashMap<String,Object> resMap = new HashMap<String,Object>();
		
		voMap.put("searchWord", searchWord+"%");
		List<TheatDTO> totTheatList = theatQebc.selectNm(voMap);
		List<TheatDTO> theatList = null;
		
		
		int totTheatCount = totTheatList.size();
		
		if(totTheatCount != 0)
		{
			int startRow  = (pageNum - 1) * MAXCNT +1 ;
			voMap.put("startRow", startRow);
			voMap.put("maxCnt", MAXCNT);
			theatList = theatQebc.selectNm(voMap);		
		}
		
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totTheatCount, 5, MAXCNT);
		
		resMap.put("theatList", theatList);
		resMap.put("totTheatCount", totTheatCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage"  , resPaging.get("endPage"));
		
		return resMap;
	}


	@Override
	public HashMap<String,Object> bizSelectLoc(String searchWord, int pageNum) {
		
		HashMap<String,Object> voMap  = new HashMap<String,Object>();
		HashMap<String,Object> resMap = new HashMap<String,Object>();
		
		voMap.put("searchWord", searchWord+"%");
		List<TheatDTO> totTheatList = theatQebc.selectLoc(voMap);
		List<TheatDTO> theatList = null;
		
		int totTheatCount = totTheatList.size();
		
		if(totTheatCount != 0)
		{
			int startRow  = (pageNum - 1) * MAXCNT +1 ;
			voMap.put("startRow", startRow);
			voMap.put("maxCnt", MAXCNT);
			theatList = theatQebc.selectLoc(voMap);		
		}
		
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totTheatCount, 5, MAXCNT);
		
		resMap.put("theatList", theatList);
		resMap.put("totTheatCount", totTheatCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage"  , resPaging.get("endPage"));
		
		return resMap;
	}
	
	@Override
	public List<TheatDTO> bizSelectAll() {

		List<TheatDTO> array = theatQebc.selectAll();
		
		return array;
	}


	@SuppressWarnings("null")
	@Override
	@Transactional
	public int bizInsert(TheatDTO dto ,String[] scrRmNm,String[] totSeat,String[] seatRow,String[] seatCol) {
		int cnt = 0;
        String maxNum = theatQebc.maxNum();
        int id = 1;
        if(maxNum==null)
        {}
        else 
        {
          id = Integer.parseInt(maxNum)+1;      	
        }
        
		String theatId =  String.valueOf(id);
		
		try {
		
		TheatDTO oneDto = theatDao.selectOne(theatId);
		
		if(oneDto==null)
		{
			dto.setTheatId(theatId);
			dto.setBizQitAt("Y");
			theatDao.insert(dto);
			
			ScrinngRmDTO scrRmDto = new ScrinngRmDTO();
			String maxNumScr = null;
			int sScrRmId = 1;
			
			SeatDTO seatDto = new SeatDTO();
			
			for(int i = 0; i < scrRmNm.length; i++)
			{
				System.out.println(scrRmNm.length);
				maxNumScr = scrinngRmQebc.maxNum(theatId);
		        if(maxNumScr==null)
		        {}
		        else 
		        {
		        	sScrRmId = Integer.parseInt(maxNumScr)+1;      	
		        }
		        
				String scrRmId =  String.valueOf(sScrRmId);
				
				scrRmDto.setTheatId(theatId);
				scrRmDto.setScrRmId(scrRmId);
				scrRmDto.setScrRmNm(scrRmNm[i]);
				scrRmDto.setTotSeat(Integer.parseInt(totSeat[i]));	
				ScrinngRmDTO scrRmDto1 = scrinngRmDao.selectOne(scrRmDto);
				
				if(scrRmDto1==null)
				{
					scrRmDto.setClsAt("Y");
					
					scrinngRmDao.insert(scrRmDto);
					
					seatDto.setTheatId(theatId);
					seatDto.setScrRmId(scrRmId);
					seatDto.setUsefulAt("Y");
					
				    int totSeatCnt = 0;	
						
						for(int row=0; row < Integer.parseInt(seatRow[i]); row++)
						{
						if(totSeatCnt>=Integer.parseInt(totSeat[i])) {
							break; 
						}
						for(int col=0; col < Integer.parseInt(seatCol[i]); col++)
						{
						if(totSeatCnt>=Integer.parseInt(totSeat[i])) {
							break; 
						}
						else {
						totSeatCnt ++;	
						seatDto.setSeatRow(String.valueOf(row+1));
						seatDto.setSeatCol(String.valueOf(col+1));
						}
						SeatDTO seatDto1 = seatDao.selectOne(seatDto);
						
						if(seatDto1==null)
						{
							seatDao.insert(seatDto);
							cnt=1;
						}
						else if(seatDto1!=null)
						{
							cnt=0;
							return cnt;
						}
						}
					}
				}
				else if(scrRmDto1!=null)
				{
					cnt=0;
					return cnt;
				}
			}
		}
		else if(oneDto!=null)
		{
			cnt=0;
			return cnt;
		}
		}catch (Exception e) {
			cnt=0;
			return cnt;
		}
		
		return cnt;
	}

	@Override
	public TheatDTO bizUpdateForm(int id) {
		String theatId = String.valueOf(id);
		TheatDTO uDto = theatDao.selectOne(theatId);
		return uDto;
	}


	@Override
	@Transactional
	public int bizUpdate(TheatDTO dto) {
		int cnt = 0;
        
		String theatId =  dto.getTheatId();
		
		TheatDTO oneDto = theatDao.selectOne(theatId);
		
		if(oneDto!=null)
		{
			theatDao.update(dto);
			cnt =1;
		}
		else if(oneDto==null)
		{
		}
		
		return cnt;
	}

}
