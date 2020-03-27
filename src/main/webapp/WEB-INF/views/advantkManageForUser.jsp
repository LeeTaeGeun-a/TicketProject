<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="js/advantkManageForUser.js"></script>
<script type="text/javascript" src="js/jquery.raty.js"></script>


<title>KG Tiket</title>
<style type="text/css">
.advantkId:hover{
	color: #ff4646;
}
</style>
<script type="text/javascript">
$(function() {
    $('#star').raty({
        score: 0
        ,path : "img/"
        ,width : 200
        ,click: function(score, evt) {
            $("#starRating").val(score);
        }
    });
});
</script>
</head>
<body>
<div class="modal fade" id="reviewModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="width: 600px;margin-left: -100px; margin-top: 250px;">
			<div class="modal-header">
			<h4 class="modal-title" id="myModalLabel">후기 작성</h4>
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			</div> <!-- /.modal-header -->
			<div class="modal-body">
				<form action="insertReview.do" method="post">
					<div class="form-group">
						<div>별점선택</div>
						<span id="star"></span>
				        <input type="hidden" id="starRating" name="score" value=""/>
				        <input type="hidden" id="hiPblId" name="pblprfrId" vlaue=""/>
						<textarea class="form-control" rows="4" name="content" placeholder="욕설 및 비방글 작성시 신고대상이 될수 있습니다."style="margin-top: 20px;"></textarea>
					</div>
					<button class="btn btn-sm btn-warning" type="submit" style="float: right;">작성</button>
				</form>	
			</div> <!-- /.modal-body -->
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->


	<!-- hidden info -->
	<input type="hidden" id="needLogin" value="${needLogin}"> 
	<input type="hidden" id="startPage" value="${resMap.startPage}">
	<input type="hidden" id="endPage"	value="${resMap.endPage}">
	<input type="hidden" id="pageCount" value="${resMap.pageCount}">
	<input type="hidden" id="reviewRes" value="${reviewRes}">
	<!--  -->
	<div class="container-fluid" style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">			
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
			<div class="col">
				<div class="row">
					<div class="col-12 text-center">
						<h2 style="margin-bottom: 15px;">예매/취소 내역</h2>
						<h6>예매번호를 선택하여 상세내용 확인 및 예매취소가 가능합니다.</h6>
						<font style="color: red;margin-bottom: 40px; font-size: 12px;">*상연이 종료된 후에 후기글 작성이 가능합니다.</font>
					
						<table class="table">
						  <thead style="background-color:#ececec;">
						    <tr style="">
						      <th scope="col">예매번호</th>
						      <th scope="col">공연제목</th>
						      <th scope="col">관람일시</th>
						      <th scope="col">매수</th>	
						      <th scope="col">결제금액</th>
						      <th scope="col">취소가능일</th>
						      <th scope="col">상태</th>
						      <th scope="col">기타</th>
						    </tr>
						  </thead>
						  <tbody>
						  <c:if test="${advantkList.size()>0}"> 
							  <c:forEach var="i" begin="0" end="${advantkList.size()-1}" step="1">
							    <tr>
							      <th scope="row" class="advantkId" style="cursor: pointer;">${advantkList[i].advantkId}</th>
							      <td class="align-middle">${advantkList[i].pblprfrNm}</td>
							      <td class="align-middle">${advantkList[i].scrinngDt}</td>
							      <td class="align-middle">${advantkList[i].advantkNmrs}매</td>
							      <td class="align-middle">${advantkList[i].purchsPc}원</td>
							      <td class="align=middle">${cclPsDate[i]} 까지</td>
							   <c:if test="${advantkList[i].advantkSt =='F'}"> 
							      <td class="align-middle text-primary">예매완료</td>
							      <td class="align-middle text-center">
							   	  	<button class="btn btn-sm btn-secondary reviewBtn" data-pblprfrid="${advantkList[i].pblprfrId}" disabled="disabled">후기글 쓰기</button>
							   	  </td>
							   </c:if>
							   <c:if test="${advantkList[i].advantkSt =='C'}">  
							      <td class="align-middle text-muted">예매취소</td>
							      <td class="align-middle text-center">
							   	  	<button class="btn btn-sm btn-secondary reviewBtn" data-pblprfrid="${advantkList[i].pblprfrId}" disabled="disabled">후기글 쓰기</button>
							   	  </td>
							   </c:if>
							   <c:if test="${advantkList[i].advantkSt =='E'}">  
							      <td class="align-middle text-success">사용완료</td>
							      <td class="align-middle text-center">
							   	  	<button class="btn btn-sm btn-success reviewBtn" data-pblprfrid="${advantkList[i].pblprfrId}">후기글 쓰기</button>
							   	  </td>
							   </c:if> 
							    </tr>
							  </c:forEach> 
						  </c:if>
						  </tbody>
						</table>
						<div class="row ">
							<div class="col-12 text-center">
								<c:if test="${advantkList == null}">검색된 데이터가 없습니다.</c:if>
							</div>
						</div>
						<div class="row" style="margin-top: 30px;">
							<div class="col-2 text-center" style="float: none; margin: 0 auto;">
								  <ul class="pagination justify-content-center">
								    <li class="page-item disabled" id="previous">
								      <a class="page-link" href="advantkManageForUser.do?pageNum=${resMap.startPage -5}" aria-label="Previous">
								        <span aria-hidden="true">&laquo;</span>
								      </a>
								    </li>
								    <c:forEach var="i" begin="${resMap.startPage}" end="${resMap.endPage}">
									    <li class="page-item">
									    	<a class="page-link pageNum" href="advantkManageForUser.do?pageNum=${i}">${i}</a>
									    </li>
								    </c:forEach>
								    <li class="page-item disabled" id="next">
								      <a class="page-link" href="advantkManageForUser.do?pageNum=${resMap.startPage +5}" aria-label="Next">
								        <span aria-hidden="true">&raquo;</span>
								      </a>
								    </li>
								  </ul>
							</div>
						</div>
						
					</div>
				</div>
			<hr>
			<div class="row" id="detailAdvantk" style="margin-top: 30px;"hidden="" >
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