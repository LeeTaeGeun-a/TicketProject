package com.spring.project;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

@Controller
public class PblCtl {
	
	@Resource(name = "pblBiz")
	private PblprfrBiz pblBiz;
	
	@SuppressWarnings("unchecked")
	@RequestMapping("pblSelectOne.do")
	public String selectOnePblprfr(@RequestParam(value="pageNum" ,required=false, defaultValue="1") int pageNum 
			                     , @RequestParam("pblprfrId") String pblId 
			                     , HttpSession session, Model model)
	{
		HashMap<String,Object> map = pblBiz.bizSelectOneForUser(pblId, session);
		PblprfrJoinDTO pblJoinDto = (PblprfrJoinDTO) map.get("pblJoinDto");
		List<PblprfrJoinDTO> recomendPblList = (List<PblprfrJoinDTO>) map.get("recomendPbl");
		int minDate = (int) map.get("minDate");
		int maxDate = (int) map.get("maxDate");
		
		if(pblJoinDto == null)
		{
			model.addAttribute("error", "해당자료가없습니다.");
			return "errorPage";
		}
		
		model.addAttribute("maxDate", maxDate);
		model.addAttribute("minDate", minDate);
		model.addAttribute("pblJoinDto", pblJoinDto);
		model.addAttribute("recomendPbl", recomendPblList);
		model.addAttribute("instRes", map.get("instRes"));
		
		return "detailPbl.tiles";
	}
	
	@RequestMapping("introducePbl.do")
	public String introducePbl(@RequestParam(value="pblId") String pblId 
							  , Model model)
	{	
		PblprfrJoinDTO pblJoinDto = pblBiz.bizSelectJoinOne(pblId);
		if(pblJoinDto == null)
		{
			model.addAttribute("dataError", "해당자료가없습니다.");
			return "errorPage";
		}
		
		model.addAttribute("pblJoinDto", pblJoinDto);
		return "introducePbl";
	}
	
	
	// 공연 조회
	@SuppressWarnings("unchecked")
	@RequestMapping("selectPblList.do")
	public String selectPblList(@RequestParam(value="pageNum"   ,required=false, defaultValue="1") 		int pageNum ,
								@RequestParam(value="genre"     ,required=false, defaultValue="all") 	String genre,
								@RequestParam(value="area"      ,required=false, defaultValue="all") 	String area ,
								@RequestParam(value="schedule"  ,required=false, defaultValue="all")	String schedule ,
								@RequestParam(value="searchWord",required=false, defaultValue="all")	String sWord , 
								Model model)
							
	{
		HashMap<String, Object> resMap = pblBiz.bizSelectList(genre, area, schedule, sWord, pageNum);
		ArrayList<PblprfrJoinDTO> pblList = (ArrayList<PblprfrJoinDTO>) resMap.get("pblList");
		
		
		model.addAttribute("pblList", pblList);
		model.addAttribute("resMap", resMap);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("genre", genre);
		model.addAttribute("area", area);
		model.addAttribute("schedule", schedule);
		
		return "searchPbl.tiles" ;
	}
	
	@RequestMapping("insertFormPbl.do")
	public String insertFormPbl(Model model, @RequestParam(value ="successInsert" ,required=false, defaultValue="n") String suc)
	{
		
		int maxPblId = pblBiz.insertForm();
		model.addAttribute("maxPblId", maxPblId);
		
		if("good".equals(suc))
		{
			model.addAttribute("successInsert","good");
		}
		
		return "pblprfrInsertForm.manage"; 
	}
	
	@RequestMapping("insertPblprfr.do")
	public String insertPblprfr(PblprfrDTO pblDto, RedirectAttributes redirectAttr ,HttpServletRequest request)
	{
		
		int res = pblBiz.bizInsert(pblDto , request);
		
		if(res == 0)
		{
			redirectAttr.addFlashAttribute("insertError", "등록과정중 오류 발생");
			return "errorPage";
		}
		redirectAttr.addFlashAttribute("successInsert", "good");
		
		return "redirect:insertFormPbl.do";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("selectPblForManage.do")
	public String selectPblForManage(@RequestParam(value="pageNum"   ,required=false, defaultValue="1") 		int pageNum ,
									 @RequestParam(value="searchWord",required=false, defaultValue="all")		String sWord,
									 @RequestParam(value="updateRes",required=false) String updateRes,
									 RedirectAttributes redirecAttr)
	{
		
		HashMap<String,Object> pblMap = pblBiz.bizSelectForManage(sWord, pageNum);
		ArrayList<PblprfrJoinDTO> pblList = (ArrayList<PblprfrJoinDTO>) pblMap.get("pblList");
		
		redirecAttr.addFlashAttribute("updateRes", updateRes);
		redirecAttr.addFlashAttribute("pblList", pblList);
		redirecAttr.addFlashAttribute("pblMap", pblMap);
		redirecAttr.addFlashAttribute("sWord", sWord);
		redirecAttr.addFlashAttribute("pageNum", pageNum);
		return "redirect:updateFormPbl.do";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("updateFormPbl.do")
	public String updateFormPbl(Model model, HttpServletRequest req)
	{
		Map<String,?> flashMap = RequestContextUtils.getInputFlashMap(req);
		if(flashMap != null) {
			return "pblprfrUpdateForm.manage";
		}
		
		HashMap<String,Object> pblMap = pblBiz.bizSelectForManage("all", 1);
		ArrayList<PblprfrJoinDTO> pblList = (ArrayList<PblprfrJoinDTO>) pblMap.get("pblList");
		model.addAttribute("pblList", pblList);
		model.addAttribute("pblMap", pblMap);
		model.addAttribute("sWord", "all");
		model.addAttribute("pageNum", 1);
		
		return "pblprfrUpdateForm.manage";
	}
	
	@RequestMapping("updatePblprfr.do")
	public String updatepbl(PblprfrDTO pblDto, Model model, HttpServletRequest request,
							@RequestParam(value="pageNum" ,required=false, defaultValue="1") int pageNum ,
							@RequestParam(value="sWord",required=false, defaultValue="all") String sWord , 
							@RequestParam("ckTitleImg") String ckTitleImg ,
							@RequestParam("ckDetailImg") String ckDetailImg	)
	{	
		
		int res = pblBiz.bizUpdate(pblDto,ckTitleImg,ckDetailImg,request);
		
		model.addAttribute("updateRes", res);
		model.addAttribute("pageNum", pageNum);
		model.addAttribute("sWord", sWord);
		return "redirect:selectPblForManage.do";
	}
	
	
	
	
}
