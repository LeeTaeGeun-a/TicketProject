package com.spring.project;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("seatBiz1")
public class SeatBizImpl implements SeatBiz{
	
	@Autowired
	SeatDAO       seatDao;
	
	@Autowired
	SeatQebc      seatQebc;
	
	@Autowired
	ScrinngRmDAO  scrinngRmDao;
	
	@Autowired
	ScrinngDAO    scrinngDao;
	
	@Autowired
	ScedSeatDAO   scedSeatDao;
	
	@Autowired
	ScedSeatQebc  scedSeatQebc;

	@Override
	public List<SeatDTO> bizSelectAll(SeatDTO seatDto) {

		List<SeatDTO> array = seatQebc.selectAll(seatDto);
		
		return array;
	}

	@Transactional
	@SuppressWarnings("null")
	@Override
	public int bizUpdate(SeatDTO seatDto,String[] seatId) {
		int cnt = 0;
		String seatRow = null;
		String seatCol = null;
		String usefulAt = null;
		int    seatCnt  = 0 ;
		
		seatRow = seatId[0].split("_")[0];

		if("a".equals(seatRow))
		{
			cnt = 1;
			return cnt;
		}
		
		for(int i = 0; i< seatId.length ;i++) {
        
	    seatRow = seatId[i].split("_")[0];
	    seatCol = seatId[i].split("_")[1];
	    
		seatDto.setSeatRow(seatRow);
		seatDto.setSeatCol(seatCol);
			
		SeatDTO seatDto1 = seatDao.selectOne(seatDto);
		
		if(seatDto1!=null)
		   {
			
	        usefulAt = seatDto1.getUsefulAt();
			
			if("Y".equals(usefulAt))
			{
			seatDto.setUsefulAt("N");
			seatCnt = -1;
			}
			else if("N".equals(usefulAt))
			{
			seatDto.setUsefulAt("Y");	
			seatCnt = 1;
			}
			
			SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd/HH:mm");
			Calendar time = Calendar.getInstance();
			
			String crtTime = format1.format(time.getTime());
			
			String theatId1 = seatDto.getTheatId();
			String scrRmId1 = seatDto.getScrRmId();
			String seatCol1 = seatDto.getSeatCol();
			String seatRow1 = seatDto.getSeatRow();
			
			List<ScedSeatDTO> scdList = scedSeatQebc.selectAllcrtTime(theatId1,scrRmId1,seatCol1,seatRow1,crtTime);

			if(scdList != null)
			{
			ScrinngDTO scrinngDto = new ScrinngDTO();
		    for(ScedSeatDTO scedSeatDto:scdList)
		    {
		    	ScedSeatDTO scedSeatDto1 = scedSeatDao.selectOne(scedSeatDto);	  
		    	
		    	scrinngDto.setPblprfrId(scedSeatDto1.getPblprfrId());
		    	scrinngDto.setScrinngDt(scedSeatDto1.getScrinngDt());
		    	
		    	ScrinngDTO scrinngDto1 = scrinngDao.selectOne(scrinngDto);
		    	
		    	if(scedSeatDto1 != null&&scrinngDto1!=null)
		    	{
		    		scedSeatDto.setAdvnAt(seatDto.getUsefulAt());
		    		scedSeatDao.update(scedSeatDto);
		    		scrinngDto1.setUseAbleSeatNum(scrinngDto1.getUseAbleSeatNum()+seatCnt);
		    		scrinngDao.update(scrinngDto1);
		    	}
		    	else if(scedSeatDto1 == null||scrinngDto1==null)
		    	{
		    		cnt=0;
					return cnt;
		    	}
		    }
			}
			
			
			
			
			seatDao.update(seatDto);
			cnt =1;
		   }
		else if(seatDto1==null)
		   {
			cnt=0;
			return cnt;
	       }
		}

	return cnt;
	}

