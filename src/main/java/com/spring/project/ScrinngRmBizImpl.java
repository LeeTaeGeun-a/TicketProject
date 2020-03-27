package com.spring.project;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("scrRmBiz")
public class ScrinngRmBizImpl implements ScrinngRmBiz{

	@Autowired
	ScrinngRmDAO  scrRmDao;
	
	@Autowired
	ScrinngRmQebc scrRmQebc;
	
	@Autowired
	SeatDAO       seatDao;
	
	@Autowired
	SeatQebc      seatQebc;
	
	@Override
	public List<ScrinngRmDTO> selectOpnngAll(String theatId) {
		
		List<ScrinngRmDTO> scrRmList = scrRmQebc.selectOpnngAll(theatId);
		
		return scrRmList;
	}
	
	@Override
	public List<ScrRmJoinDTO> bizSelectAll(String theatId) {
		
		List<ScrRmJoinDTO> array = scrRmQebc.selectJoinAll(theatId);
		
		return array;
	}
	
	@Override
	public int bizInsert(String theatId ,String[] scrRmNm,String[] totSeat,String[] seatRow,String[] seatCol) {
		int cnt = 0;
		
		ScrinngRmDTO scrRmDto = new ScrinngRmDTO();
		String maxNumScr = null;
		int sScrRmId = 1;
		
		SeatDTO seatDto = new SeatDTO();
		
		for(int i = 0; i < scrRmNm.length; i++)
		{
			maxNumScr = scrRmQebc.maxNum(theatId);
	        if(maxNumScr==null)
	        {}
	        else 
	        {
	        	sScrRmId = Integer.parseInt(maxNumScr)+1;      	
	        }
	        
			String scrRmId =  String.valueOf(sScrRmId);
			
			scrRmDto.setTheatId(theatId);
			scrRmDto.setScrRmId(scrRmId);
			scrRmDto.setTotSeat(Integer.parseInt(totSeat[i]));
			scrRmDto.setScrRmNm(scrRmNm[i]);
					
			ScrinngRmDTO scrRmDto1 = scrRmDao.selectOne(scrRmDto);
			
			if(scrRmDto1==null)
			{
				scrRmDto.setClsAt("Y");
				scrRmDao.insert(scrRmDto);

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
					return cnt;
				}
				}
			}
			}
			else if(scrRmDto1!=null)
			{
				return cnt;
			}
		}
		return cnt;
	}
	
	@Override
	public int bizUpdate(ScrinngRmDTO dto) {
		int cnt = 0;

			ScrinngRmDTO scrRmDto1 = scrRmDao.selectOne(dto);
			
			if(scrRmDto1!=null)
			{
				scrRmDao.update(dto);
				cnt =1;
			}
			else if(scrRmDto1==null)
			{
				return cnt;
			}
		return cnt;
	}

	@Override
	public ScrinngRmDTO bizUpdateForm(String theatId, String scrRmId) {
		ScrinngRmDTO uDto = new ScrinngRmDTO();
			uDto.setTheatId(theatId);	
			uDto.setScrRmId(scrRmId);
			uDto = scrRmDao.selectOne(uDto);
		return uDto;
	}

}
