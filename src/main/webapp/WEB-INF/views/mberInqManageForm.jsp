<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<!-- <script type="text/javascript" src="js/intrstPbl.js"></script>		 -->
<title>KG Tiket</title>
<style type="text/css">
.pblImg:hover{
	border: solid 1px;
	border-color: red;
}
</style>
<script type="text/javascript">
function sub(index){
	if(index == 1)
	{
		document.inqManage.action = "mberInqInsert.do";
	}
	if(index == 2)
	{
		document.inqManage.action = "mberInqUpdate.do";
	}
	if(index == 3)
	{
		if(confirm("문의 글을 삭제하시겠습니까?") == true)
		{
			document.inqManage.action = "mberInqDelete.do";
		}else 
		{
			return;
		}
	 	
	}
	document.inqManage.submit();
}
$(function() {
	var upd   = "${UPDRES}";
	var del   = "${DELRES}";
	var ins   = "${INSRES}";
	var value = "${INSERT}";
	var answerAt = "${WOW}";

	$("#insert").hide();
	if(value == '1')
	{
		$("#insert").show();
		$("#update").hide();
		$("#delete").hide();
	}
	if(answerAt == '1')
	{
		$("#update").hide();
	}
	if(ins == '1')
	{
		alert("문의글 등록이 정상처리되었습니다.");
		var url = "http://localhost:8085/TiketProject/selectMberInq.do";
		$(location).attr('href',url);
	}
	if(upd == '1')
	{
		alert("수정이 정상처리되었습니다.");
		var url = "http://localhost:8085/TiketProject/myPageHome.do";
		$(location).attr('href',url);
	}
	if(del == '1')
	{
		alert("삭제가 정상처리되었습니다.");
		var url = "http://localhost:8085/TiketProject/myPageHome.do";
		$(location).attr('href',url);
	}
	

});
</script>
</head>
<body>
	<div class="container-fluid" style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">		
		
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
			<div class="col">
				<div class="row">
					<div class="col-6 text-center" style="float: none; margin: 0 auto;">
						<div class="row">
						<form name="inqManage" method="post">
							<div class="col" style="float: none; margin: 0 auto;">
							<h2 style="margin-bottom: 40px;">나의 문의</h2>
							<div class="block" >
							<input type="hidden" name="inqryNo" value="${DTO.inqryNo}">
						
							<table class="table" style="margin;">
								<thead>
									<tr>
										<td width="70"  align="center">제 목</td>
										<td width="330" align="left"><input type="text" size="79"
											maxlength="10" name="inqrySj" value="${DTO.inqrySj }" style="ime-mode: active;"></td>
									</tr>
									<tr>
										<td width="70"  align="center">내 용</td>
										<td width="330" align="left"><textarea name="content"
												rows="13" cols="80" style="ime-mode: active;resize: none;">${DTO.content }</textarea></td>
									</tr>
								<c:if test="${WOW == '1'}"> 


										<tr>
											<td width="70"  align="center">답 변</td>
											<td width="330" align="left"><textarea name="content"
													rows="13" cols="80" style="ime-mode: active;resize: none;"readonly >${ANS.content }</textarea></td>
										</tr>

								</c:if>
								</tbody>
							</table>
							</div>
						</div>
						<div class="row">

								
				
						</div>
						<div class="row">
								<div class="col">
									<input type="button" class="btn btn-secondary" onClick='sub(1)'
										value="등록" style="width: 150px;" id="insert">&nbsp;&nbsp;
									<input type="button" class="btn btn-secondary" onClick='sub(2)' 
										value="수정" style="width: 150px;"id= "update" >&nbsp;&nbsp;
									<input type="button" class="btn btn-secondary" onClick='sub(3)'
										value="삭제" style="width: 150px;"id= "delete"  >&nbsp;&nbsp;
									<input type="button" class="btn btn-secondary"
										value="돌아가기" style="width: 150px;" onclick="location = 'myPageHome.do'">
								</div>
						</div>
						</form>
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