	@Transactional
	@Override
	public int bizInsert(String theatId, String scrRmId) {
		int cnt = 0;
		int maxCol = 0;
		String row = "";
		String col = "";
		
		SeatDTO seatDto = new SeatDTO();
		ScedSeatDTO scedSeatDto = new ScedSeatDTO();
		ScrinngDTO scrinngDto   = new ScrinngDTO();
		
		seatDto.setTheatId(theatId);
		seatDto.setScrRmId(scrRmId);
		
		List<SeatDTO> seatList = seatQebc.selectAll(seatDto);
		
		for(int i=0 ; i < seatList.size();i++)
		{
			SeatDTO seatMaxCol = seatList.get(i);
			if(Integer.parseInt(seatMaxCol.getSeatRow())>1) 
			{
				break;
			}
			maxCol ++;
		}
		
		SeatDTO maxSeat = seatList.get(seatList.size()-1);
		
		if(maxCol==Integer.parseInt(maxSeat.getSeatCol()))
		{
		row = String.valueOf(Integer.parseInt(maxSeat.getSeatRow())+1);	
		col = "1";
		
		seatDto.setSeatRow(row);
		seatDto.setSeatCol(col);
		}
		else
		{
		row = String.valueOf(Integer.parseInt(maxSeat.getSeatRow()));
		col = String.valueOf(Integer.parseInt(maxSeat.getSeatCol())+1);
		
		seatDto.setSeatRow(row);
		seatDto.setSeatCol(col);
		}
		
		SeatDTO seatDto1 = seatDao.selectOne(seatDto);
		
		
		if(seatDto1 == null) 
		{
			seatDto.setUsefulAt("Y");
			seatDao.insert(seatDto);
			
			ScrinngRmDTO scrinngRmDto = new ScrinngRmDTO();
			
			scrinngRmDto.setTheatId(theatId);
			scrinngRmDto.setScrRmId(scrRmId);
			
			ScrinngRmDTO scrinngRmDto1 = scrinngRmDao.selectOne(scrinngRmDto);
			
			if(scrinngRmDto1!=null)
			{
			int totSeat = scrinngRmDto1.getTotSeat() + 1; 
			scrinngRmDto1.setTotSeat(totSeat);	
			scrinngRmDao.update(scrinngRmDto1);
			
			SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd/HH:mm");
			Calendar time = Calendar.getInstance();
			
			String crtTime = format1.format(time.getTime());
			
			List<ScedSeatDTO> insertList = scedSeatQebc.selectAllInsert(theatId, scrRmId, crtTime);
			
			for(int z = 0 ;z < insertList.size();z++)
			{
				scedSeatDto.setTheatId(theatId);
				scedSeatDto.setScrinngRmId(scrRmId);
				scedSeatDto.setSeatCol(col);
				scedSeatDto.setSeatRow(row);
				scedSeatDto.setScrinngDt(insertList.get(z).getScrinngDt());
				scedSeatDto.setPblprfrId(insertList.get(z).getPblprfrId());
				
				scrinngDto.setPblprfrId(insertList.get(z).getPblprfrId());
				scrinngDto.setScrinngDt(insertList.get(z).getScrinngDt());
				
				ScedSeatDTO scedSeatDto1 = scedSeatDao.selectOne(scedSeatDto);
				ScrinngDTO  scrinngDto1  = scrinngDao.selectOne(scrinngDto);

				if(scedSeatDto1==null&&scrinngDto1!=null)
				{
					scedSeatDto.setAdvnAt("Y");
					scedSeatDao.insert(scedSeatDto);
					scrinngDto.setUseAbleSeatNum(scrinngDto1.getUseAbleSeatNum()+1);
					scrinngDto.setScrinngAt(scrinngDto1.getScrinngAt());
					scrinngDao.update(scrinngDto);
				}
				else if (scedSeatDto1!=null||scrinngDto1==null) {
					cnt = 0;
					return cnt;
				}
			}
			
			cnt = 1;
			}
			else if(scrinngRmDto1==null)
			{
				cnt = 0;
				return cnt;
			}
		}
		else if(seatDto1 != null)
		{
			cnt = 0;
			return cnt;
		}
		
		return cnt;
	}

