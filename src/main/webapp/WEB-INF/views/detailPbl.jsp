<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="js/detailPbl.js"></script>	



<title>KG Tiket</title>
</head>
<body onload="introducePbl()">
	<!-- hidden -->
	<input type="hidden" id="calMinDate" value="${minDate}">
	<input type="hidden" id="calMaxDate" value="${maxDate}">
	<input type="hidden" id="loginedId"  value="${loginedId}">
	<input type="hidden" id="instRes"    value="${instRes}">
	<input type="hidden" id="pblId"  	 value="${pblJoinDto.pblprfrId}">
	<input type="hidden" id="theatId"    value="${pblJoinDto.theatId}">
	<!--  -->
	<div class="container-fluid" style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">	
		<!-- nav라인 까지 ROW 종료 -->
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
			<div class="col">
				<div class="row">
					<div class="col-3">
						<img src="${pblJoinDto.titleImgLc}"  style="width: 250px; height: 350px; float: right;" class="rounded block mx-auto">
					</div>
					<div class="col-6">
						<div class="row">
							<div class="col text-center"><h5>${pblJoinDto.pblNm}</h5></div>	
						</div>
						<div class="row" style="margin-top: 25px;">
							<div class="col-2 text-left" >극장이름</div>
							<div class="col-10 text-left">${pblJoinDto.theatName}</div>	
						</div>
						<div class="row" style="margin-top:10px;">
							<div class="col-2 text-left">공연기간</div>
							<div class="col-10 text-left">${pblJoinDto.period}</div>
						</div>
						<div class="row" style="margin-top:10px;">
							<div class="col-2 text-left">관람등급</div>
							<div class="col-10 text-left">${pblJoinDto.grade}</div>
						</div>
						<div class="row" style="margin-top:10px;">
							<div class="col-2 text-left">장르</div>
							<div class="col-10 text-left">${pblJoinDto.genre}</div>
						</div>
						<div class="row" style="margin-top:10px;">
							<div class="col-2 text-left">관람시간</div>
							<div class="col-10 text-left">${pblJoinDto.runTime}분</div>
						</div>
						<div class="row" style="margin-top:10px;">
							<div class="col-2 text-left">가격</div>
							<div class="col-10 text-left">${pblJoinDto.price}원</div>
						</div>
						<div class="row" style="margin-top:25px;">
							<div class="col-2 text-left">찜하기</div>
							<div class="col-10 text-left" id="inst">
							<i class="far fa-heart text-danger" data-toggle="modal" data-target="" data-state="0" id="intrstBtn" style="font-size: 24px; cursor: pointer;"></i>
							
							</div>
						</div>
					</div>
					<div class="col-3 align-items-center">
						<form action="advantkForm.do" method="get" onsubmit="return checkLogin()">
							<div id="datepicker"></div>
							<br>
							<select class="custom-select" style="width: 299px;" id="scrTime" name="scrinngDt" required>
							    <option value="0" selected>날짜를 선택해주세요..</option>
							</select>
							<!-- hidden 으로 form 실행할때 같이 넘길 정보 -->
							<input type="hidden" name="pblprfrId"  	 value="${pblJoinDto.pblprfrId}">
							<!--  -->
							<input class="btn btn-primary btn-lg"  style="width: 299px;margin-top: 10px;" type="submit" value="예매하기">
						</form>
					</div>
				</div>
				<hr>
				<div class="row" style="margin-top: 25px;">
					<div class="col-8" style="font-size: 20px;">
						<ul class="nav nav-tabs nav-justified" id="detailInfo" >
						  <li class="nav-item">
						    <a class="nav-link navlist active" id="introducePbl" style="cursor: pointer">소개</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link navlist" id="introducePlace" style="cursor: pointer">장소</a>
						  </li>
						  <li class="nav-item">
						    <a class="nav-link navlist" id="review" style="cursor: pointer">후기</a>
						  </li>
						</ul>
						<div class="row">
							<div class="col" id ="sub_container">
							</div>
						</div>
					</div>
					<div class="col-4 border text-center" id="recomendPbl">
					<!-- 추천 공연 드갈자리 -->
					 <br>
					 <h4>추천 공연(같은극장)</h4>
					 <c:forEach var= "rePblDto" items="${recomendPbl}">
					 <a href="pblSelectOne.do?pblprfrId=${rePblDto.pblprfrId}">
					 <img src="${rePblDto.titleImgLc}" style="width: 200px; height: 300px; margin-top: 20px;"><br>
					 </a>
					 ${rePblDto.pblNm}<br>
					 ${rePblDto.period}<br>
					 </c:forEach>
					</div>
				</div>
			</div>
			<!-- 오른쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
		</div>
	</div>
</body>
</html>