package com.spring.project;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class ReviewCtl {

	@Resource(name="revbiz")
	ReviewBiz reviewBiz;
	
	
	@RequestMapping("insertReview.do")
	public String insertReview(@RequestParam(value="pageNum" ,required=false, defaultValue="1") String pageNum, 
								HttpSession session ,ReviewDTO reviewDto , RedirectAttributes redirectAttr, HttpServletRequest request)
	{
		int res = reviewBiz.insertReview(session, reviewDto);
		String prePage = request.getHeader("Referer");
		
		if(res == 0) 
		{
			return "erroPage";
		}
		
		redirectAttr.addAttribute("pageNum", pageNum);
		redirectAttr.addFlashAttribute("reviewRes", res);
		
		return "redirect:"+prePage;
	}
	
	@RequestMapping("selectReviewAboutPbl.do")
	public String selectReviewAboutPbl(@RequestParam(value="pageNum" ,required=false, defaultValue="1") int pageNum,
									   @RequestParam("pblprfrId") String pblprfrId,Model model , HttpSession session)
	{
		Map<String,Object> reviewMap = reviewBiz.selectReviewAboutPbl(pblprfrId,pageNum);
		
		String level = (String) session.getAttribute("level");
		
		model.addAttribute("level"     , level);
		model.addAttribute("reviewList", reviewMap.get("reviewList"));
		model.addAttribute("pblprfrDto", reviewMap.get("pblprfrDto"));
		model.addAttribute("resMap"    , reviewMap);
		
		return "review";
	}
}