	@Transactional
	@Override
	public int bizInsertRow(String theatId, String scrRmId) {
		int cnt = 0;
		int maxCol = 0;
		int addCnt = 0;
		int plus = 0 ;
		int plusRow = 0 ;
		
		SeatDTO     seatDto     = new SeatDTO();
		ScedSeatDTO scedSeatDto = new ScedSeatDTO();
		ScrinngDTO  scrinngDto  = new ScrinngDTO();
		
		seatDto.setTheatId(theatId);
		seatDto.setScrRmId(scrRmId);
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd/HH:mm");
		Calendar time = Calendar.getInstance();
		
		String crtTime = format1.format(time.getTime());
		
		List<SeatDTO>     seatList   = seatQebc.selectAll(seatDto);
		List<ScedSeatDTO> insertList = scedSeatQebc.selectAllInsert(theatId, scrRmId, crtTime);
		
		if(insertList != null)
		{
		for(int i=0 ; i < seatList.size();i++)
		{
			SeatDTO seatMaxCol = seatList.get(i);
			if(Integer.parseInt(seatMaxCol.getSeatRow())>1) 
			{
				break;
			}
			maxCol ++;
		}
		
		SeatDTO maxSeat = seatList.get(seatList.size()-1);
		
		plus = maxCol-Integer.parseInt(maxSeat.getSeatCol());	
		int plusCol = maxCol+1-plus ;
		
		if(plusCol>maxCol)
		{
			plusCol=1;
		}
		
		for(int a = 1;  a < maxCol+1 ; a++)
		{
		addCnt++;
		if(plus < a&&plusRow==0) 
		{
			plusRow=1;
			plusCol=1;
		}
		String row = String.valueOf(Integer.parseInt(maxSeat.getSeatRow())+plusRow);
		String col = String.valueOf(plusCol);	
		plusCol++;
		seatDto.setSeatRow(row);
		seatDto.setSeatCol(col);
		
        SeatDTO seatDto1 = seatDao.selectOne(seatDto);
		
		if(seatDto1 == null) 
		{
			seatDto.setUsefulAt("Y");
			seatDao.insert(seatDto);
			
			for(int z = 0 ;z < insertList.size();z++)
			{
				scedSeatDto.setTheatId(theatId);
				scedSeatDto.setScrinngRmId(scrRmId);
				scedSeatDto.setSeatCol(col);
				scedSeatDto.setSeatRow(row);
				scedSeatDto.setScrinngDt(insertList.get(z).getScrinngDt());
				scedSeatDto.setPblprfrId(insertList.get(z).getPblprfrId());
				
				scrinngDto.setPblprfrId(insertList.get(z).getPblprfrId());
				scrinngDto.setScrinngDt(insertList.get(z).getScrinngDt());
				
				ScedSeatDTO scedSeatDto1 = scedSeatDao.selectOne(scedSeatDto);
				ScrinngDTO  scrinngDto1  = scrinngDao.selectOne(scrinngDto);

				if(scedSeatDto1==null&&scrinngDto1!=null)
				{
					scedSeatDto.setAdvnAt("Y");
					scedSeatDao.insert(scedSeatDto);
					scrinngDto.setUseAbleSeatNum(scrinngDto1.getUseAbleSeatNum()+1);
					scrinngDto.setScrinngAt(scrinngDto1.getScrinngAt());
					scrinngDao.update(scrinngDto);
				}
				else if (scedSeatDto1!=null||scrinngDto1==null) {
					cnt = 0;
					return cnt;
				}
			}
		}
		else if(seatDto1 != null)
		{
			cnt = 0;
			return cnt;
		}
		}
		
		ScrinngRmDTO scrinngRmDto = new ScrinngRmDTO();
		
		scrinngRmDto.setTheatId(theatId);
		scrinngRmDto.setScrRmId(scrRmId);
		
		ScrinngRmDTO scrinngRmDto1 = scrinngRmDao.selectOne(scrinngRmDto);
		
		if(scrinngRmDto1!=null)
		{
		int totSeat = scrinngRmDto1.getTotSeat() + addCnt; 
		scrinngRmDto1.setTotSeat(totSeat);	
		scrinngRmDao.update(scrinngRmDto1);
		cnt = 1;
		}
		else if(scrinngRmDto1==null)
		{
			cnt = 0;
			return cnt;
		}
		
		}
		return cnt;
	}

