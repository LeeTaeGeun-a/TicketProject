package com.spring.project;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml") 
public class PblprfrDAOTest {
	
	@Autowired
	PblprfrDAO pblDao;
	@Autowired
	PblprfrQebc pblQebc;
	
	/*@Test
	public void selectIdTest() {
		PblprfrJoinDTO joinDto = pblQebc.selectJoinOne("3");
		System.out.println("dirc = " + joinDto.getDirc());
		System.out.println("이름="+joinDto.getPblNm());
		System.out.println(joinDto.getTheatTel());
		assertEquals("공연3", joinDto.getPblNm());
		
	}
	*/
	
	/*@Test
	public void seletAllTest() {
		
		HashMap<String, Object> voMap = new HashMap<String,Object>();
		voMap.put("startNum", 1);
		voMap.put("maxNum", 8);
		
		
		List<PblprfrJoinDTO> list = pblQebc.selectAll(voMap);
		
		//날짜 형식 바꾸기 위한것
		for(PblprfrJoinDTO joinDto : list)
		{
			String date = joinDto.getPeriod();
			System.out.println("기간 : "+date);
			
		}
		
	}*/
//	
//	@Test
//	public void seletListTest() {
//		
//		
//		HashMap<String, Object> voMap = new HashMap<String, Object>();
//		ArrayList<String> areaList    = new ArrayList<String>();
//		areaList.add("경기%");
//		areaList.add("서울%");
//		
//		voMap.put("genre","all");
//		voMap.put("area", "etc");
//		voMap.put("date", "all");
//		voMap.put("areaList", areaList);
//		voMap.put("maxSize", 10);
//		voMap.put("pageNum", 1);
//		List<PblprfrJoinDTO> list = pblQebc.selectList(voMap);
//		
//		System.out.println(list);
//		
//		
//	}
	
//	@Test
//	public void getMaxNumTest() {
//		String gmaxNum = pblQebc.maxNum();
//		int maxNum = 0;
//		
//		if(gmaxNum != null)
//		{
//			maxNum = Integer.parseInt(gmaxNum);
//			maxNum += 1; 
//		}
//		
//		System.out.println(gmaxNum);
//	}
	
	@Test
	public void test() {
		PblprfrDTO pblDto = pblDao.selectOne("7");
		
		System.out.println("----------------------------");
		System.out.println(pblDto.getPblprfrId());
		System.out.println(pblDto.getDetailImgLc().substring(4));
		System.out.println(pblDto.getPblNm());
	}
	

}
