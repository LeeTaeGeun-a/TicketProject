<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="js/jquery.raty.js"></script>
<style type="text/css">

.content{
 overflow: hidden;
 white-space: nowrap;
 text-overflow: ellipsis;
 width: 230px;
}

.title{
 overflow: hidden;
 white-space: nowrap;
 text-overflow: ellipsis;
 width: 100px;
}

</style>


<script>
$(function() {

	var atCheck = '${AT}';
	
	if(atCheck == 'N')
		{
			alert("회원 탈퇴하셨습니다.");
			
		}

		// 로그인 안하고 들어올때 처리
		var needLogin = $('#needLogin').val();
		if(needLogin =="Y")
		{
			$('#needLoginService').removeAttr("hidden");
			$('#thebody').hide();
			$('#loginModal').modal('show');
		};
	

	$("#mberAtUpdate").click(function(){

		
		if(confirm("회원 탈퇴를 하시겠습니까?") == true)
		{
			document.form.submit();
		}else 
		{
			return;
		}
		
	});
	
	 $('#star').raty({
	        score: 0
	        ,path : "img/"
	        ,width : 200
	        ,click: function(score, evt) {
	            $("#starRating").val(score);
	        }
	 });
	 
	//후기 등록 결과 처리
	var reviewRes=$('#reviewRes').val();
	if(reviewRes =="1")
	{
		alert("후기 작성이 완료되었습니다.");
	}
	
	//후기 버튼 클릭시 처리
	$('.reviewBtn').click(function() {
		var pblId = $(this).attr("data-pblprfrId");
		$('#hiPblId').val(pblId);
		$('#reviewModal').modal('show');
	})
		
})

</script>

