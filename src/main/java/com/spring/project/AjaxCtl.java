package com.spring.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class AjaxCtl {
	
	@Resource(name = "scrBiz")
	private ScrinngBiz scrBiz;
	
	@Resource(name = "pblBiz")
	private PblprfrBiz pblBiz;
	
	@Resource(name = "tBiz")
	private TheatBiz theatBiz;
	
	@Resource(name = "scrRmBiz")
	private ScrinngRmBiz scrRmBiz;
	
	@Resource(name = "mbrBiz")
	private MberBiz mberBiz;
	
	@Resource(name = "intrstBiz")
	private IntrstListBiz intrstBiz;
	
	@Resource(name = "advnBiz")
	private AdvantkBiz advantkBiz;
	
	@Resource(name="revbiz")
	private ReviewBiz reviewBiz;
	
	@Resource(name = "seatBiz1")
	private SeatBiz seatBiz;
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value ="selectAllscrinng.do",produces="application/text;charset=UTF-8")
	@ResponseBody
	public String selectAllscrinng(@RequestParam(value="pblId") String pblId ,
								   @RequestParam(value="pickedDate") String pickedDate)
	{
		JSONObject jsonObj = new JSONObject();
		Map<String, Object> map = scrBiz.bizSelectDateForUser(pblId, pickedDate);
		List<ScrinngDTO> scrTimeList = (List<ScrinngDTO>) map.get("scrTimeList");
		
		jsonObj.put("scrTimeList", scrTimeList);
		
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	@RequestMapping(value ="selectTheat.do", produces="application/text;charset=UTF-8")
	@ResponseBody
	public String selectTheat(@RequestParam(value="condition") String condition ,
							  @RequestParam(value="searchWord") String searchWord ,
							  @RequestParam(value="pageNum",required=false, defaultValue="1") int pageNum)
	{	
		JSONObject jsonObj = new JSONObject();
		HashMap<String,Object> theatMap = null;
		String gCondition = condition;
		if("theatNm".equals(gCondition)) 
		{
			theatMap = theatBiz.bizSelectNm(searchWord, pageNum);
		}
		else if ("theatLc".equals(gCondition))
		{
			theatMap = theatBiz.bizSelectLoc(searchWord, pageNum);
		}
		
		jsonObj.put("theatMap", theatMap);
		
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	@RequestMapping(value="selectScrRm.do" , produces="application/text;charset=UTF-8")
	@ResponseBody
	public String selectScrRm(@RequestParam(value="theatId") String theatId)
	{
		JSONObject jsonObj = new JSONObject();
		List<ScrinngRmDTO> scrRmList = scrRmBiz.selectOpnngAll(theatId);
		int listSize = scrRmList.size();
		jsonObj.put("scrRmList", scrRmList);
		jsonObj.put("listSize", listSize);
		String jsonOut = jsonObj.toString();
	
		return jsonOut;
	}
	
	@RequestMapping(value = "selectOnePblForUpdate" ,produces="application/text;charset=UTF-8")
	@ResponseBody
	public String selectOnePblForUpdate(@RequestParam(value="pblId") String pblId)
	{
		JSONObject jsonObj = new JSONObject();
		
		HashMap<String,Object> map = pblBiz.bizSelectOneForManage(pblId);
		PblprfrJoinDTO pblJoinDto = (PblprfrJoinDTO) map.get("pblJoinDto");
		
		jsonObj.put("pblprfrId"		, pblJoinDto.getPblprfrId());
		jsonObj.put("theatId"		, pblJoinDto.getTheatId());
		jsonObj.put("scrinngRmId"	, pblJoinDto.getScrinngRmId());
		jsonObj.put("pblNm"			, pblJoinDto.getPblNm());
		jsonObj.put("price"			, pblJoinDto.getPrice());
		jsonObj.put("actor"			, pblJoinDto.getActor());
		jsonObj.put("dirc"			, pblJoinDto.getDirc());
		jsonObj.put("genre"			, pblJoinDto.getGenre());
		jsonObj.put("grade"			, pblJoinDto.getGrade());
		jsonObj.put("pblprfrAt"		, pblJoinDto.getPblprfrAt());
		jsonObj.put("theatNm"		, pblJoinDto.getTheatName());
		jsonObj.put("runTime"		, pblJoinDto.getRunTime());
		jsonObj.put("titleImgLc"	, pblJoinDto.getTitleImgLc());
		jsonObj.put("detailImgLc"	, pblJoinDto.getDetailImgLc());
		jsonObj.put("startPeriod"	, map.get("startDate"));
		jsonObj.put("endPeriod"		, map.get("endDate"));
		String jsonOut = jsonObj.toString();
		return jsonOut;
	}
	
	@RequestMapping(value ="mberIdCk.do" , produces="application/text;charset=UTF-8")
	@ResponseBody
	public String mberIdCheck(@RequestParam("mberId") String mberId)
	{
		JSONObject jsonObj = new JSONObject();
		int res = 0;
		MberDTO checkDto = mberBiz.bizSelectOne(mberId);
		if(checkDto == null)
		{
			res = 1;
		}
		
		jsonObj.put("mberIdCkRes", res);
		String jsonOut = jsonObj.toString();
		return jsonOut;
	}
	
	@RequestMapping(value="insertIntrstPbl.do", produces="application/text;charset=UTF-8")
	@ResponseBody
	public String insertIntrstPbl(HttpSession session ,@RequestParam("pblprfrId") String pblprfrId)
	{
		JSONObject jsonObj = new JSONObject();
		int res = intrstBiz.bizInsertInst(pblprfrId, session);
		if(res == 0) {
			return "erroPage";
		}
		
		jsonObj.put("instProcRes", res);
		String jsonOut = jsonObj.toString();
		return jsonOut;
	}
	
	@RequestMapping(value="deleteIntrstPbl.do", produces="application/text;charset=UTF-8")
	@ResponseBody
	public String deleteIntrstPbl(HttpSession session ,@RequestParam("pblprfrId") String pblprfrId)
	{
		JSONObject jsonObj = new JSONObject();
		int res = intrstBiz.bizDeleteInst(pblprfrId, session);
		if(res == 0) {
			return "erroPage";
		}
		jsonObj.put("instProcRes", res);
		String jsonOut = jsonObj.toString();
		return jsonOut;
	}
	
	@RequestMapping(value="selectOneAdvantkDetail.do",produces="application/text;charset=UTF-8")
	@ResponseBody
	public String selectOneAdtkDetail(@RequestParam("advantkId") String advantkId)
	{
		JSONObject jsonObj = new JSONObject();
		Map<String,Object> map = advantkBiz.bizSelectAdtkDetail(advantkId);
		
		jsonObj.put("detailMap", map);
		String jsonOut = jsonObj.toString();
		return jsonOut;
	}
	
	@RequestMapping(value="cancleAdvantk.do",produces="application/text;charset=UTF-8")
	@ResponseBody
	public String cancleAdvantk(@RequestParam("advantkId") String advantkId)
	{
		JSONObject jsonObj = new JSONObject();
		int res = advantkBiz.bizCancleAdvantk(advantkId);
		
		jsonObj.put("cancleRes", res);
		String jsonOut = jsonObj.toString();
		return jsonOut;
	}
	
	@RequestMapping(value="selectReviewPaging.do",produces="application/text;charset=UTF-8")
	@ResponseBody
	public String selectReviewAboutPbl(@RequestParam(value="pageNum",required=false, defaultValue="1") int pageNum,
									   @RequestParam(value="pblprfrId") String pblprfrId)
	{
		JSONObject jsonObj = new JSONObject();
		Map<String,Object> reviewMap = reviewBiz.selectReviewAboutPbl(pblprfrId,pageNum);

		jsonObj.put("resMap", reviewMap);
		String jsonOut = jsonObj.toString();
		return jsonOut;
	}
	
	
	@RequestMapping(value="updateSeat.do", produces="application/text;charset=UTF-8")
	@ResponseBody
	public String updateSeat(@RequestParam("theatId") String theatId,
			                 @RequestParam("scrRmId") String scrRmId,
			                 @RequestParam(value="seatId[]" ,required=false, defaultValue="a") String[] seatId)
	{
		JSONObject jsonObj = new JSONObject();
		
		SeatDTO seatDto = new SeatDTO();
		
		seatDto.setTheatId(theatId);
		seatDto.setScrRmId(scrRmId);
		
		int cnt = seatBiz.bizUpdate(seatDto, seatId);
		if(cnt == 0) {
			return "";
		}
		
		List<SeatDTO> array = null ;
		
		array = seatBiz.bizSelectAll(seatDto);
		
		jsonObj.put("LIST1", array);
		
		jsonObj.put("SIZE", array.size());
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	@RequestMapping(value="insertSeat.do", produces="application/text;charset=UTF-8")
	@ResponseBody
	public String insertSeat(@RequestParam("theatId") String theatId,
			                 @RequestParam("scrRmId") String scrRmId,
			                 @RequestParam(value="seatId[]" ,required=false, defaultValue="a") String[] seatId)
	{
		JSONObject jsonObj = new JSONObject();
		
		SeatDTO seatDto = new SeatDTO();
		
		seatDto.setTheatId(theatId);
		seatDto.setScrRmId(scrRmId);
		
		int cnt = seatBiz.bizInsert(theatId, scrRmId);
		if(cnt == 0) {
		}
		
		List<SeatDTO> array = null ;
		
		array = seatBiz.bizSelectAll(seatDto);
		
		jsonObj.put("LIST1", array);
		
		jsonObj.put("SIZE", array.size());
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	@RequestMapping(value="insertSeatCol.do", produces="application/text;charset=UTF-8")
	@ResponseBody
	public String insertSeatCol(@RequestParam("theatId") String theatId,
			                    @RequestParam("scrRmId") String scrRmId,
			                    @RequestParam(value="seatId[]" ,required=false, defaultValue="a") String[] seatId)
	{
		JSONObject jsonObj = new JSONObject();
		
		SeatDTO seatDto = new SeatDTO();
		
		seatDto.setTheatId(theatId);
		seatDto.setScrRmId(scrRmId);
		
		int cnt = seatBiz.bizInsertCol(theatId, scrRmId);
		if(cnt == 0) {
			System.out.println(0/0);
		}
		
		List<SeatDTO> array = null ;
		
		array = seatBiz.bizSelectAll(seatDto);
		
		jsonObj.put("LIST1", array);
		
		jsonObj.put("SIZE", array.size());
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	@RequestMapping(value="insertSeatRow.do", produces="application/text;charset=UTF-8")
	@ResponseBody
	public String insertSeatRow(@RequestParam("theatId") String theatId,
			                    @RequestParam("scrRmId") String scrRmId,
			                    @RequestParam(value="seatId[]" ,required=false, defaultValue="a") String[] seatId)
	{
		JSONObject jsonObj = new JSONObject();
		
		SeatDTO seatDto = new SeatDTO();
		
		seatDto.setTheatId(theatId);
		seatDto.setScrRmId(scrRmId);
		
		int cnt = seatBiz.bizInsertRow(theatId, scrRmId);
		if(cnt == 0) {
			System.out.println(0/0);
		}
		
		List<SeatDTO> array = null ;
		
		array = seatBiz.bizSelectAll(seatDto);
		
		jsonObj.put("LIST1", array);
		
		jsonObj.put("SIZE", array.size());
		String jsonOut = jsonObj.toString();
		
		return jsonOut;
	}
	
	@RequestMapping(value="deleteReview.do", produces="application/text;charset=UTF-8")
	@ResponseBody
	public String deleteReview(@RequestParam("mberId") String mberId ,
							   @RequestParam("pblprfrId") String pblprfrId, 
							   @RequestParam("registDt") String registDt)
	{
		JSONObject jsonObj = new JSONObject();
		
		ReviewDTO reviewDto = new ReviewDTO();
		reviewDto.setPblprfrId(pblprfrId);
		reviewDto.setMberId(mberId);
		reviewDto.setRegistDt(registDt);
		
		int res = reviewBiz.deleteReview(reviewDto);
		
		jsonObj.put("reviewDeleteRes", res);
		
		String jsonOut = jsonObj.toString();
		return jsonOut;
	}
	
}
