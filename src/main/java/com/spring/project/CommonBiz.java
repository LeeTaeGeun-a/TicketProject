package com.spring.project;

import java.io.File;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

@Component
public class CommonBiz {
	
	public int calDate(String date) {
		int res=0;
		
		String ymdt[] = date.split("/");
		ymdt[0] = ymdt[0].replace(".", ";");
		String ymd[] = ymdt[0].split(";");
		
		String year  = ymd[0];
		String month = ymd[1];
		String datee  = ymd[2];
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, Integer.parseInt(year));
		calendar.set(Calendar.MONTH, Integer.parseInt(month)-1);
		calendar.set(Calendar.DATE, Integer.parseInt(datee));
		
		int exDate  = calendar.get(Calendar.DAY_OF_YEAR);
		int totDate = (365* Integer.parseInt(year) + exDate);
		
		Calendar now = Calendar.getInstance();
		
		int nowYear = now.get(Calendar.YEAR);
		int nowDate = now.get(Calendar.DAY_OF_YEAR);
		int nowTotDate = (365* nowYear + nowDate);
		
		res = totDate - nowTotDate;
		
		
		return res;
	}
	
	
	public HashMap<String,Object> bizPaging(int pageNum ,int totCount, int pageSize ,int maxCnt){
		
		HashMap<String,Object> resPaging = new HashMap<String, Object>();
		
		int startPage = 1;
		int pageCount = totCount / maxCnt + (totCount % maxCnt == 0 ? 0 : 1); // 총 필요한 페이지 갯수 구하기
		
		if(pageNum % pageSize !=0)
		{
			startPage = (pageNum/pageSize)*pageSize+1;
		}
		else
		{
			startPage = ((pageNum/pageSize)-1)*pageSize +1 ;
		}
		
		int endPage = startPage + pageSize -1;
		if(endPage>pageCount)
		{
			endPage = pageCount;
		}
		
		resPaging.put("pageCount", pageCount);
		resPaging.put("startPage", startPage);
		resPaging.put("endPage", endPage);
		
		return resPaging;
		
	}
	
	public String procPeriod(String startDate , String endDate)
	{
		String sYear	= startDate.substring(6);
		String sMonth 	= startDate.substring(0, 2);
		String sDate  	= startDate.substring(3,5); 
		
		String eYear	= endDate.substring(6);
		String eMonth 	= endDate.substring(0, 2);
		String eDate  	= endDate.substring(3,5);
		
		String sRes = sYear + "."+sMonth+"."+sDate;
		String eRes = eYear + "."+eMonth+"."+eDate;
		
		String res = sRes+"~"+eRes;
		
		return res;
	}
	
	public HashMap<String,String> procPeriod(String period)
	{
		HashMap<String,String> resMap = new HashMap<String,String>();
		
		String periodAr[] = period.split("~");
		String startDate  = periodAr[0];
		String endDate	  = periodAr[1];
		
		String sYear	= startDate.substring(0,4);
		String sMonth 	= startDate.substring(5,7);
		String sDate  	= startDate.substring(8,10); 
		
		String eYear	= endDate.substring(0,4);
		String eMonth 	= endDate.substring(5,7);
		String eDate  	= endDate.substring(8,10);
		
		String sRes = sMonth+"/"+sDate+"/"+sYear ;
		String eRes = eMonth+"/"+eDate+"/"+eYear ;
		
		resMap.put("startDate", sRes);
		resMap.put("endDate"  , eRes);
		
		return resMap;
	}
	
	public PblprfrDTO procImgUpload(PblprfrDTO pblDto , HttpServletRequest request)
	{
		// 이미지 업로드 처리
		long nowTime = System.currentTimeMillis();
		String uploadForder = request.getSession().getServletContext().getRealPath("/resources/img"); 
		
		System.out.println("-----------------------------------------");
		System.out.println(uploadForder);
/*		String uploadForder = "D:\\1909KSC\\workspace\\TiketProject\\src\\main\\webapp\\resources\\img";*/
		String dbUrl = "img/";
		MultipartFile[] postFile  = new MultipartFile[2];
		postFile[0] = pblDto.getTitleImg();
		postFile[1] = pblDto.getDetailImg();
			
		String titlePost  = postFile[0].getOriginalFilename();
		String detailPost = postFile[1].getOriginalFilename();
		
		if(detailPost != "" && titlePost!= "" )
		{
			for(int i=0; i<postFile.length; i++)
			{
				String originFileName = postFile[i].getOriginalFilename();
				File saveFile = new File(uploadForder,nowTime+originFileName);
				try 
				{
					postFile[i].transferTo(saveFile);
				}
				catch(Exception e)
				{
					e.printStackTrace();
				}
			}
			pblDto.setTitleImgLc(dbUrl+nowTime+postFile[0].getOriginalFilename());
			pblDto.setDetailImgLc(dbUrl+nowTime+postFile[1].getOriginalFilename());
		}
		else if(detailPost =="" && titlePost != "")
		{
			String originFileName = postFile[0].getOriginalFilename();
			File saveFile = new File(uploadForder,nowTime+originFileName);
			try 
			{
				postFile[0].transferTo(saveFile);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			pblDto.setTitleImgLc(dbUrl+nowTime+postFile[0].getOriginalFilename());
			pblDto.setDetailImgLc("");
		}
		else if(titlePost =="" && detailPost !="")
		{
			String originFileName = postFile[1].getOriginalFilename();
			File saveFile = new File(uploadForder,nowTime+originFileName);
			try 
			{
				postFile[1].transferTo(saveFile);
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
			pblDto.setTitleImgLc("");
			pblDto.setDetailImgLc(dbUrl+nowTime+postFile[1].getOriginalFilename());
		}
		else
		{
			pblDto.setTitleImgLc("");
			pblDto.setDetailImgLc("");
		}		
		
		return pblDto;
	}
}
