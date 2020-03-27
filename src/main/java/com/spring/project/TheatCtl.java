package com.spring.project;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class TheatCtl {

	@Resource(name = "tBiz")
	private TheatBiz theatBiz;
	
	@RequestMapping("placeInfo.do")
	public String placeInfo(@RequestParam(value="theatId") String theatId 
			                , Model model)
	{
		TheatDTO theatDto = theatBiz.bizSelectOne(theatId);
		if(theatDto == null)
		{
			model.addAttribute("dataError", "해당자료가없습니다.");
			return "errorPage";
		}
		
		model.addAttribute("theatDto", theatDto);
		return "placeInfo";
	}
	
	@RequestMapping(value = "theatSelectAll")
	public String selectAll(Model model,
		      HttpSession session) 
    {	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level)))  
	        {
	        return "";
	        }	
		
		    List<TheatDTO> array  = theatBiz.bizSelectAll();
		    if(array != null)
		    {
		    	model.addAttribute("LIST", array);
		    }
		    else
		    {
		    	return "errorPage";
		    }
	
		return "theatSelect.manage";
	}
	
	@RequestMapping(value = "theatInsertForm")
	public String insertForm(String theatId,Model model,
                             HttpSession session) 
    {	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
	        {
	        return "";
	        }
    	
		return "theatInsertForm.manage";
	}
	
	@RequestMapping(value = "theatInsert")
	public String insert(@RequestParam(value="scrRmNm" ,required=false, defaultValue="") String[] scrRmNm ,
		                 @RequestParam(value="totSeat" ,required=false, defaultValue="") String[] totSeat ,
		                 @RequestParam(value="seatRow" ,required=false, defaultValue="") String[] seatRow ,
		                 @RequestParam(value="seatCol" ,required=false, defaultValue="") String[] seatCol ,
			             TheatDTO dto,Model model,
			             HttpSession session,
                         RedirectAttributes redirectAttr) 
	{	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
	    {
	    return "";
	    }	
			int cnt = theatBiz.bizInsert(dto,scrRmNm,totSeat,seatRow,seatCol);
			
			redirectAttr.addFlashAttribute("insertRes", cnt);
			
			if(cnt==0)
			{
				return "";
			}
		
		return "redirect:theatInsertForm";			
	}
	
	@RequestMapping(value = "theatUpdateForm")
	public String updateForm(@RequestParam(value="theatId" ,required=false, defaultValue="1") int theatId ,
			                 Model model,
			                 HttpSession session) 
	{	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level)))  
	    {
	    return "";
	    }
		TheatDTO oneDto = theatBiz.bizUpdateForm(theatId);
		model.addAttribute("dto", oneDto);
		return "theatUpdateForm.manage";
	}
	
	@RequestMapping(value = "theatUpdate")
	public String update(TheatDTO dto,Model model,
                  HttpSession session,
                  RedirectAttributes redirectAttr) 
    {	
		String level = String.valueOf(session.getAttribute("level"));
		    if(!("0".equals(level))) 
	        {
	        return "";
	        }	
			int cnt = theatBiz.bizUpdate(dto);
			
			if(cnt==0)
			{
				return "theatUpdateForm.manage";
			}
			
		redirectAttr.addAttribute("theatId", dto.getTheatId());
		
		return "redirect:theatUpdateForm";			
	}
}
