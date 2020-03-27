package com.spring.project;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class NoticeBBSCtl {
	
	@Resource(name = "noticeBiz")
	private NoticeBBSBiz noticeBiz;
//	@Autowired
//	TheatQebc theatQebc;
	
	@RequestMapping(value = "noticeSelectAll")
	public String selectAll(@RequestParam(value="pageNum" ,required=false, defaultValue="1")int pageNum ,
			                @RequestParam(value="mng" ,required=false, defaultValue="1")String mng ,
			                Model model,
			                HttpSession session,
			                RedirectAttributes redirectAttr) 
	{	
		HashMap<String,Object> hm = null ;

		hm = noticeBiz.bizSelectAll(pageNum);
		 
		@SuppressWarnings("unchecked")
		List<NoticeBBSDTO> array = (List<NoticeBBSDTO>) hm.get("LIST");
		model.addAttribute("mberId",session.getAttribute("loginedId"));
		model.addAttribute("strPage",hm.get("strPage"));
		model.addAttribute("endPage",hm.get("endPage"));
		model.addAttribute("pageCnt",hm.get("pageCnt"));
		model.addAttribute("sdf",hm.get("sdf"));
		model.addAttribute("LIST", array);
		
		String level = String.valueOf(session.getAttribute("level"));
		
		if("0".equals(level)&&"0".equals(mng)) 
		{
		model.addAttribute("mng", mng);
		return "selectNotice.manage";
		}	
		
		return "selectNotice.tiles";
	}
	
	@RequestMapping(value = "noticeSelectAllKey")
	public String selectAllKey(@RequestParam(value="pageNum" ,required=false, defaultValue="1")int pageNum ,
			                @RequestParam(value="mng" ,required=false, defaultValue="1")String mng ,
			                @RequestParam(value="searchKeyword" ,required=false, defaultValue="")String searchKeyword ,
			                Model model,
			                HttpSession session,
			                RedirectAttributes redirectAttr) 
	{	
		HashMap<String,Object> hm = null ;
		
		hm = noticeBiz.bizSelectAllKey(pageNum, searchKeyword);
		 
		@SuppressWarnings("unchecked")
		List<NoticeBBSDTO> array = (List<NoticeBBSDTO>) hm.get("LIST");
		model.addAttribute("mberId",session.getAttribute("loginedId"));
		model.addAttribute("strPage",hm.get("strPage"));
		model.addAttribute("endPage",hm.get("endPage"));
		model.addAttribute("pageCnt",hm.get("pageCnt"));
		model.addAttribute("sdf",hm.get("sdf"));
		model.addAttribute("LIST", array);
		
		String level = String.valueOf(session.getAttribute("level"));
		
		if("0".equals(level)&&"0".equals(mng)) 
		{
		model.addAttribute("mng", mng);
		return "selectNotice.manage";
		}	
		
		return "selectNotice.tiles";
	}
	
	@RequestMapping(value = "noticeInsertForm")
	public String insertForm(Model model,
                             HttpSession session) 
    {	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
	        {
	        return "";
	        }
		model.addAttribute("mberId",session.getAttribute("loginedId"));
		
    	
		return "noticeInsertForm.manage";
	}
	
	@RequestMapping(value = "noticeUpdateForm")
	public String updateForm(@RequestParam(value="noticeNo" ,required=false, defaultValue="1")String noticeNo ,
			                 @RequestParam(value="mng" ,required=false, defaultValue="1")String mng ,
			                 Model model,
                             HttpSession session) 
    {	
	
		NoticeBBSDTO noticeBBSDto = noticeBiz.bizUpdateForm(noticeNo);
		
		model.addAttribute("dto",noticeBBSDto);
		
		String level = String.valueOf(session.getAttribute("level"));
		if("0".equals(level)&&"0".equals(mng)) 
		{
		return "noticeUpdateForm.manage";
		}	
    	
		return "selectOneNotice.tiles";
	}
	
	@RequestMapping(value = "noticeInsert")
	public String insert(@RequestParam(value="pageNum" ,required=false, defaultValue="1")int pageNum ,
			               NoticeBBSDTO noticeBBSDto,
			                Model model,
			                HttpSession session) 
	{	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
		{
		return "";
		}	
	
		int cnt = noticeBiz.bizInsert(noticeBBSDto);
		
		if(cnt>0)
		{
			return "redirect:noticeSelectAll?mng=0";
		}
		else
		{
			return "";
		}
		
	}
	
	@RequestMapping(value = "noticeUpdate")
	public String update(NoticeBBSDTO noticeBBSDto,
			                Model model,
			                HttpSession session) 
	{	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
		{
		return "";
		}	
	
		int cnt = noticeBiz.bizUpdate(noticeBBSDto);
		
		if(cnt>0)
		{
			return "redirect:noticeSelectAll?mng=0";
		}
		else
		{
			return "";
		}
		
	}
	
	@RequestMapping(value = "noticeDelete")
	public String delete(@RequestParam(value="noticeNo" ,required=false, defaultValue="1")String noticeNo ,
			                Model model,
			                HttpSession session) 
	{	
		String level = String.valueOf(session.getAttribute("level"));
		if(!("0".equals(level))) 
		{
		return "";
		}	
	
		int cnt = noticeBiz.bizDelete(noticeNo);
		
		if(cnt>0)
		{
			return "redirect:noticeSelectAll?mng=0";
		}
		else
		{
			return "";
		}
		
	}
}
