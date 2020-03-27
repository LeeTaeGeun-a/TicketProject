<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="js/searchPbl.js"></script>
<title>KG Tiket</title>
</head>

<body>	
	<!-- hidden -->
	<input type="hidden" id="hidGenre"	 	value="${genre}">
	<input type="hidden" id="hidArea"  		value="${area}">
	<input type="hidden" id="hidSchedule" 	value="${schedule}">
	<input type="hidden" id="startPage" 	value="${startPage}">
	<input type="hidden" id="endPage"	 	value="${endPage}">
	<input type="hidden" id="pageCount" 	value="${pageCount}">
	<!--  -->
	<div class="container-fluid" style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">		
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
			<div class="col-10">
				<form action="selectPblList.do" method="get">
					<div class="row">
						<div class ="col-3 offset-1 text-center">
							<label class="text-danger" style="float: none; margin: 0 auto; font-size: 30px;">장르</label>
							<select class="custom-select custom-select-lg" id="genre" name="genre">
							  <option value="all"   	 id = "allGenre" selected >전체보기</option>
							  <option value="drama"   	 id = "drama">연극</option>
							  <option value="musical"	 id = "musical">뮤지컬</option>
							  <option value="concert" 	 id = "concert">콘서트</option>
							  <option value="childdrama" id = "childdrama">아동극</option>
							</select>
						</div>
						<div class ="col-3 text-center">
							<label class="text-danger" style="float: none; margin: 0 auto; font-size: 30px;">지역</label>
							<select class="custom-select custom-select-lg" id="area" name="area">
							  <option value="all" 		id = "allArea" selected>전체보기</option>
							  <option value="area01"	id = "area01">경기/서울</option>
							  <option value="area02"	id = "area02">충청/대전</option>
							  <option value="area03"	id = "area03">경상/대구/부산</option>
							  <option value="area04"	id = "area04">전라/광주/전주</option>
							  <option value="area05"	id = "area05">기타지역</option>
							</select>
						</div>
						<div class ="col-3 text-center">
							<label class="text-danger" style="float: none; margin: 0 auto; font-size: 30px;">일정</label>
							<select class="custom-select custom-select-lg" id="schedule" name="schedule">
							  <option value="all" 		id = "allSchedule" selected>전체일정</option>
							  <option value="today"		id = "today">오늘</option>
							  <option value="tomorrow"	id = "tomorrow">내일</option>
							</select>
						</div>
						<div class ="col-2">
							<input class="btn btn-primary" type="submit" value="검색" style="width: 140px; margin-top : 50px;">
						</div>
					</div>
				</form>	
		 		<!-- 공연 이미지 시작 -->
				<div class= "row text-center" style="margin-top: 20px;">
					<div class="col text-center" >
					<hr>
					<div id="data_container"></div>
					<c:if test="${pblList != null}">
						<c:forEach var="i" begin="0" end="${pblList.size()}" step="5" >
							<div class="row" style="margin-top:80px">
								<div class="col-1"></div>	
									<c:forEach var="j" begin = "0" end = "4" step="1">
									<c:if test="${i<pblList.size()}" >
				
										<div class="col-2" >
											<div class="card" style="width: 100%">
												<a href="pblSelectOne.do?pblprfrId=${pblList[i].pblprfrId}">
												<img class="card-img-top" src="${pblList[i].titleImgLc}" style="width: 100%;height: 230px;">
												</a>
												<div class="card-body">
													<h5 class="card-title">${pblList[i].pblNm }</h5>
													<p class="card-text" style="font-size: 12px; margin-bottom: 2px; float: left;">극장 : ${pblList[i].theatName}</p>
													<p class="card-text" style="font-size: 12px; margin-bottom: 2px; float: left;">기간 : ${pblList[i].period}</p>
													<a class="btn btn-primary" href="pblSelectOne.do?pblprfrId=${pblList[i].pblprfrId}" style="margin-top: 10px;">예매하기</a>
												</div>
											</div>	
										</div>
											<c:set var="i">${i=i+1}</c:set>
										</c:if>
									</c:forEach> 
								<div class="col-1"></div>		
							</div>
						</c:forEach> 
					</c:if>
					<c:if test="${pblList == null}">
						<div>해당 조건에 맞는 공연이 없습니다.</div>
					</c:if>
					</div>
				</div>
				
				<!--  공연이미지 끝 -->
				<!-- 페이징 처리를 위한 아이콘 -->
				<div class="row" style="margin-top: 50px;">
					<div class="col-2 text-center" style="float: none; margin: 0 auto;">
						  <ul class="pagination justify-content-center">
						    <li class="page-item disabled" id="previous">
						      <a class="page-link" href="selectPblList.do?pageNum=${resMap.startPage -5}&genre=${genre}&area=${area}&schedule=${schedule}" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
						    <c:forEach var="i" begin="${resMap.startPage}" end="${resMap.endPage}">
							    <li class="page-item">
							    	<a class="page-link" href="selectPblList.do?pageNum=${i}&genre=${genre}&area=${area}&schedule=${schedule}">${i}</a>
							    </li>
						    </c:forEach>
						    <li class="page-item disabled" id="next">
						      <a class="page-link" href="selectPblList.do?pageNum=${resMap.startPage +5}&genre=${genre}&area=${area}&schedule=${schedule}" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </li>
						  </ul>
					</div>
				</div>
			</div>
			
			<!-- 오른쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
		</div>
	</div>
</body>
</html>