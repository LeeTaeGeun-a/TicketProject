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

</style>
<script>
function sub(index){
	
	if(index == 1)
	{
		document.mngInq.action = "mngInqAnswerInsert.do";
	}
	if(index == 2)
	{
		document.mngInq.action = "mngInqUpdate.do";
	}

	document.mngInq.submit();
}
$(function() {
		var upd = "${UPDRES}";
		if( upd == '4')
		{
			alert("답변 수정이 정상처리되었습니다.");
			var url = "http://localhost:8085/TiketProject/mngInqListSelect.do";
			$(location).attr('href',url);
		}	
		var ins = "${INSRES}";
		if(ins == '1')
		{
			alert("답변등록이 정상처리되었습니다.");
			var url = "http://localhost:8085/TiketProject/mngInqListSelect.do";
			$(location).attr('href',url);
		}	
});
</script>
</head>
<body >
	<div class="container-fluid dd" style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">		
		
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
			
			<div class="col">
				<div class="row">
					<div class="col-12 text-center">
						<h2 style="margin-bottom: 40px;">문의 확인</h2>
						<div class="block" style="float: none; margin: 0 auto;">
						<form name = "mngInq" method="post">
						<c:if test="${ANS != null}">
							<input type="hidden" value="${ANS.inqryNo}" name="inqryNo">
						</c:if>
						<c:if test="${ANS == null}">
							<input type="hidden" value="${DTO.inqryNo}" name="inqryNo">
							<input type="hidden" value="${DTO.mberId}"  name="mberId">
						</c:if>
						<table class="table" >
							<thead>
								<tr>
								<th width="25%" >아이디</th>
								<th width="25%" style="text-align:left;">${DTO.mberId }</th>
								</tr>
									<tr>
								<td width="100" align="center">전화번호</td>
								<td width="100" align="left">${DTO.mberTel }</td>
								</tr>
								<tr>
								<td width="100" align="center">이메일</td>
								<td width="100" align="left">${DTO.mberEmail }</td>
								
								
								<td width="100" align="center"></td>
								<td width="330" align="left">문의 답변</td>
								</tr>
								<tr>
									<td width="100"  align="center">제 목</td>
									<td width="330" align="left">
									<input type="text" size="79"maxlength="10" value="${DTO.inqrySj }" style="ime-mode: active;" readonly></td>
							
										<td width="25%"  align="center">제 목</td>
										<td width="330" align="left">
										<input type="text" size="79"maxlength="10" name="inqrySj" value="${ANS.inqrySj }"style="ime-mode: active;" ></td>
							
								</tr>
								<tr>
									<td width="100"  align="center">내 용</td>
									<td width="330" align="left">
									<textarea rows="5" cols="80" style="ime-mode: active;resize: none;" readonly>${DTO.content }</textarea></td>
									
										<td width="25%"  align="center">내 용</td>
										<td width="330" align="left">
									<textarea rows="5" cols="80" name="content" style="ime-mode: active;resize: none;" >${ANS.content }</textarea></td>
							
								</tr>
							</thead>
							</tbody>
						</table>
						<div class="row">
							<div class="col 6" style="float:right;">
								<c:if test="${ANS == null}">
									<input type="button" class="btn btn-secondary"  onClick='sub(1)'
										value="답변달기" style="width: 150px;">&nbsp;&nbsp;
								</c:if>
								<c:if test="${ANS != null}">
									<input type="button" class="btn btn-secondary" onClick='sub(2)'
										value="수정하기" style="width: 150px;">&nbsp;&nbsp;
								</c:if>
									<input type="button" class="btn btn-secondary"
										value="돌아가기" style="width: 150px;" onclick="location = 'mngInqListForm.do'">
								</div>
						</div>
						</form>
						</div>
					</div>
				</div>
				<div class="row">
					</div>
				</div>
	
			</div>
			<!-- 오른쪽 여백을 만들기 위한 div -->
			<div class="col-1 "></div>
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