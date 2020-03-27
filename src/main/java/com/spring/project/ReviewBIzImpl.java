package com.spring.project;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("revbiz")
public class ReviewBIzImpl implements ReviewBiz{
	
	@Autowired
	ReviewDAO reviewDao;
	@Autowired
	ReviewQebc reviewQebc;
	@Autowired
	PblprfrDAO pblprfrDao;
	@Autowired
	CommonBiz commonBiz;

	@Transactional
	@Override
	public int insertReview(HttpSession session, ReviewDTO reviewDto) {
		
		final int FAILPK     = 0;
		final int SUCCESS	 = 1;
		
		//회원 Id가져오기
		String mberId = (String) session.getAttribute("loginedId");
		
		//현재 시간 구하기
		SimpleDateFormat dateformat = new SimpleDateFormat("yyyy.MM.dd/HH:mm:ss");
		String now = dateformat.format(new Date());
		
		reviewDto.setMberId(mberId);
		reviewDto.setRegistDt(now);
		
		ReviewDTO ckReviewDto = reviewDao.selectOne(reviewDto);
		if(ckReviewDto != null)
		{
			return FAILPK;
		}
		
		reviewDao.insert(reviewDto);
		
		// 공연에 총 평점 업데이트 하기
		double totScore = 0;
		List<ReviewDTO> reviewList = reviewQebc.selectAboutPbl(reviewDto.getPblprfrId());
		for(ReviewDTO reDto : reviewList)
		{
			totScore = totScore+reDto.getScore();
		}
		totScore = totScore/reviewList.size();
		totScore = Math.round(totScore * 10)/10.0;
		PblprfrDTO pblDto = pblprfrDao.selectOne(reviewDto.getPblprfrId());
		if(pblDto == null)
		{
			return FAILPK;
		}
		pblDto.setTotScore(totScore);
		pblprfrDao.update(pblDto);
		
		return SUCCESS;
	}

	@Override
	public Map<String, Object> selectReviewAboutPbl(String pblprfrId ,int pageNum) {
		final int MAXSIZE = 10;
		Map<String,Object> resMap   = new HashMap<String,Object>();
		Map<String,Object> map 		= new HashMap<String, Object>();
		PblprfrDTO pblDto = pblprfrDao.selectOne(pblprfrId);
		map.put("pblprfrId", pblprfrId);
		
		List<ReviewDTO> totReviewList = reviewQebc.selectAboutPbl(pblprfrId);
		List<ReviewDTO> reviewList = null;
		
		int totReviewCount = totReviewList.size();
		if(totReviewCount != 0) 
		{
			int startRow  = (pageNum - 1) * MAXSIZE +1 ;
			
			map.put("maxSize" , MAXSIZE);
			map.put("startRow", startRow);
			
			reviewList = reviewQebc.selectAboutPblPaging(map);
		}
		HashMap<String,Object> resPaging = commonBiz.bizPaging(pageNum, totReviewCount, 5, MAXSIZE);
		
		resMap.put("pblprfrDto", pblDto);
		resMap.put("reviewList", reviewList);
		resMap.put("totReviewCount", totReviewCount);
		resMap.put("pageCount", resPaging.get("pageCount"));
		resMap.put("startPage", resPaging.get("startPage"));
		resMap.put("endPage", resPaging.get("endPage"));
		
		return resMap;
	}

	@Override
	public int deleteReview(ReviewDTO reviewDto) {
		
		final int FAIL =0;
		final int SUCCESS =1;
		
		
		ReviewDTO ckDto = reviewDao.selectOne(reviewDto);
		if(ckDto == null)
		{
			return FAIL;
		}
		
		reviewDao.delete(ckDto);
		
		return SUCCESS;
	}

}
