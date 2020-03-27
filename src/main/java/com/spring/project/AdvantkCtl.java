package com.spring.project;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class AdvantkCtl {
	
	@Resource(name="advnBiz")
	AdvantkBiz advantkBiz;
	
	@Resource(name = "pblBiz")
	PblprfrBiz pblBiz;
	
	
	@RequestMapping("advantkForm.do")
	public String advantkInsertForm(HttpSession session , AdvantkDTO advantkDto , Model model)
	{
		
		String mberId = (String) session.getAttribute("loginedId");
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "advantkInsertForm.tiles";
		}
		if(advantkDto.getPblprfrId() == null)
		{
			return "redirect:/";
		}
		
		Map<String,Object> advantkMap = advantkBiz.bizAdvantkInsertForm(session,advantkDto);
		
		model.addAttribute("pblJoinDto"	 , advantkMap.get("pblJoinDto"));
		model.addAttribute("scedSeatList", advantkMap.get("scedSeatList"));
		model.addAttribute("mberDto"     , advantkMap.get("mberDto"));
		model.addAttribute("scrTime"     , advantkMap.get("scrTime"));	
		model.addAttribute("maxRow"      , advantkMap.get("maxRow"));
		model.addAttribute("maxCol"      , advantkMap.get("maxCol"));
		
		return "advantkInsertForm.tiles";
	}
	
	@RequestMapping("insertAdvantk.do")
	public String insertAdvantk(AdvantkDTO advantkDto,@RequestParam("ckedSeats") ArrayList<String> ckedSeats,RedirectAttributes redirectAttr)
	{
		
		Map<String,Object> resMap = advantkBiz.bizAdvantkInsert(advantkDto, ckedSeats);
		int res = (int) resMap.get("res");
		
		if(res == 0)
		{
			return "errorPage";
		}
		
		redirectAttr.addAttribute("advantkId", resMap.get("advantkId"));
		
		return "redirect:advantkResForm.do";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("advantkManageForUser.do")
	public String manageForUser(@RequestParam(value="pageNum" ,required=false, defaultValue="1") int pageNum, 
								HttpSession session,Model model)
	{
		String mberId = (String) session.getAttribute("loginedId");
		
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "advantkManageForUser.tiles";
		}
		
		Map<String,Object> resMap = advantkBiz.bizSelectForUser(mberId, pageNum);
		List<AdvantkJoinDTO> advantkList = (List<AdvantkJoinDTO>) resMap.get("advantkList");
		List<String> cclPsDate = (List<String>) resMap.get("cclPsDate");
		
		model.addAttribute("cclPsDate", cclPsDate);
		model.addAttribute("advantkList",advantkList);
		model.addAttribute("resMap", resMap);
		model.addAttribute("pageNum", pageNum);
		
		return "advantkManageForUser.tiles";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("advantkManageForAdmin.do")
	public String manageForAdmin(@RequestParam(value="pageNum"   , required=false, defaultValue="1") int pageNum,
								 @RequestParam(value="condition" , required=false, defaultValue="all") String condition,
								 @RequestParam(value="searchWord", required=false, defaultValue="all") String sWord,
								 Model model ,HttpSession session)
	{
		String level = (String) session.getAttribute("level");
		if(!("0".equals(level)))
		{
			return "redirect:/";
		}
		
		Map<String,Object> resMap = advantkBiz.bizSelectForAdmin(pageNum,condition,sWord);
		List<AdvantkJoinDTO> advantkList = (List<AdvantkJoinDTO>) resMap.get("advantkList");
		
		model.addAttribute("advantkList",advantkList);
		model.addAttribute("resMap", resMap);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("condition", condition);
		model.addAttribute("searchWord",sWord);
		

		
		return "advantkManageForAdmin.manage";
	}
	
	@RequestMapping("advantkResForm.do")
	public String advantkResForm(@RequestParam("advantkId") String advantkId , Model model)
	{
		Map<String,Object> resMap = advantkBiz.bizSelectAdtkDetail(advantkId);

		model.addAttribute("advantkDto"  , resMap.get("advantkDto"));
		model.addAttribute("pblJoinDto"  , resMap.get("pblJoinDto"));
		model.addAttribute("scrRmDto"    , resMap.get("scrRmDto"));
		model.addAttribute("mberDto"     , resMap.get("mberDto"));
		model.addAttribute("canclePsDate", resMap.get("canclePsDate"));
		
		return "advantkResForm";
	}
	
	
	
	
}
