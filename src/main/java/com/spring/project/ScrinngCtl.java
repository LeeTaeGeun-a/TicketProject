package com.spring.project;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ScrinngCtl {

	@Resource(name ="scrBiz")
	ScrinngBiz scrBiz;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("selectForManage.do")
	public String selectAllScrinng( @RequestParam(value="pageNum",required=false, defaultValue="1") int pageNum ,
									@RequestParam(value="searchDate",required=false, defaultValue="all")String searchDate ,
									@RequestParam("pblprfrId") String pblprfrId, Model model)
	{
		Map<String,Object> resMap = scrBiz.bizSelectForManage(pblprfrId,pageNum,searchDate);
		List<ScrinngDTO> scrList =  (List<ScrinngDTO>) resMap.get("scrList");
		
		model.addAttribute("scrList", scrList);
		model.addAttribute("resMap" , resMap);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("searchDate", searchDate);
		model.addAttribute("pblprfrId",pblprfrId);
		
		return "scrinngManageForm.manage";
	}
	
	
	@RequestMapping("updateScrinngAt.do")
	public String updateScriingAt(@RequestParam(value="pageNum",required=false, defaultValue="1") int pageNum ,
								  @RequestParam("scrinngDt") ArrayList<String> scrinngDtList ,
								  @RequestParam("pblprfrId") String pblId, RedirectAttributes redirectAttr)
	{
		
		
		int res = scrBiz.bizUpdateAt(pblId, scrinngDtList);
		
//		if(res == 0)
//		{
//			return "erroPage";
//		}
		redirectAttr.addAttribute("pblprfrId", pblId);
		redirectAttr.addAttribute("pageNum", pageNum);
		redirectAttr.addFlashAttribute("updateRes", res);
		
		return "redirect:selectForManage.do";
	}
	
	@RequestMapping("insertScrinngOneDate.do")
	public String insertScrinngOneDate(@RequestParam(value="pageNum",required=false, defaultValue="1") int pageNum ,
									   @RequestParam("pblprfrId") String pblId,
									   @RequestParam("scrDate") String scrDate,
									   @RequestParam("scrTime") ArrayList<String> scrTimeList, RedirectAttributes redirectAttr)
	{
		
		int res = scrBiz.bizInsertOneDate(pblId, scrDate, scrTimeList);	
		
		redirectAttr.addAttribute("pblprfrId", pblId);
		redirectAttr.addAttribute("pageNum", pageNum);
		redirectAttr.addFlashAttribute("insertRes", res);
		
		return "redirect:selectForManage.do";
	}
	
	@RequestMapping("insertScrinngPeriod.do")
	public String insertScrinngPeriod(@RequestParam(value="pageNum",required=false, defaultValue="1") int pageNum ,
									  @RequestParam("pblprfrId") String pblId,
									  @RequestParam("startDate") String startDate,
									  @RequestParam("endDate")   String endDate,
									  @RequestParam("scrTime") ArrayList<String> scrTimeList, RedirectAttributes redirectAttr)
	{
		
		int res = scrBiz.bizInsertPeriod(pblId, startDate, endDate, scrTimeList);
		
		redirectAttr.addAttribute("pblprfrId", pblId);
		redirectAttr.addAttribute("pageNum", pageNum);
		redirectAttr.addFlashAttribute("insertRes", res);
		
		return "redirect:selectForManage.do";
	}
}
