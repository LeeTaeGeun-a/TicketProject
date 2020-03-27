package com.spring.project;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class IntrstCtl {
	
	@Resource(name="intrstBiz")
	IntrstListBiz intrstBiz;
	
	
	@SuppressWarnings("unchecked")
	@RequestMapping("selectIntrst.do")
	public String selectIntrst(@RequestParam(value="pageNum" ,required=false, defaultValue="1") int pageNum,
								HttpSession session,Model model)
	{
		
		String mberId = (String) session.getAttribute("loginedId");
		
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "intrstPbl.tiles";
		}
		
		Map<String,Object> resMap = intrstBiz.bizSelectAll(mberId,pageNum);
		List<PblprfrDTO> intrstList = (List<PblprfrDTO>) resMap.get("intrstList");
		
		model.addAttribute("intrstList",intrstList);
		model.addAttribute("resMap", resMap);
		model.addAttribute("pageNum", pageNum);
		
		return "intrstPbl.tiles";
	}
	

}
