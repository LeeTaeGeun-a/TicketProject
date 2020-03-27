package com.spring.project;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ScrRmCtl {
	
	@Resource(name = "scrRmBiz")
	private ScrinngRmBiz scrinngRmBiz;
//	@Autowired
//	TheatQebc theatQebc;
	
	@RequestMapping(value = "scrRmSelectAll")
	public String selectAll(@RequestParam(value="theatId" ,required=false, defaultValue="1") String theatId,
			                Model model,
			                HttpSession session) 
	{	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
		{
		return "";
		}	
	
		List<ScrRmJoinDTO> array = null ;

			array = scrinngRmBiz.bizSelectAll(theatId);
		
		model.addAttribute("LIST", array);
		
		return "scrRmSelect.manage";
	}
	
	@RequestMapping(value = "scrRmUpdateForm")
	public String updateForm(@RequestParam(value="theatId" ,required=false, defaultValue="1") String theatId ,
			                 @RequestParam(value="scrRmId" ,required=false, defaultValue="1") String scrRmId ,
			                 Model model,
			                 HttpSession session) 
	{	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
		{
		return "";
		}	
		ScrinngRmDTO oneDto = scrinngRmBiz.bizUpdateForm(theatId,scrRmId);
		model.addAttribute("dto", oneDto);
		return "scrRmUpdateForm.manage";
	}
	
	@RequestMapping(value = "scrRmInsert")
	public String insert(ScrRmJoinDTO scrRmJoinDTO,
			             @RequestParam(value="scrRmNm" ,required=false, defaultValue="") String[] scrRmNm ,
			             @RequestParam(value="totSeat" ,required=false, defaultValue="0") String[] totSeat ,
			             @RequestParam(value="seatRow" ,required=false, defaultValue="0") String[] seatRow ,
			             @RequestParam(value="seatCol" ,required=false, defaultValue="0") String[] seatCol ,
			             Model model,
			             HttpSession session) 
	{	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
		 {
		 return "";
		 }		
		String theatId = scrRmJoinDTO.getTheatId();
	    int cnt = scrinngRmBiz.bizInsert(theatId,scrRmNm,totSeat,seatRow,seatCol);
		System.out.println(theatId);
		if(cnt>0)
		{
		
		List<ScrRmJoinDTO> array = null ;

			array = scrinngRmBiz.bizSelectAll(theatId);
		
		model.addAttribute("LIST", array);
		}
		return "redirect:scrRmSelectAll";
	}
	
	@RequestMapping(value = "scrRmUpdate")
	public String update(ScrinngRmDTO scrRmDTO, Model model,
            HttpSession session) 
    {	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
	    {
	    return "";
	    }	
//		ScrinngRmDTO scrRmDTO = new ScrinngRmDTO();
//		scrRmDTO.setTheatId(theatId);
//		scrRmDTO.setScrRmNm(scrinngRmNm);
//		scrRmDTO.setClsAt(clsAt);
//		
	    int cnt = scrinngRmBiz.bizUpdate(scrRmDTO);
		
		if(cnt>0)
		{
		
		List<ScrRmJoinDTO> array = null ;
            String theatId = scrRmDTO.getTheatId();
		
			array = scrinngRmBiz.bizSelectAll(theatId);
		
		model.addAttribute("LIST", array);
		}
		return "redirect:scrRmSelectAll";
	}
	
}
