package com.spring.project;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainCtl {
	
	@Resource(name = "pblBiz")
	private PblprfrBiz pblBiz;
	
	@Resource(name = "advnBiz")
	AdvantkBiz advantkBiz;
	
	@Resource(name ="scrBiz")
	ScrinngBiz scrBiz;
	
	@Resource(name="inqBiz")
	MberInqBiz mberInqBiz;
	
	@RequestMapping(value = "/")
	public String home(Model model) 
	{
		Map<String,Object> map = pblBiz.bizSelectForHome();
		
		model.addAttribute("rankList", map.get("rankList"));
		model.addAttribute("adRankList",map.get("adRankList"));
		return "home.tiles";
	}
	
	
	@RequestMapping(value = "mngHome.do")
	public String mngHome(Model model,
                       HttpSession session) 
    {	
	    String level = String.valueOf(session.getAttribute("level"));
		if(!"0".equals(level)) 
        {
        return "home.tiles";
        }
		
		List<AdvantkJoinDTO> advantkList    = advantkBiz.bizSelectForMng();
		Map<String,Object>   hm             = scrBiz.bizSelectForMng();
		List<MberInqDTO>     list           = mberInqBiz.bizSelectForMng1();
		model.addAttribute("advantkList",       advantkList);
		model.addAttribute("list",              list);
		model.addAttribute("scrinngJoinDto",    hm.get("scrinngJoinDto"));
		model.addAttribute("count",             hm.get("count"));
		
		return "mngHome.manage";
	}
	
	@RequestMapping(value="closeProc.do")
	public String closeScrAndPbl (Model model)
	{
		int res = advantkBiz.closeProc();
		
		model.addAttribute("closeRes", res);
		
		return "redirect:mngHome.do";
	}
}