	@Transactional
	@Override
	public int bizInsertCol(String theatId, String scrRmId) {
		int cnt = 0;
		int maxCol = 0;
		int addCnt = 0;
		int plus = 0;
		
		SeatDTO     seatDto      = new SeatDTO();
		ScedSeatDTO scedSeatDto  = new ScedSeatDTO();
		ScrinngDTO  scrinngDto   = new ScrinngDTO();
		
		seatDto.setTheatId(theatId);
		seatDto.setScrRmId(scrRmId);
		
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd/HH:mm");
		Calendar time = Calendar.getInstance();
		
		String crtTime = format1.format(time.getTime());
		
		List<SeatDTO>     seatList   = seatQebc.selectAll(seatDto);
		List<ScedSeatDTO> insertList = scedSeatQebc.selectAllInsert(theatId, scrRmId, crtTime);
		
		if(insertList != null)
		{
		for(int i=0 ; i < seatList.size();i++)
		{
			SeatDTO seatMaxCol = seatList.get(i);
			if(Integer.parseInt(seatMaxCol.getSeatRow())>1) 
			{
				break;
			}
			maxCol ++;
		}
		
		SeatDTO maxSeat = seatList.get(seatList.size()-1);
		
		if(maxCol==Integer.parseInt(maxSeat.getSeatCol()))
		{
		plus = 1;
		}
		else
		{
		plus = 0;	
		}
		for(int a = 1;  a < Integer.parseInt(maxSeat.getSeatRow())+plus ; a++)
		{
		addCnt++;
		String row = String.valueOf(a);
		String col = String.valueOf(maxCol+1);	
		
		seatDto.setSeatRow(row);
		seatDto.setSeatCol(col);
		
        SeatDTO seatDto1 = seatDao.selectOne(seatDto);
		
		if(seatDto1 == null) 
		{
			seatDto.setUsefulAt("Y");
			seatDao.insert(seatDto);
			
			for(int z = 0 ;z < insertList.size();z++)
			{
				scedSeatDto.setTheatId(theatId);
				scedSeatDto.setScrinngRmId(scrRmId);
				scedSeatDto.setSeatCol(col);
				scedSeatDto.setSeatRow(row);
				scedSeatDto.setScrinngDt(insertList.get(z).getScrinngDt());
				scedSeatDto.setPblprfrId(insertList.get(z).getPblprfrId());
				
				scrinngDto.setPblprfrId(insertList.get(z).getPblprfrId());
				scrinngDto.setScrinngDt(insertList.get(z).getScrinngDt());
				
				ScedSeatDTO scedSeatDto1 = scedSeatDao.selectOne(scedSeatDto);
				ScrinngDTO  scrinngDto1  = scrinngDao.selectOne(scrinngDto);

				if(scedSeatDto1==null&&scrinngDto1!=null)
				{
					scedSeatDto.setAdvnAt("Y");
					scedSeatDao.insert(scedSeatDto);
					scrinngDto.setUseAbleSeatNum(scrinngDto1.getUseAbleSeatNum()+1);
					scrinngDto.setScrinngAt(scrinngDto1.getScrinngAt());
					scrinngDao.update(scrinngDto);
				}
				else if (scedSeatDto1!=null||scrinngDto1==null) {
					cnt = 0;
					return cnt;
				}
			}
			
		}
		else if(seatDto1 != null)
		{
			cnt = 0;
			return cnt;
		}
		}
		
		ScrinngRmDTO scrinngRmDto = new ScrinngRmDTO();
		
		scrinngRmDto.setTheatId(theatId);
		scrinngRmDto.setScrRmId(scrRmId);
		
		ScrinngRmDTO scrinngRmDto1 = scrinngRmDao.selectOne(scrinngRmDto);
		
		if(scrinngRmDto1!=null)
		{
		int totSeat = scrinngRmDto1.getTotSeat() + addCnt; 
		scrinngRmDto1.setTotSeat(totSeat);	
		scrinngRmDao.update(scrinngRmDto1);
		cnt = 1;
		}
		else if(scrinngRmDto1==null)
		{
			cnt = 0;
			return cnt;
		}
		
		}
		return cnt;
	}
	
}
