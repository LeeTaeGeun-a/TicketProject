package com.spring.project;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SeatCtl {
	
	@Resource(name = "seatBiz1")
	private SeatBiz seatBiz;
//	@Autowired
//	TheatQebc theatQebc;
	
	@RequestMapping(value = "seatSelectAll")
	public String selectAll(@RequestParam(value="theatId" ,required=false, defaultValue="1") String theatId,
			                @RequestParam(value="scrRmId" ,required=false, defaultValue="1") String scrRmId,
			                Model model,
			                HttpSession session) 
	{	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
	    {
	    	return "";
	    }
		
		
		SeatDTO seatDto = new SeatDTO();
		
		seatDto.setTheatId(theatId);
		seatDto.setScrRmId(scrRmId);
		
		List<SeatDTO> array = null ;

			array = seatBiz.bizSelectAll(seatDto);
		
		model.addAttribute("LIST", array);
		
		return "seatSelect.manage";
	}
	
}
