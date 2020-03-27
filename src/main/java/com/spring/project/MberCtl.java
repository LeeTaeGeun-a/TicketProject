package com.spring.project;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class MberCtl {
	
	@Resource(name="mbrBiz")
	MberBiz mberBiz;
	
	@RequestMapping("login.do")
	public String login(MberDTO mberDto, HttpSession session ,RedirectAttributes redirectAttr,HttpServletRequest request)
	{
		String view="redirect:";
		String prePage = request.getHeader("Referer");
		if(prePage != null) {
		    view = view+prePage;
		} 
		else 
		{
			view = "redirect:/";
		}
	
		HashMap<String,Object> resMap = mberBiz.bizLogin(mberDto);
		int res = (int) resMap.get("loginRes");
		if(res == MberBizImpl.LOGIN_FAIL_PW || res == MberBizImpl.LOGIN_FAIL_ID)
		{
			redirectAttr.addFlashAttribute("inputedId", mberDto.getMberId());
			redirectAttr.addFlashAttribute("loginRes", res);
			return view;
		}
		
		MberDTO gMberDto = (MberDTO) resMap.get("gMberData");
		
		session.setAttribute("level"    , gMberDto.getMberLevel());
		session.setAttribute("loginedId", gMberDto.getMberId());
		redirectAttr.addFlashAttribute("loginRes", res);
		return view;
	}
	
	@RequestMapping("logOut.do")
	public String logOut(HttpSession session)
	{
		session.invalidate();
		
		return "redirect:/";
	}
	
	@RequestMapping("mberInsertForm.do")
	public String mberInsertForm(HttpSession session)
	{
		return "mberInsertForm.tiles";
	}
	
	@RequestMapping("mberInsert.do")
	public String mberInsert(MberDTO mberDto, RedirectAttributes redirectAttr,HttpSession session)
	{
		
		int res = 0;
		String view = "redirect:mberInsertForm.do";
		
		String pw = mberDto.getMberPw();
		String confirmPw = mberDto.getConfirmPw();
		
		redirectAttr.addFlashAttribute("insertedInfo", mberDto);
		if(!(pw.equals(confirmPw)))
		{
			res = 2;
			redirectAttr.addFlashAttribute("insertRes", res);
			return view;
		}
		
		res = mberBiz.bizInsert(mberDto);
		redirectAttr.addFlashAttribute("insertRes", res);
		
		String mberId = (String)session.getAttribute("loginedId");
		if(mberId != null)
		{
			redirectAttr.addFlashAttribute("insertRes", res);
			return "mngMberInsertForm.manage";
		}
		
		
		return view;
	}
	
	/*추가*/
	@RequestMapping("mberIdFindForm.do")
	public String mberIdFindForm() {
		return "mberIdFindForm";
	}
	
	@RequestMapping("mberIdFind.do")
	public String mberIdFind(MberDTO dto,Model model) {
		String res = mberBiz.bizIdFind(dto);

		if(res == "fail")
		{
			model.addAttribute("CHECK",res);
			return "findIdForm";
		}
		model.addAttribute("CHECK","success");
		model.addAttribute("FIND", res);
		
		return "mberIdFindForm";
	}
	@RequestMapping("mberPwFindForm.do")
	public String mberPwFindForm(Model model) {
		
		return "mberPwFindForm";
	}
	
	@RequestMapping("mberCrtfc.do")
	public String mberCrtfc(MberDTO dto,Model model, RedirectAttributes redirectAttr) {
//		본인 인증 이메일 전송...
		MberDTO res = mberBiz.bizMberCrtfc(dto);
		
		redirectAttr.addFlashAttribute("info", dto);
		redirectAttr.addFlashAttribute("STEP","first");
		redirectAttr.addFlashAttribute("DTO", res);
		redirectAttr.addFlashAttribute("CHECK", "fail");
		if(res.getMberCrtfc() != null)
		{
			redirectAttr.addFlashAttribute("CHECK", "success");
		}
		

		return "redirect:mberPwFindForm.do";
	}

	@RequestMapping("mberPwFind.do")
	public String mberPwFind(MberDTO dto,Model model) {
		String chk = mberBiz.bizPwfind(dto);
		
		
		model.addAttribute("STEP","second");
		model.addAttribute("CHECK",chk);
		return "mberPwFindForm";
	}
	/*추가*/
	@RequestMapping("myPageHome.do")
	public String myPageHome(HttpSession session,Model model) {
	
		String mberId = (String) session.getAttribute("loginedId");
		
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "myPageHome.tiles";
		}
		
		
		HashMap<String, Object> hs = mberBiz.bizMyPage(mberId);

		model.addAllAttributes(hs);

		return "myPageHome.tiles";
	}
	@RequestMapping("mberUpdatePassConfirmForm.do")
	public String mberUpdatePassConfirmForm(HttpSession session,Model model) {
		String mberId = (String)session.getAttribute("loginedId");

		
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "mberUpdatePassConfirmForm.tiles";
		}
		
		MberDTO dto = mberBiz.bizSelectOne(mberId);
		model.addAttribute("DTO",dto);
		return "mberUpdatePassConfirmForm.tiles";
	}

	@RequestMapping("mberUpdateForm.do")
	public String mberUpdateForm( @RequestParam(value = "mberId", required=false) String id
									,HttpSession session,Model model) {
		
		String mberId = (String)session.getAttribute("loginedId");

		
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "myPageHome.tiles";
		}

		if(mberId.equals(id))
		{
			MberDTO dto = mberBiz.bizUpdateForm(mberId);
			model.addAttribute("DTO",dto);
			
			return "mberUpdateForm.tiles";
		}else
		{
			MberDTO dto = mberBiz.bizUpdateForm(id);
			model.addAttribute("DTO",dto);
			return "mngMberUpdateForm.manage";
		}
	}
	@RequestMapping("mberUpdate.do")
	public String mberUpdate(@RequestParam(value = "mberAt",required = false, defaultValue="Y") String at
							,MberDTO dto,HttpSession session,Model model) {
		String sRes = "fail";
		String mberId = (String)session.getAttribute("loginedId");
		
		if(mberId == null)
		{
			model.addAttribute("needLogin", "Y");
			return "myPageHome.tiles";
		}
		
		dto.setMberAt(at);
		
		int res = mberBiz.bizUpdate(dto);
		
		if(res == 1)
		{
			sRes = "success";
		}
		model.addAttribute("UPDATERES",sRes);

		if(res == 2)
		{
			session.invalidate();
			model.addAttribute("AT","N");
			return "myPageHome.tiles";
		}
		
		if(mberId.equals(dto.getMberId()))
		{

			return "mberUpdateForm.tiles";
		}
		return "mngMberUpdateForm.manage";
	}


	
	/* 관리자용 */
	@RequestMapping("mngMberSelectForm.do")
	public String mngMberSelectForm(HttpSession session,Model model) {

		return "mngMberSelectForm.manage";
	}

	
	@RequestMapping("mngMberSelect.do")
	public String mngMberSelect(HttpSession session,Model model
								,@RequestParam("input")String input
								,@RequestParam(value="cmb"       ,required=false, defaultValue="id") String cmbValue
								,@RequestParam(value="pageNum"   ,required=false, defaultValue="1")int pageNum) {
		String mberId = (String)session.getAttribute("loginedId");
		String level = (String)session.getAttribute("level");
		if(mberId == null || !("0".equals(level)))
		{
			model.addAttribute("needLogin", "Y");
			return "home.tiles";
		}
		

		List<MberDTO> list = mberBiz.bizSelectAll(cmbValue, input,pageNum);
		model.addAttribute("LIST",list);
		return "mngMberSelectForm.manage";
	}
	
}