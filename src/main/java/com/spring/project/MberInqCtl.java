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
public class MberInqCtl {
	
	@Resource(name="inqBiz")
	MberInqBiz mberInqBiz;
	

	@SuppressWarnings("unchecked")
	@RequestMapping("selectMberInq.do")
	public String selectMberInq(@RequestParam(value="pageNum" ,required=false, defaultValue="1") int pageNum,
								HttpSession session,Model model)
	{
		
		String mberId = (String) session.getAttribute("loginedId");
		
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "mberInqListForm.tiles";
		}
		
		Map<String,Object> resMap = mberInqBiz.bizSelectAll(mberId,pageNum);
		
		List<MberInqDTO> inqList = (List<MberInqDTO>) resMap.get("inqList");
		
		model.addAttribute("inqList",inqList);
		model.addAttribute("resMap" , resMap);
		model.addAttribute("pageNum", pageNum);
		
		return "mberInqListForm.tiles";
	}
	
	@RequestMapping("mberInqSelectForm.do")
	public String MberInqDetailForm(@RequestParam("inqryNo") String inqryNo,HttpSession session,Model model,MberInqDTO dto)
	{
		
		String mberId = (String) session.getAttribute("loginedId");
		
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "mberInqListForm.tiles";
		}
		dto.setMberId(mberId);
		dto.setInqryNo(inqryNo);
		
		List<MberInqDTO> inqList = mberInqBiz.mberInqSelect(dto);
		model.addAttribute("DTO",inqList.get(0));
		

		
		
		if(inqList.size() == 2)
		{
			model.addAttribute("WOW",1);
			model.addAttribute("ANS",inqList.get(1));
		}
		
		return "mberInqManageForm.tiles";
	}
	@RequestMapping("mberInqUpdateForm.do")
	public String mberInqUpdateForm(@RequestParam("inqryNo") String inqryNo,HttpSession session,Model model)
	{
		String mberId = (String) session.getAttribute("loginedId");
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "myPageHome.tiles";
		}
		MberInqDTO dto = mberInqBiz.bizSelectOne(mberId, inqryNo);
		
		model.addAttribute("DTO",dto);
		
		
		return "mberInqManageForm.tiles";
	}
	@RequestMapping("mberInqUpdate.do")
	public String mberInqUpdate(MberInqDTO dto,HttpSession session,Model model)
	{
		String mberId = (String) session.getAttribute("loginedId");

		
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "myPageHome.tiles";
		}
		dto.setMberId(mberId);
		int a = mberInqBiz.bizUpdate(dto);
		model.addAttribute("UPDRES",a);
		
		return "mberInqManageForm.tiles";
	}
	
	@RequestMapping("mberInqInsertForm.do")
	public String mberInqInsertForm(HttpSession session,Model model)
	{
		String mberId = (String) session.getAttribute("loginedId");

		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "myPageHome.tiles";
		}
		model.addAttribute("INSERT", 1);
		return "mberInqManageForm.tiles";
	}
	
	@RequestMapping("mberInqInsert.do")
	public String mberInqInsert(MberInqDTO dto,HttpSession session,Model model)
	{
		String mberId = (String) session.getAttribute("loginedId");

		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "myPageHome.tiles";
		}
		int a = 0;
		dto.setMberId(mberId);
		


		a = mberInqBiz.bizInsert(dto);
			
		model.addAttribute("INSRES",a);


		return "mberInqManageForm.tiles";

		
	}
	@RequestMapping("mberInqDelete.do")
	public String mberInqDelete(MberInqDTO dto,HttpSession session,Model model) {
		int res = 0;
		String mberId = (String)session.getAttribute("loginedId");
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "myPageHome.tiles";
		}
		
		dto.setMberId(mberId);
		res = mberInqBiz.bizDelete(dto);

		model.addAttribute("DELRES",res);
		
		return "mberInqManageForm.tiles";
	}
	/*추가*/
	@SuppressWarnings("unchecked")
	@RequestMapping("mngInqListSelect.do")
	public String mngInqListSelect(@RequestParam(value="pageNum"  ,required=false, defaultValue="1") int pageNum
									,@RequestParam(value="cmb" 	  ,required=false, defaultValue="id") String cmb
									,@RequestParam(value="cmbAt"  ,required=false, defaultValue="Y") String cmbAt
									,@RequestParam(value="search" ,required=false ) String search
									,HttpSession session,Model model)
	{

		String mberId = (String) session.getAttribute("loginedId");
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "mngInqListForm.manage";
		}
		
		Map<String,Object> resMap = mberInqBiz.bizSelectForMng(cmb,search,cmbAt,pageNum);

	
		List<MberInqDTO> inqList = (List<MberInqDTO>) resMap.get("inqList");

		model.addAttribute("inqList",inqList);
		model.addAttribute("resMap" , resMap);
		model.addAttribute("pageNum", pageNum);
		return "mngInqListForm.manage";
	}
	@SuppressWarnings("unchecked")
	@RequestMapping("mngInqListForm.do")
	public String mngInqListForm(@RequestParam(value="pageNum" ,required=false, defaultValue="1") int pageNum,
			HttpSession session,Model model)
	{

		String mberId = (String) session.getAttribute("loginedId");
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "mngInqListForm.manage";
		}

		Map<String,Object> resMap = mberInqBiz.bizMngSelect(pageNum);

	
		List<MberInqDTO> inqList = (List<MberInqDTO>) resMap.get("inqList");

		model.addAttribute("inqList",inqList);
		model.addAttribute("resMap" , resMap);
		model.addAttribute("pageNum", pageNum);
		return "mngInqListForm.manage";
	}
	

		@RequestMapping("mngInqAnswerInsert.do")
		public String mngInqAnswerInsert(@RequestParam(value = "inqryNo", required = false) String inqryNo
										,@RequestParam(value = "mberId", required = false) String askMberId
										,MberInqDTO dto,HttpSession session,Model model)
		{
			System.out.println(Integer.parseInt(inqryNo));

			String mberId = (String) session.getAttribute("loginedId");
			if(mberId == null)
			{
				model.addAttribute("needLogin", "Y");
				return "mngInqListForm.manage";
			}

			
			dto.setMberId(mberId);
			int a = mberInqBiz.bizAnswerInsert(dto,askMberId,inqryNo);
			
			model.addAttribute("INSRES",a);

			return "mngInqSelectForm.manage";
		}
		
		@RequestMapping("mngInqSelectForm.do")
		public String mngInqSelectForm(@RequestParam(value = "inqryNo", required = false) String inqryNo
										,HttpSession session,Model model)
		{

			String mberId = (String) session.getAttribute("loginedId");
			if(mberId == null)
			{
				model.addAttribute("needLogin", "Y");
				return "mngInqListForm.manage";
			}
			MberInqJoinDTO dto = mberInqBiz.bizAnswerForm(inqryNo);

			MberInqDTO ans = mberInqBiz.bizAnswerSelect(inqryNo);
			model.addAttribute("DTO",dto);
			model.addAttribute("ANS",ans);
			return "mngInqSelectForm.manage";
		}
		@RequestMapping("mngInqUpdate.do")
		public String mngInqUpdate(MberInqDTO dto,HttpSession session,Model model)
		{
			String mberId = (String) session.getAttribute("loginedId");
			if(mberId == null)
			{
				model.addAttribute("needLogin", "Y");
				return "home.tiles";
			}
			dto.setMberId(mberId);
			int a = mberInqBiz.bizUpdate(dto);
			model.addAttribute("UPDRES",a);
			
			return "mngInqSelectForm.tiles";
		}
}
