package com.spring.project;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations="file:src/main/webapp/WEB-INF/spring/root-context.xml") 
public class TheatDAOTest {
	
	@Autowired
	TheatDAO theatDao;
	
	@Autowired
	TheatQebc theatQebc;
	
	@Autowired
	AdvantkQebc advanQebc;
	
	@Autowired
	ScrinngQebc scrinngQebc;
	@Autowired
	PblprfrQebc  pblQebc;
	
/*	@Test
	public void seletOneTest() {
		
		TheatDTO dto = theatDao.selectOne("1");
		
		System.out.println(dto.getTheatNm());
		
		
	}*/
	
	@Test
	public void selectNmTest() {
		//현재 시간 구해오기
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd/HH:mm");
		String now = dateformat.format(new Date());
		
		now = now.substring(0, 10);
		now = "2020.03.30";
	/*	List<PblprfrDTO> list = pblQebc.selectForClose(now);*/
		
		System.out.println(now);
		
	}
		
	

}
