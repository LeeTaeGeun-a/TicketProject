<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/56df2e9734.js" crossorigin="anonymous"></script>
<link href="css/bootstrap-grid.css" rel="stylesheet">
<link href="css/bootstrap-reboot.min.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/main.css" rel="stylesheet">
<script>
$(function() {


	
	var needLogin = $('#needLogin').val();
	if(needLogin =="Y")
	{
		$('#needLoginService').removeAttr("hidden");
		$('#thebody').hide();
		$('#loginModal').modal('show');
	}
	
	$("#confirm").click(function(){
		var pw    = '${DTO.mberPw}';
		var inputPw = $('#mberPw').val();
		if(pw == inputPw)
		{
			location ="mberUpdateForm.do";
		}
		if(pw != inputPw)
		{
			alert("비밀번호를 다시 확인해주십시오");
			return;
		}
	});


});

</script>

<title>KG Tiket</title>
</head>
<body>

		<!-- nav라인 까지 ROW 종료 -->
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
				<input type="hidden" id="needLogin" value="${needLogin}"> 
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
						<font style="font-size: 25px;">회원정보 수정</font><br>

						<table class="table" >
						  <thead class="thead-dark"> 
						    <tr>
						      <td><h2>회원님의 회원정보 확인을 위해 비밀번호를 한번 더 입력해 주세요.</h2></td>
						    </tr>
						   
						  </thead>
						  <tbody>
						   <tr>
						     <td>비밀번호가 타인에게 노출되지 않도록 주의하시기 바랍니다.</td>
						    </tr>
						    <tr>
						     <td>비밀번호에는 개인정보를 포함하거나 아이디를 포함한 비밀번호, 집전화, 휴대폰 번호 , 영문 성명등<br> 
									타인이 유추할 수 있는 비밀번호는 사용 하지 않는 것이 좋습니다.</td>
						    </tr>
						    <tr style="float: left;">
						    	<td>아이디</td>
						    	<td>${loginedId}</td>
						    </tr>
						    <tr style="float: left;">
						    	<td>비밀번호</td>
						    	<td><input type="password" class="form-control" name="mberPw" id="mberPw"  placeholder="비밀번호를 입력하세요." required/></td>
						    </tr>

						  </tbody>
						</table>
				
					</div>
				</div>
				<div class="row">
				<div class="col">
					<div style="float: right;">
					
						<input type="button" class="btn btn-secondary"value="확인" style="width: 150px;" id = "confirm">&nbsp;&nbsp;
						<input type="button" class="btn btn-secondary"value="취소" style="width: 150px;"onclick="location = 'myPageHome.do'"> 
		
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



<script type="text/javascript" src="js/common.js"></script>		
</body>
</html>