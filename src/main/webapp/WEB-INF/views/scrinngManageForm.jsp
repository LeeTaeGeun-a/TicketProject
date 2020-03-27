<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="css/scrinngManage.css" rel="stylesheet"/>
<script src="js/scrinngManage.js"></script>
</head>
<body>
		<!-- hidden 영역 -->
		<input type="hidden" id="startPage" value="${resMap.startPage}">
		<input type="hidden" id="endPage"	value="${resMap.endPage}">
		<input type="hidden" id="pageCount" value="${resMap.pageCount}">
		<input type="hidden" id="maxDate"	value="${resMap.maxDate}">
		<input type="hidden" id="minDate"	value="${resMap.minDate}">
		<input type="hidden" value="${insertRes}" id="insertRes">
		<input type="hidden" value="${updateRes}" id="updateRes">
		<input type="hidden" value="${pageNum}">
		<input type="hidden" value="${searchDate}" name="searchDate">
		<!--  -->
			<div class="container">
				<div class="row" style="margin-top: 50px;">
					<div class="col-12">
						<form action="selectForManage.do" method="get">
							
							<div class="form-row form-group" >
					        	<div class="input-group col-4" >
					        		<div class="input-group-prepend">
										<span class="input-group-text">날짜조회</span>
									</div>
					        		<input type="text" class="form-control" name="searchDate" onfocus="this.blur();"  id="searchDateInput" placeholder="날짜 선택">
					        	</div>
					        	<div class="input-group col-1">
					        		<input type="submit" class="btn btn-primary" id="changeState" value="조회">
					        	</div>
					        </div>
					        <!-- hidden -->
					        <input type="hidden" value="${pblprfrId}" name="pblprfrId">
					    </form>
					</div>
				</div>
				<hr>
				
				<div class="row" style="margin-top:30px;">
					<div class="col-12" style="float: none; margin: 0 auto;">
					<form action="updateScrinngAt.do" method="post" onsubmit="return checkCkBox();">	
					<!-- hidden -->
					<input type="hidden" name="pageNum" value="${pageNum}">
					<input type="hidden" name="searchDate"  value="${searchDate}">
					<!--  -->
					
						<div class="row">
							<div class="col-2">
								<font style="font-family: fantasy; float: left">공연 ID : ${pblprfrId}</font>
								<input type="hidden" value="${pblprfrId}" name="pblprfrId">
							</div>
					
					 		<div class="col-4 offset-6">
						 		<div style="float: right;">
								 	<input  type="submit" class="btn btn-sm btn-success" value="상태전환" style="margin-bottom: 10px;">	
						 		</div>
					 		</div> 
					 	</div>
					 	<table class="table table-bordered" id="scrTable">
						  <thead class="thead-dark">
						    <tr class="text-center">
						      <th scope="col" class="text-center align-middle">
								<font class="align-middle">전체</font> <input type="checkbox" class="align-middle" style="width: 20px;height: 20px;" id="allCheck" > 
						      </th>
						      <th scope="col">날짜/시간</th>
						      <th scope="col">이용가능 좌석 수</th>
						      <th scope="col">상연여부</th>
						    </tr>
						  </thead>
						  <tbody> 		
						  <c:if test="${scrList.size()>0}"> 
						  <c:forEach var="i" begin="0" end="${scrList.size()-1}" step="1">
						  	<tr> 
						  	  <td class="text-center">
						  	  	<input type="checkbox" style="width: 20px;height: 20px;" class="scrCheck align-middle" value="${scrList[i].scrinngDt}" name="scrinngDt">
						  	  </td>
						      <td class="text-center">${scrList[i].scrinngDt}</td>
						      <td class="text-center">${scrList[i].useAbleSeatNum}</td>
						      <td class="text-center">${scrList[i].scrinngAt}</td>
						    </tr>
						  </c:forEach>
						  </c:if>
						  
						  </tbody>
						</table>
						<div class="row ">
						<div class="col-12 text-center">
						<c:if test="${scrList == null}">검색된 데이터가 없습니다.</c:if>
						</div>
						</div>
					</form>
					 	<!-- 페이징 처리를 위한것 -->
						<div class="row" style="margin-top: 30px;">
							<div class="col-2 text-center" style="float: none; margin: 0 auto;">
								  <ul class="pagination justify-content-center">
								    <li class="page-item disabled" id="previous">
								      <a class="page-link" href="selectForManage.do?pageNum=${resMap.startPage -5}&pblprfrId=${pblprfrId}&searchDate=${searchDate}" aria-label="Previous">
								        <span aria-hidden="true">&laquo;</span>
								      </a>
								    </li>
								    <c:forEach var="i" begin="${resMap.startPage}" end="${resMap.endPage}">
									    <li class="page-item">
									    	<a class="page-link pageNum" href="selectForManage.do?pageNum=${i}&pblprfrId=${pblprfrId}&searchDate=${searchDate}">${i}</a>
									    </li>
								    </c:forEach>
								    <li class="page-item disabled" id="next">
								      <a class="page-link" href="selectForManage.do?pageNum=${resMap.startPage +5}&pblprfrId=${pblprfrId}&searchDate=${searchDate}" aria-label="Next">
								        <span aria-hidden="true">&raquo;</span>
								      </a>
								    </li>
								  </ul>
							</div>
						</div>
					</div>
				</div>
				<hr>
			</div>
			
			<div class="container" id="addScrinngForm">
				<div class="row" style="margin-top: 50px;">
					<div class="col-12" style="float: none; margin: 0 auto;">
						  <div id="accordion" style="margin-bottom: 100px;">
							  <h3>1.날짜별 상연등록</h3>
							   <form action="insertScrinngOneDate.do" method="post">	
								  <div class="row">
									<div class="col-3"> 
										<i class="far fa-calendar-alt text-danger" style="font-size: 25px; margin-top: 3px;"></i> 
										<span class="align-middle" style="font-family: monospace;">날짜</span>
										<input type="text" class="form-control" name="scrDate" onfocus="this.blur();"  id="oneDateInpue" placeholder="날짜 선택" required>
									</div>
									<div class="col-3">
										<i class="far fa-clock text-primary " style="font-size: 25px; margin-top: 3px;"></i> 
										<span class="align-middle" style="font-family: monospace;">시간(상연시작)</span>
										<div style="float: right;">
										<i class="fas fa-plus-square" id="addTimeBtn1" style="font-size:25px; margin-top:3px; cursor:pointer;"></i>
										<i class="fas fa-minus-square" id="deleteTimeBtn1" style="font-size:25px; margin-top:3px; cursor:pointer;"></i>
										</div>
										<input type="time" class="form-control" name="scrTime" required>
										
										<div id="addContainer1">
										<!-- 자바스크립트로 추가 항목 넣기 -->
										
										</div>
									</div>

									<div class="col-6">
										<!-- 히든 정보 -->
										<input type="hidden" name="pageNum" 	value="${pageNum}">
										<input type="hidden" name="pblprfrId" 	value="${pblprfrId}">
										<input type="hidden" name="searchDate"  value="${searchDate}">
										<!--  -->
										<div style="float: left;">
										<input type="submit" class="btn btn-sm btn-primary" style="margin-top: 32px;" value="등록"> 
										<input type="reset"  class="btn btn-sm btn-primary" style="margin-top: 32px;" value="초기화">
										</div>
									</div>
								  </div>
								  <input type="hidden" value="${pageNum}">
							   </form>
							  <h3>2.기간 상연등록</h3>
							  <form action="insertScrinngPeriod.do" method="post">	
								  <div class="row">
									<div class="col-3"> 
										<i class="far fa-calendar-alt text-danger" style="font-size: 25px; margin-top: 3px;"></i> 
										<span class="align-middle" style="font-family: monospace;">시작 날짜</span>
										<input type="text" class="form-control" id="startDateInput" placeholder="날짜선택" onfocus="this.blur();" name="startDate" required>
									</div>
									<font style="font-size: 32px; margin-top: 28px;">~</font>
									<div class="col-3">	
										<i class="far fa-calendar-alt text-danger" style="font-size: 25px; margin-top: 3px;"></i> 
										<span class="align-middle" style="font-family: monospace;">종료 날짜</span>
										<input type="text" class="form-control" id="endDateInput" placeholder="날짜선택" onfocus="this.blur();" name="endDate" required>
									</div>
									<div class="col-3">
										<i class="far fa-clock text-primary " style="font-size: 25px; margin-top: 3px;"></i> 
										<span class="align-middle" style="font-family: monospace;">시간(상연시작)</span>
										<div style="float: right;">
										<i class="fas fa-plus-square" id="addTimeBtn2" style="font-size:25px; margin-top:3px; cursor:pointer;"></i>
										<i class="fas fa-minus-square" id="deleteTimeBtn2" style="font-size:25px; margin-top:3px; cursor:pointer;"></i>
										</div>
										<input type="time" class="form-control" name="scrTime" required>
										
										<div id="addContainer2">
										<!-- 자바스크립트로 추가 항목 넣기 -->
										
										</div>
									</div>
									<div class="col-2">
										<!-- 히든 정보 -->
										<input type="hidden" name="pageNum" 	value="${pageNum}">
										<input type="hidden" name="pblprfrId" 	value="${pblprfrId}">
										<input type="hidden" name="searchDate"  value="${searchDate}">
										<!--  -->
										<div style="float: left;">
										<input type="submit" class="btn btn-sm btn-primary" style="margin-top: 32px;" value="등록"> 
										<input type="reset"  class="btn btn-sm btn-primary" style="margin-top: 32px;" value="초기화">
										</div>
									</div>
								  </div>
							   </form>
						  </div>
					</div>
				</div>
			</div>
</body>
</html>