<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="js/intrstPbl.js"></script>		
<title>KG Tiket</title>
<style type="text/css">
.pblImg:hover{
	border: solid 1px;
	border-color: red;
}
</style>
</head>
<body>
	<div class="container-fluid" style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">			
		<!-- hidden info -->
		<input type="hidden" id="needLogin" value="${needLogin}"> 
		<input type="hidden" id="startPage" value="${resMap.startPage}">
		<input type="hidden" id="endPage"	value="${resMap.endPage}">
		<input type="hidden" id="pageCount" value="${resMap.pageCount}">
		<!--  -->
		
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
			<div class="col">
				<div class="row">
					<div class="col-12 text-center">
						<h2 style="margin-bottom: 40px;">관심공연 목록</h2>
					
						<table class="table">
						  <thead style="background-color:#ececec;" >
						    <tr>
						      <th scope="col">포스터</th>
						      <th scope="col">공연제목</th>
						      <th scope="col">공연기간</th>
						      <th scope="col">공연 상태</th>
						      <th scope="col">&nbsp;</th>
						    </tr>
						  </thead>
						  <tbody class="table">
						  <c:if test="${intrstList.size()>0}"> 
							  <c:forEach var="intrstList" items="${intrstList}">
							    <tr>
							      <th scope="row"><img src="${intrstList.titleImgLc}" data-pblid="${intrstList.pblprfrId}" data-pblAt="${intrstList.pblprfrAt}" 
							          class="pblImg" style="width: 80px;height: 100px;cursor:pointer;"></th>
							      <td class="align-middle">${intrstList.pblNm}</td>
							      <td class="align-middle">${intrstList.period}</td>
							   <c:if test="${intrstList.pblprfrAt == 'Y'}">  
							      <td class="align-middle">공연중</td>
							   </c:if>
							   <c:if test="${intrstList.pblprfrAt == 'N'}">  
							      <td class="align-middle">공연종료</td>
							   </c:if>
							   	  <td class="align-middle text-center"><button class="btn btn-sm btn-dark" name="deleteBtn" data-pblid="${intrstList.pblprfrId}">삭제</button></td>
							    </tr>
							  </c:forEach> 
						  </c:if>
						  </tbody>
						</table>
						<div class="row ">
							<div class="col-12 text-center">
								<c:if test="${intrstList == null}">검색된 데이터가 없습니다.</c:if>
							</div>
						</div>
						<div class="row" style="margin-top: 30px;">
							<div class="col-2 text-center" style="float: none; margin: 0 auto;">
								  <ul class="pagination justify-content-center">
								    <li class="page-item disabled" id="previous">
								      <a class="page-link" href="selectIntrst.do?pageNum=${resMap.startPage -5}" aria-label="Previous">
								        <span aria-hidden="true">&laquo;</span>
								      </a>
								    </li>
								    <c:forEach var="i" begin="${resMap.startPage}" end="${resMap.endPage}">
									    <li class="page-item">
									    	<a class="page-link pageNum" href="selectIntrst.do?pageNum=${i}">${i}</a>
									    </li>
								    </c:forEach>
								    <li class="page-item disabled" id="next">
								      <a class="page-link" href="selectIntrst.do?pageNum=${resMap.startPage +5}" aria-label="Next">
								        <span aria-hidden="true">&raquo;</span>
								      </a>
								    </li>
								  </ul>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					
				</div>
				
			</div>
			<!-- 오른쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>

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
	</div>
</body>
</html>