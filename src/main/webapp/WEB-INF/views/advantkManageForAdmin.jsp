<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="js/advantkManageForAdmin.js"></script>
<style type="text/css">
#advantkTable tr:hover{
	cursor: pointer;
}
</style>
</head>
<body>
	<!-- hidden -->
	<input type="hidden" id="startPage" value="${resMap.startPage}">
	<input type="hidden" id="endPage"	value="${resMap.endPage}">
	<input type="hidden" id="pageCount" value="${resMap.pageCount}">
	<!--  -->
	<div class="container">
		<div class="row" style="margin-top: 50px;">
			<div class="col-12" style="float: none; margin: 0 auto;">
				<form action="advantkManageForAdmin.do" method="get">
					<div class="form-row form-group" >
			        	<div class="col-6 offset-6"  >
			        		<div class="row" style="float: right;">
			        			<div class="col-5">
					        		<select  class="form-control" name = "condition" id="condition">
					        			<option value="all">전체조회</option>
					        			<option value="advId">예매번호 조회</option>
					        			<option value="mberId">예매자ID 조회</option>
					        			<option value="period">예매날짜 조회</option>
					        			<option value="state">상태조회</option>
					        		</select>
				        		</div>
				        		<div class="col-7">
				        			<div class="input-group" id="search_container">
					        			<input type="text" placeholder="search..." class="form-control"	name="searchWord" id="nomalSearch">
				        				<input type="submit" class="btn btn-primary" id="advntkSearchBtn" value="조회">
			        				</div>
			        			</div>
			        		</div>
			        	</div>
			        </div>
			    </form>
			</div>
		</div>
		<hr>
		<div class="row" style="margin-top:30px;">
			<div class="col-12" style="float: none; margin: 0 auto;">
			 	<table class="table table-hover" id="advantkTable">
				  <thead class="thead-dark">
				    <tr class="text-center">
				      <th scope="col">예매번호</th>
				      <th scope="col">예매자ID</th>
				      <th scope="col">공연제목</th>
				      <th scope="col">관람일시</th>
				      <th scope="col">예매일시</th>
				      <th scope="col">매수</th>
				      <th scope="col" class="text-right">결제금액</th>
				      <th scope="col">상태</th>
				    </tr>
				  </thead>
				  <c:if test="${advantkList != null }">
					  <tbody>
					  <c:forEach var="list" items="${advantkList}">
					  	<tr>
					      <td class="text-center" style="font: bold;">${list.advantkId}</td>
					      <td class="text-center"> ${list.mberId}</td>
					      <td class="text-center"> ${list.pblprfrNm}</td>
					      <td class="text-center"> ${list.scrinngDt}</td>
					      <td class="text-center"> ${list.advantkDt}</td>
					      <td class="text-center"> ${list.advantkNmrs}매</td>
					      <td class="text-right"> ${list.purchsPc}원</td>
					    <c:if test="${list.advantkSt =='F'}"> 
						  <td class="text-center text-primary">예매완료</td> 
					    </c:if>
						<c:if test="${list.advantkSt =='C'}"> 
						  <td class="text-center text-danger">예매취소</td> 
					    </c:if>
					    <c:if test="${list.advantkSt =='E'}"> 
						  <td class="text-center text-success">사용완료</td> 
					    </c:if>		   
					    </tr>
					  </c:forEach>
					  </tbody>
				</c:if>	  
				</table>
				<c:if test="${advantkList == null}">
					<div class="text-center">검색된 데이터가 없습니다.</div>
				</c:if>
			 	<!-- 페이징 처리를 위한 아이콘 -->
				<div class="row" style="margin-top: 30px;">
					<div class="col-2 text-center" style="float: none; margin: 0 auto;">
						  <ul class="pagination justify-content-center">
						    <li class="page-item disabled" id="previous">
						      <a class="page-link" href="advantkManageForAdmin.do?pageNum=${resMap.startPage -5}&condition=${condition}&searchWord=${searchWord}" aria-label="Previous">
						        <span aria-hidden="true">&laquo;</span>
						      </a>
						    </li>
						    <c:forEach var="i" begin="${resMap.startPage}" end="${resMap.endPage}">
							    <li class="page-item">
							    	<a class="page-link pageNum" href="advantkManageForAdmin.do?pageNum=${i}&condition=${condition}&searchWord=${searchWord}">${i}</a>
							    </li>
						    </c:forEach>
						    <li class="page-item disabled" id="next">
						      <a class="page-link" href="advantkManageForAdmin.do?pageNum=${resMap.startPage +5}&condition=${condition}&searchWord=${searchWord}" aria-label="Next">
						        <span aria-hidden="true">&raquo;</span>
						      </a>
						    </li>
						  </ul>
					</div>
				</div>
				<!-- paging 끝 -->
			</div>
		</div>
		<hr>
		<!-- 상세정보 넣을곳 -->
		<div id="detail_container" style="margin-bottom: 100px;" >
			<div class="row" id="detailAdvantk" style="margin-top: 30px;">
				<div class="col-10 offset-1">
					<div class="row">
						<div class="col-2">
							<img src=""  style="width: 200px; height: 300px; float: right;" id ="txPblTitleImg" class="rounded block mx-auto">
						</div>
						<div class="col-5" style="margin-top: 40px;">
							<div class="row">
								<div class="col-3 text-left" >.예매번호</div>
								<div class="col-9 text-left" id="txAdvantkId"></div>	
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-3 text-left" >.공연이름</div>
								<div class="col-9 text-left" id="txPblNm"></div>	
							</div>
							<div class="row" style="margin-top:10px;">
								<div class="col-3 text-left">.극장</div>
								<div class="col-9 text-left" id="txTheatNm"></div>
							</div>
							<div class="row" style="margin-top:10px;">
								<div class="col-3 text-left">.상영관</div>
								<div class="col-9 text-left" id="txScrRmNm"></div>
							</div>
							<div class="row" style="margin-top:10px;">
								<div class="col-3 text-left">.관람일시</div>
								<div class="col-9 text-left" id="txScrDt"></div>
							</div>
							<div class="row" style="margin-top:10px;">
								<div class="col-3 text-left">.공연가격</div>
								<div class="col-9 text-left" id="txPblPc"></div>
							</div>
							<div class="row" style="margin-top:10px;">
								<div class="col-3 text-left">.위치</div>
								<div class="col-9 text-left" id="txTheatLoc"></div>
						</div>
						</div>
						
						<div class="col-5 text-muted" style="margin-top: 40px;">
							<div class="row">
								<div class="col-3 text-left" >.예매자명</div>
								<div class="col-9 text-left" id="txMberNm"></div>	
							</div>
							<div class="row" style="margin-top: 10px;">
								<div class="col-3 text-left" >.관람자명</div>
								<div class="col-9 text-left" id="txViewPsNm"></div>	
							</div>
							<div class="row" style="margin-top:10px;">
								<div class="col-3 text-left">.예매일시</div>
								<div class="col-9 text-left" id="txAdvanDt"></div>
							</div>
							<div class="row" style="margin-top:10px;">
								<div class="col-3 text-left">.결제금액</div>
								<div class="col-9 text-left" id="txAdPurPc"></div>
							</div>
							<div class="row" style="margin-top:10px;">
								<div class="col-3 text-left">.매수</div>
								<div class="col-9 text-left" id="txAdNmrs"></div>
							</div>
							<div class="row" style="margin-top:10px;">
								<div class="col-3 text-left">.좌석</div>
								<div class="col-9 text-left" id="txAdSeats"></div>
							</div>
							<button class="btn btn-primary" id="adCancleBtn" data-advantId="" disabled="disabled" style="margin-top: 25px; float: right;">예매취소하기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
    </body>
</html>