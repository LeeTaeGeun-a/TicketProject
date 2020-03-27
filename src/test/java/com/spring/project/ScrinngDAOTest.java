package com.spring.project;

import java.util.Calendar;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml") 
public class ScrinngDAOTest {
	
	@Autowired
	ScrinngDAO scrinngDao;
	@Autowired
	ScrinngQebc scrinngQebc;
	
	
	/*@Test
	public void seletAllTest() {
		List<ScrinngDTO> list = scrinngQebc.selectAll("1");
		String cDate = "20200219";
		
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
			System.out.println("날짜 :" + gDate);
					
			if(gDate.equals(cDate))
			{
				scrTimeList.add(gTime);
			}	
					
		}
		
		JSONObject json = new JSONObject();
		json.put("list", scrTimeList);
		
		String jsonOut = json.toString();
		
		for(String data : scrTimeList)
		{
			System.out.println(data);
		}
		
				
			
		
		System.out.println(jsonOut);
		
	}*/
	
	@Test
	public void getMinDateTest()
	{
		String minDate = scrinngQebc.getMinDate("1");
		String ymdt[] = minDate.split("/");
		ymdt[0] = ymdt[0].replace(".", ";");
		String ymd[] = ymdt[0].split(";");
	
		String year  = ymd[0];
		String month = ymd[1];
		String date  = ymd[2];
		
		Calendar calendar = Calendar.getInstance();
		calendar.set(Calendar.YEAR, Integer.parseInt(year));
		calendar.set(Calendar.MONTH, Integer.parseInt(month)-1);
		calendar.set(Calendar.DATE, Integer.parseInt(date));
		
		int exDate  = calendar.get(Calendar.DAY_OF_YEAR);
		int totDate = (365* Integer.parseInt(year) + exDate);
		
		System.out.println(totDate);
		
		Calendar now = Calendar.getInstance();
		
		int nowYear = now.get(Calendar.YEAR);
		int nowDate = now.get(Calendar.DAY_OF_YEAR);
		int nowTotDate = (365* nowYear + nowDate);
		
		int res = totDate - nowTotDate;
		System.out.println(res);
		
		
	}
	

}
