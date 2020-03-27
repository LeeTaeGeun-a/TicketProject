# TicketProject
<h4>-개요</h4>
<ul>
  <li>프로젝트명 : TicketProject</li>
  <li>일정 : 20.02.01~20.03.12</li>
  <li>팀원 : 3명</li>
  <li>설명 : 다양한 공연정보 확인 과 공연예매가 가능한 사이트 </li> 
  <li>담당파트 : 메인페이지 , 공연관리, 상연관리, 예매관리, 좌석일정관리, 관심공연관리, 공연 후기, 로그인 처리, 회원가입 
  <li>프로젝트 기여도 : 60%
</ul>
<h4>-사용 기술</h4>
<img src="https://user-images.githubusercontent.com/62685492/77770437-996ad500-7088-11ea-9b86-687042cdb8c7.png"></img>
<h4>ERD</h4>
<img src="https://user-images.githubusercontent.com/62685492/77760284-6c62f600-7079-11ea-908f-ff5f64640c4e.png"></img>
<h4>-유스케이스/시퀀스 다이어그램</h4>
<div>
<img src="https://user-images.githubusercontent.com/62685492/77762877-87d00000-707d-11ea-82b4-65e761e5717c.png" width="33%"></img>
<img src="https://user-images.githubusercontent.com/62685492/77764322-d383a900-707f-11ea-98b3-476da8cff9d6.png" width="33%"></img>
<img src="https://user-images.githubusercontent.com/62685492/77764325-d4b4d600-707f-11ea-8277-72764bd2ecfa.png" width="33%"></img>
</div>
<h4>-주요담당 화면 및 기능</h4>
<h6>*화면*</h6>
<img src="https://user-images.githubusercontent.com/62685492/77767867-08462f00-7085-11ea-8cd9-b2913044284c.PNG">
<h6>*관련중요코드*</h6>
@Override
	public HashMap<String, Object> bizSelectList(String genre, String area, String schedule, String sWord ,int pageNum) {
		
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		HashMap<String, Object> voMap  = new HashMap<String, Object>();
		ArrayList<String> areaList     = new ArrayList<String>();
		int totPblCount = 0;
		switch(genre) 
		{
			case "drama": 
				genre = "연극";	
				break;
			case "musical":
				genre = "뮤지컬";
				break;
			case "concert":
				genre = "콘서트";
				break;
			
			case "childdrama":
				genre = "아동극";
				break;
			default:
				break;
		}
		
		switch(area)
		{
			case "area01":
				areaList.add("경기%");
				areaList.add("서울%");
				break;
			case "area02":
				areaList.add("충청%");
				areaList.add("대전%");
				break;
			case "area03":
				areaList.add("경상%");
				areaList.add("대구%");
				areaList.add("부산%");
				break;
			case "area04":
				areaList.add("전라%");
				areaList.add("광주%");
				areaList.add("전주%");
				break;
			case "area05":
				area = "etc";
				break;
			default:
				break;
		}

		if(!("all".equals(sWord)))
		{
			sWord =sWord+"%";
		}
		voMap.put("sWord", sWord);
		voMap.put("genre", genre);
		voMap.put("area", area);
		voMap.put("areaList", areaList);
		
		// 날짜 처리 관련 로직
		if("all".equals(schedule))
		{
			voMap.put("date", schedule);
		}
		else
		{
			Calendar calendar = Calendar.getInstance();
			
			if("tomorrow".equals(schedule))
			{
				calendar.add(Calendar.DATE, 1);
			}
			
			int year  = calendar.get(Calendar.YEAR);
			int month = calendar.get(Calendar.MONTH)+1;
			int day	  = calendar.get(Calendar.DATE);
			String rMonth = String.valueOf(month);
			if(month<10) 
			{
				rMonth="0"+rMonth;
			}
			String date = String.valueOf(year)+"."+rMonth+"."+String.valueOf(day);
			voMap.put("date", date+"%");
		}
		
		List<PblprfrJoinDTO> totPblList = pblQebc.selectList(voMap); // 총 검색된 수를 구하기 위한 것
		List<PblprfrJoinDTO> pblList = null;
		
		totPblCount = totPblList.size();
		if(totPblCount != 0) 
		{
			int startRow  = (pageNum - 1) * MAXSIZE +1 ;
			
			voMap.put("maxSize" , MAXSIZE);
			voMap.put("startRow", startRow);
			
			pblList = pblQebc.selectList(voMap); // 진짜 화면에 뿌릴 거 가져오는 것
		}
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totPblCount, 5, MAXSIZE);
		
		resMap.put("pblList", pblList);
		resMap.put("totPblCount", totPblCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));

		return resMap;
	}