<title>KG Tiket</title>
</head>
<body>
<input type="hidden" id="reviewRes" value="${reviewRes}">
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
	
	<div class="container-fluid" style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">
			<!-- hidden info -->
		<input type="hidden" id="needLogin" value="${needLogin}"> 

		<!--  -->
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
			<div class="col">
				<div class="row">
					<div class="col-12 text-center">
					<h2>MyPage</h2>
					<hr>
					</div>
				</div>
				<div class="row">
					<div class="col-12">
						<i class="fas fa-caret-right text-danger"  style="font-size: 25px;"></i>
						<font style="font-size: 25px;">최근 예매내역</font><a href="advantkManageForUser.do"><i class="far fa-plus-square" style="float: right; font-size:25px;margin-top: 10px;"></i></a><br>
						<table class="table">
						  <thead class="thead-dark"> 
						    <tr>
							  <th class="text-center" scope="col">예매번호</th>
						      <th scope="col">공연제목</th>
						      <th class="text-center" scope="col">관람일시</th>
						      <th class="text-center" scope="col">매수</th>	
						      <th class="text-right"  scope="col">결제금액</th>
						      <th class="text-center" scope="col">취소가능일</th>
						      <th class="text-center" scope="col">상태</th>
						      <th class="text-center" scope="col">기타</th>
						    </tr>
						  </thead>
						  <tbody>
						    <tr>
						   	 	<c:if test="${ADVANTK.size() == 0}">
									<td colspan="9" style="text-align: center">데이터가 없습니다.</td>
								</c:if>
								<c:if test="${ADVANTK.size()>0}"> 
							  <c:forEach var="i" begin="0" end="${ADVANTK.size()-1}" step="1">
							    <tr>
							      <th scope="row" class="advantkId text-center">${ADVANTK[i].advantkId}</th>
							      <td class="align-middle">${ADVANTK[i].pblprfrNm}</td>
							      <td class="align-middle text-center">${ADVANTK[i].scrinngDt}</td>
							      <td class="align-middle text-center">${ADVANTK[i].advantkNmrs}매</td>
							      <td class="text-right align-middle">${ADVANTK[i].purchsPc}원</td>
							      <td class="align=middle text-center">${cclPsDate[i]} 까지</td>
							   <c:if test="${ADVANTK[i].advantkSt =='F'}"> 
							      <td class="align-middle text-center text-primary">예매완료</td>
							      <td class="align-middle text-center">
							   	  	<button class="btn btn-sm btn-secondary reviewBtn" data-pblprfrid="${advantkList[i].pblprfrId}" disabled="disabled">후기글 쓰기</button>
							   	  </td>
							   </c:if>
							   <c:if test="${ADVANTK[i].advantkSt =='C'}">  
							      <td class="align-middle text-center text-muted">예매취소</td>
							      <td class="align-middle text-center">
							   	  	<button class="btn btn-sm btn-secondary reviewBtn" data-pblprfrid="${ADVANTK[i].pblprfrId}" disabled="disabled">후기글 쓰기</button>
							   	  </td>
							   </c:if>
							   <c:if test="${ADVANTK[i].advantkSt =='E'}">  
							      <td class="align-middle text-center text-success">사용완료</td>
							      <td class="align-middle text-center">
							   	  	<button class="btn btn-sm btn-success reviewBtn" data-pblprfrid="${ADVANTK[i].pblprfrId}">후기글 쓰기</button>
							   	  </td>
							   </c:if> 
							    </tr>
							  </c:forEach> 
						  </c:if>
						    </tr>  
						  </tbody>
						</table>
					</div>
				</div>
				<hr>
				<div class="row" style="margin-top: 30px;">
					<div class="col-6">
						<i class="fas fa-caret-right text-danger"  style="font-size: 25px;"></i>
						<font style="font-size: 25px;">관심 공연</font><a href="selectIntrst.do"><i class="far fa-plus-square" style="float: right;font-size:25px;margin-top: 10px;"></i></a><br>
						<table class="table">
						  <thead class="thead-dark">
						    <tr>
						      <th scope="col">#</th>
						      <th class="text-center" scope="col">공연제목</th>
						      <th class="text-center" scope="col">공연기간</th>
						    </tr>
						  </thead>
							<tbody>
								<c:if test="${INTRST.size() == 0}">
										<td colspan="2" style="text-align: center">데이터가 없습니다.</td>
								</c:if>
								<c:if test="${INTRST.size() > 0}">
									<c:forEach var="i" begin="0" end="${INTRST.size()-1}" step="1">
										<tr>
											<th scope="row">${i+1}</th>
											<td class="text-center">${INTRST[i].pblprfrNm }</td>
											<td class="text-center">${INTRST[i].pblprfrBgnde }</td>
										</tr>
									</c:forEach>
								</c:if>
							</tbody>
						</table>
					</div>
					<div class="col-6">
						<i class="fas fa-caret-right text-danger"  style="font-size: 25px;"></i>
						<font style="font-size: 25px;">나의 문의</font><a href="selectMberInq.do"><i class="far fa-plus-square" style="float: right;font-size:25px;margin-top: 10px;"></i></a>
						<table class="table">
						  <thead class="thead-dark" >
						    <tr>
						      <th scope="col">#</th>
						      <th scope="col">문의제목</th>
						      <th scope="col">작성날짜</th>
						      <th scope="col" >내용</th>
						      <th scope="col">답변여부</th>
						      <th scope="col">&nbsp;</th>
						    </tr>
						  </thead>
						  <tbody>
								<c:if test="${MBERINQ.size() == 0}">
								<tr>
									<td colspan="4" style="text-align: center">데이터가 없습니다.</td>
								</tr>
								</c:if>
								<c:if test="${MBERINQ.size() > 0}">
								<c:forEach var="i" begin="0" end="${MBERINQ.size()-1}" step="1">
								<tr>
									<th scope="row">${i+1}</th>
									<td><div class="title"><a href="mberInqSelectForm.do?inqryNo=${MBERINQ[i].inqryNo}">${MBERINQ[i].inqrySj }</a></div></td>
									<td>${MBERINQ[i].registDate }</td>
									<td><div class="content">${MBERINQ[i].content }</div></td>
								<c:if test="${MBERINQ[i].answerAt =='N'}"> 
							     	<td class="align-middle text-primary">답변 대기</td>
							     	<td class="align-middle text-center">
							   	  	</td>
							   	</c:if>
							   	<c:if test="${MBERINQ[i].answerAt =='Y'}"> 
							     	<td class="align-middle text-primary">답변 완료</td>
							     	<td class="align-middle text-center">

							   	 	</td>
							   	</c:if>
								</tr>
								</c:forEach>
								</c:if>
						
						  </tbody>
						</table>
					</div>
				</div>
				<div class="row">
				<div class="col">
					<div style="float: right;">
						<input type="button" id="mberUpdate"	class="btn btn-secondary"value="회원정보 수정" style="width: 150px;"onclick="location = 'mberUpdatePassConfirmForm.do'">&nbsp;&nbsp;
						<input type="button" id="mberAtUpdate"	class="btn btn-secondary"value="회원탈퇴"    style="width: 150px;"onclick="location = 'mberUpdate.do?mberAt=N'"> 
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