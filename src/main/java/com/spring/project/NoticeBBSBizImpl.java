package com.spring.project;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service("noticeBiz")
public class NoticeBBSBizImpl implements NoticeBBSBiz{

	@Autowired
	NoticeBBSDAO      noticeBBSDao;
	@Autowired
	NoticeBBSQebc     noticeBBSQebc;
	
	final int MAXCNT = 10; 
	
	@Override
	public HashMap<String, Object> bizSelectAll(int pageNum) {
		
		int startRow  = (pageNum - 1) * MAXCNT +1 ;
		
		List<NoticeBBSDTO> array = noticeBBSQebc.selectAllPage(startRow, MAXCNT);
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		int count = noticeBBSQebc.count();
		
		if(count>0)
		{
			int pageCount = count / 10 + (count % 10 == 0 ? 0 : 1);
			int startPage = 1;
			
			if(pageNum % 10 != 0)
					startPage = (int) (pageNum/10)*10 + 1 ;
			else
					startPage = ((int) (pageNum/10)-1)*10 + 1 ;
					
			int pageBlock = 10;
				int endPage = startPage + pageBlock -1;
				if (endPage > pageCount) 
					endPage = pageCount;
				
				hm.put("strPage", startPage);
				hm.put("endPage", endPage  );
				hm.put("pageCnt", pageCount);
		if(array.size() == MAXCNT +1) {
			array.remove(MAXCNT);
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		hm.put("LIST", array);
		hm.put("sdf", sdf);
		}
		return hm;
	}

	@Override
	public int bizInsert(NoticeBBSDTO noticeBBSDto) {
		int cnt = 0 ;
		
		String maxNum = noticeBBSQebc.maxNum();
        int id = 1;
        if(maxNum==null)
        {}
        else 
        {
          id = Integer.parseInt(maxNum)+1;      	
        }
        
		String noticeNo =  String.valueOf(id);
		
		
		NoticeBBSDTO noticeBBSDto1 = noticeBBSDao.selectOne(noticeNo);
		
		if(noticeBBSDto1==null)
		{
		SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy.MM.dd/HH:mm");
		Calendar time = Calendar.getInstance();
		
		String registDt = format1.format(time.getTime());
		
		noticeBBSDto.setRegistDt(registDt);
		noticeBBSDto.setNoticeNo(noticeNo);
		System.out.println(noticeBBSDto.getNoticeSj());
		noticeBBSDao.insert(noticeBBSDto);
		cnt = 1;
		}
		else
		{
			cnt=0;	
			return cnt;
		}
		return cnt;
	}

	@Override
	public int bizUpdate(NoticeBBSDTO noticeBBSDto) {
    int cnt = 0 ;
		
    String noticeNo = noticeBBSDto.getNoticeNo();
		
		NoticeBBSDTO noticeBBSDto1 = noticeBBSDao.selectOne(noticeNo);
		
		if(noticeBBSDto1!=null)
		{
		SimpleDateFormat format1 = new SimpleDateFormat ("yyyy.MM.dd/HH:mm");
		Calendar time = Calendar.getInstance();
		
		String registDt = format1.format(time.getTime());
		
		noticeBBSDto.setRegistDt(registDt);
		
		noticeBBSDao.update(noticeBBSDto);
		cnt = 1;
		}
		else
		{
			cnt=0;	
			return cnt;
		}
		return cnt;
	}

	@Override
	public NoticeBBSDTO bizUpdateForm(String noticeNo) {
		
		NoticeBBSDTO noticeBBSDto = noticeBBSDao.selectOne(noticeNo);
		
		return noticeBBSDto;
	}

	@Override
	public int bizDelete(String noticeNo) {
	    int cnt = 0 ;
			
			NoticeBBSDTO noticeBBSDto1 = noticeBBSDao.selectOne(noticeNo);
			
			if(noticeBBSDto1!=null)
			{
				noticeBBSDao.delete(noticeNo);
				cnt=1;
			}
			else 
			{
				cnt=0;	
				return cnt;
			}
		return cnt;
	}

	@Override
	public HashMap<String, Object> bizSelectAllKey(int pageNum, String searchKeyword) {
        int startRow  = (pageNum - 1) * MAXCNT +1 ;
		
		List<NoticeBBSDTO> array = noticeBBSQebc.selectAllKey(startRow, MAXCNT, searchKeyword);
		HashMap<String, Object> hm = new HashMap<String, Object>();
		
		int count = noticeBBSQebc.keyCount(searchKeyword);
		
		if(count>0)
		{
			int pageCount = count / 10 + (count % 10 == 0 ? 0 : 1);
			int startPage = 1;
			
			if(pageNum % 10 != 0)
					startPage = (int) (pageNum/10)*10 + 1 ;
			else
					startPage = ((int) (pageNum/10)-1)*10 + 1 ;
					
			int pageBlock = 10;
				int endPage = startPage + pageBlock -1;
				if (endPage > pageCount) 
					endPage = pageCount;
				
				hm.put("strPage", startPage);
				hm.put("endPage", endPage  );
				hm.put("pageCnt", pageCount);
		if(array.size() == MAXCNT +1) {
			array.remove(MAXCNT);
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		hm.put("LIST", array);
		hm.put("sdf", sdf);
		}
		return hm;
	}

}