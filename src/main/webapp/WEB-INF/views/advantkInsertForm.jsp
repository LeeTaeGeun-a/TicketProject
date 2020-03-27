<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta	 charset="UTF-8">
<meta	 name="viewport" content="width=device-width, initial-scale=1.0">
<link	 href="css/advantkForm.css" rel="stylesheet">
<script  type="text/javascript" src="js/advantkForm.js"></script>	
<title>KG Tiket</title>
</head>
<body>
	<!-- hidden -->
	<input type="hidden" id="needLogin"  value="${needLogin}"> 
	<input type="hidden" id="loginedId"  value="${loginedId}">
	<input type="hidden" id="pblPrice"   value="${pblJoinDto.price}">
	<!--  -->

<div class="container-fluid" style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">	
	<!-- Form 시작 -->
	<form action="insertAdvantk.do" method="post" onsubmit="return ckSubmit()">
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-2"></div>
			<div class="col-6">
				<div id="accordion">
					<h3>1.좌석 선택</h3>
					<div>
						<div class="row text-center" style="margin-bottom: 40px;">
							<div class="col-2 bg-dark rounded-pill" style="float: none; margin: 0 auto;">
								<div class="text-muted" style="text-decoration: underline; font-size: 35px; font-family: cursive; ">Stage</div>
							</div>
						</div>
						<div class="row">
							<div class="col-12 text-center">
								<c:set var="k" value="0"/>
								<div class="border bg-dark rounded" style="width:${40*maxCol}px;float: none; margin: 0 auto;">
								<c:forEach var="i" begin="1" end="${maxRow}" step="1">
									<c:forEach var="j" begin="1" end="${maxCol}" step="1">
										<c:if test="${scedSeatList[k].seatCol != null}">
										<label class="checkBox-wrap">		
											<span class="text-muted"style="font-size: 12px;">[${i}-${j}]</span><br>
											<input type="checkbox" name="ckedSeats" value="${scedSeatList[k].seatRow}-${scedSeatList[k].seatCol}" data-state="${scedSeatList[k].advnAt}">
											<i class="fas fa-couch" style="font-size: 16px;cursor: pointer;"></i>
											<c:set var="k" value="${k=k+1}"></c:set>
										</label>
									    </c:if>
									</c:forEach>
									<br>	
								</c:forEach>
								<br>
									<div style="font-size: 12px;">
										<i class="fas fa-circle text-muted" ></i><span class="text-white">예매된 좌석</span>
										<i class="fas fa-circle" style="color:#00b75b;"></i><span class="text-white">예매가능 좌석</span>
										<i class="fas fa-circle" style="color:#ff4646;"></i><span class="text-white">선택된 좌석</span>
									</div>
								</div>
							</div>
						</div>
					</div>   
					
					<h3>2.공연 정보</h3>
					<div id="infoDiv">
			
						<table class="table table-borderless">
						  <tbody>
						    <tr>
						      <th scope="row">공연 제목</th>
						      <td class="pblInfo">${pblJoinDto.pblNm}</td>
						    </tr>
						    <tr>
						      <th scope="row">공연 가격</th>
						      <td class="pblInfo">&#8361;&nbsp;${pblJoinDto.price}</td>
						    </tr>
						    <tr>
						      <th scope="row">공연 기간</th>
						      <td class="pblInfo">${pblJoinDto.period}</td>
						    </tr>
						    <tr>
						      <th scope="row">Run Time</th>
						      <td class="pblInfo">${pblJoinDto.runTime}분</td>
						    </tr>
						    <tr>
						      <th scope="row">극장 이름</th>
						      <td class="pblInfo">${pblJoinDto.theatName}</td>
						    </tr>
						    <tr>
						      <th scope="row">장소 위치</th>
						      <td class="pblInfo">${pblJoinDto.theatLoc}</td>
						    </tr>
						  </tbody>
						</table>
						<div class="text-danger"style="font-size:11px;margin-top: 15px;">
						· 관람하실 공연의 정보가 맞는지 확인해 주세요.
						</div>
						
					</div>	 
					<h3>3.관람자 정보</h3>
					<div id="infoDiv">
						<table class="table table-borderless">
						  <tbody>
						    <tr>
						      <th scope="row" class="align-middle">이름</th>
						      <td class="info align-middle">
						      <input type="text" class="form-control form-control-sm" name="viewPsNm" value="${mberDto.mberNm}">
						      </td>
						    </tr>
						    <tr>
						      <th scope="row" class="align-middle">메일</th>
						      <td class="info align-middle">
						      <input type="text" class="form-control form-control-sm" name="viewPsEmail" value="${mberDto.mberEmail}">
						      </td>
						    </tr>
						    <tr>
						      <th scope="row" class="align-middle">연락처</th>
						      <td class="info align-middle">
						      <input type="text" class="form-control form-control-sm" name="viewPsTel" maxlength="11" value="${mberDto.mberTel}">
						      </td>
						    </tr>
						  </tbody>
						</table>
						<div class="text-danger"style="font-size:11px;margin-top: 15px;">
						· 실제 관람하실 분의 실명/연락처를 정확히 입력해주세요.
						</div>
						<div class="text-danger"style="font-size:11px;">
						· 정보 오기입시 정상이용 및 긴급연락이 불가하며, 이에 따른 책임을 지지 않습니다.
						</div>
						
					</div> 
				</div>
			</div>
			<div class="col-2 border rounded-lg">
				<div class="row" style="margin-top: 10px;">
					<div class="col">
						<h5  class="text-center text-truncate">[${pblJoinDto.genre}]&nbsp;${pblJoinDto.pblNm}</h5>
						<hr  style="border-top: 2px solid rgba(0,0,0,.1);">
						<div class="advnInfoTitle">관람 일시</div>
						<div class="advnInfoContent">${scrTime}</div>
						<hr>
						<div  class="advnInfoTitle">결제 금액(좌석선택시 변경)</div>
						<span class="advnInfoContent">&#8361;</span>
						<input class="advnInfoContent" id="purchsPc" name="purchsPc" type="text" style="border: none" value="0" readonly="readonly">
						<hr>
						<div class="advnInfoTitle">환불 규정</div>
						<div class="advnInfoContent">
						
							관람일 10일전 이내 : 취소수수료 없음<br>
							관람일 9일전 ~ 7일전 : 티켓금액의 10%<br>
							관람일 6일전 ~ 3일전 : 티켓금액의 20%<br>
							관람일 2일전 ~ 1일전 : 티켓금액의 30%<br>
							공연 취소 시 : 취소수수료 없음
						</div>
						<div style="font-size: 10px; color: red;">
							※ 구매시점과 무관하게 관람 당일(자정이후) 환불/변경 불가<br>
							※ 관람 당일 지각/지역착오/연령 미숙지로 인한 환불/변경 불가<br>
							※ 이용 당일, 다른 시간으로 재예매 하더라도 기존 티켓 환불 불가<br>
						</div>
						<hr>
						<div class="advnInfoTitle">결제 방법</div>
						<select class="form-control form-control-sm" name="purchsMn" style="margin-bottom: 20px;" required>
						  <option value='1'>카드</option>
						  <option value='2'>무통장입금</option>
						  <option value='3'>계좌이체</option>
						</select>	
						
						<div class="form-check">
						  <input class="form-check-input" type="checkbox" id="ckRefound" required>
						  <label class="form-check-label align-top" for="ckRefound" style="font-size: 11px; margin-top: 2px;">
						     <span >취소수수료 및 취소기한을 확인 하였으며 동의합니다.</span>
						  </label>
						</div>
						<div class="form-check">
						  <input class="form-check-input" type="checkbox" id="ckPersonalInfo" required>
						  <label class="form-check-label align-top" for="ckPersonalInfo" style="font-size: 11px; margin-top: 2px;">
						     <span >개인정보 제 3자 제공에 동의합니다.</span>
						  </label>
						</div>
						
						<!-- hidden(submit 할때 같이 넘길 정보들) -->
						<input type="hidden" value="${mberDto.mberId}" 		 	name="mberId">
						<input type="hidden" value="${pblJoinDto.pblprfrId}" 	name="pblprfrId">
						<input type="hidden" value="${scrTime}"				 	name="scrinngDt">
						<!--  -->
						<input type="submit" class="btn btn-danger btn-block" style="margin-bottom: 20px; margin-top: 10px;" value="결제하기">
					</div>
				</div>
			</div>
			<!-- 오른쪽 여백을 만들기 위한 div -->
			<div class="col-2"></div>
		</div>
	</form>
</div>
	<!-- 로그인 되지 않고 주소로 치고 들어왔을때 뜨는 화면 -->
		 <div class="row" id="needLoginService" style="margin-top: 100px;" hidden="">
			<div class="col-12 text-center" style="float: none; margin: 0 auto;">
				<hr>
				<h2 >로그인이 필요한 서비스 입니다.</h2>
				<h4 >로그인후 이용해주세요.</h4> 
				<br>
				<button class="btn btn-light" onclick="$('#loginModal').modal('show');">로그인</button>
				<button class="btn btn-light" onclick="document.location = '/TiketProject'">홈</button>
			</div>
		</div>
</body>
</html>