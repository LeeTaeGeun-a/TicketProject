<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
<title>KG Tiket</title>
<style type="text/css">
.pblImg:hover{
	border: solid 1px;
	border-color: red;
}
.content{
 overflow: hidden;
 white-space: nowrap;
 text-overflow: ellipsis;
 width: 250px;

}

.title{
 overflow: hidden;
 white-space: nowrap;
 text-overflow: ellipsis;
 width: 100%;

}
</style>
<script>
$(function() {
	$("#update").click(function(){
		if(list.answerAt == "Y")
		{
			alert("답변이 완료된 문의글은 수정하실수 없습니다.");
			return;
		}
		
	});
	
});

</script>
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
						<h2 style="margin-bottom: 40px;">나의 문의</h2>
					
						<table class="table">
						  <thead>
						    <tr>
						      <th scope="col"width ="100px">문의 제목</th>
						      <th scope="col"width ="250px">문의 내용</th>
						      <th scope="col"width ="100px">작성 날짜</th>
						      <th scope="col"width ="50px" >답변 여부</th>
						      <th scope="col"width ="150px">&nbsp;</th>
						    </tr>
						  </thead>
						  <tbody class="table-borderless">
						  <c:if test="${inqList.size()>0}"> 
							  <c:forEach var="list" items="${inqList}">
							    <tr>
							      <td class="align-middle"><div class="title"><a href="mberInqSelectForm.do?inqryNo=${list.inqryNo }">${list.inqrySj }</a></div></td>
								  <td class="align-middle"><div class="content">${list.content}</div></td>
								  <td class="align-middle">${list.registDate}</td>
								<c:if test="${list.answerAt == 'N' }"> 
								 <td class="align-middle">답변 대기</td>
								 <td><input type="button" style="float:center;" id="Update"class="btn btn-success " value="수정하기" style="width: 150px; "onclick="location = 'mberInqUpdateForm.do?inqryNo=${list.inqryNo}'"></td>
								</c:if>			  
								<c:if test="${list.answerAt == 'Y' }"> 
								 <td class="align-middle">답변 완료</td>
								 <td><input type="button" style="float:center;" id="Update"class="btn btn-secondary" value="수정하기" style="width: 150px; "onclick="location = 'mberInqUpdateForm.do?inqryNo=${list.inqryNo}'"disabled="disabled"></td>
								</c:if>	  
							    </tr>
							  </c:forEach> 
						  </c:if>
						  </tbody>
						</table>
						<div class="row ">
							<div class="col-12 text-center">
								<c:if test="${inqList == null}">검색된 데이터가 없습니다.</c:if>
							</div>
						</div>
						<div class="row" style="margin-top: 30px;">
							<div class="col-2 text-center" style="float: none; margin: 0 auto;">
								  <ul class="pagination justify-content-center">
								    <li class="page-item disabled" id="previous">
								      <a class="page-link" href="selectIntrst.do.do?pageNum=${resMap.startPage -5}" aria-label="Previous">
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
						<div class="row">
						<div class="col">
							<div style="float: right;">
							<input type="button" id="#"	class="btn btn-secondary"value="문의하기" style="width: 150px;"onclick="location = 'mberInqInsertForm.do'">&nbsp;&nbsp;
							<input type="button" id="#"	class="btn btn-secondary"value="취소"    style="width: 150px;"onclick="location = 'myPageHome.do'"> 
							</div>
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