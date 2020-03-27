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
	var check = '${CHECK}';
	var res   = '${UPDATERES}';
	if(res == 'success')
	{
		alert("회원 정보 변경에 성공했습니다.");
		window.location.href='/TiketProject';
	}
	
	if(check =='fail')
	{
	
		alert("로그인 후 이용바랍니다.");
		 $('#loginModal').modal('show');
	}
	
	
	$("#confirmPw").keyup(function(){
		var pwCnfm = $('#confirmPw').val();
		var pw = $('#mberPw').val();
		if(pwCnfm == pw)
		{
			$("#pwCkMsg").html("비밀번호가 일치합니다.").css("color","blue");
		}
		else if(pwCnfm != pw)
		{
			$("#pwCkMsg").html("비밀번호가 틀립니다.").css("color","red");
		}
	});
	
	$("#mberPw").keyup(function(){
		var pwCnfm = $('#confirmPw').val();
		var pw = $('#mberPw').val();
		if(pwCnfm == pw)
		{
			$("#pwCkMsg").html("비밀번호가 일치합니다.").css("color","blue");
		}
		else if(pwCnfm != pw)
		{
			$("#pwCkMsg").html("비밀번호가 틀립니다.").css("color","red");
		}
	});
	
	$("#update").click(function(){
		var pwCnfm = $('#confirmPw').val();
		var pw = $('#mberPw').val();
		if(pwCnfm == pw)
		{
			document.form.submit();
		}
		else if(pwCnfm != pw)
		{
			alert("비밀번호가 일치하지않습니다.");
			return false;
		}
		
	});
	
	$("#cancle").click(function(){
		location("/TiketProject");
		
	});
});

</script>

<title>KG Tiket</title>
</head>
<body>	
			<div class="container" style="margin-top: 30px;"  >
			<div class="row">
			<div class="col-10" style="float: none; margin: 0 auto;">
				<form class="form-horizontal" method="post" action="mberUpdate.do">
				<div class="row">
					<div class="col-10 text-center " style="float: none; margin: 0 auto;">
					<h2>개인 정보 수정</h2>
					<h4>${DTO.mberId}님의  정보입니다.<br></h4>
						<h5>회원정보는 개인정보처리방침에 따라 안전하게 곧 보호될 것이며,<br> 회원님의 명백한 동의 없이 공개 또는 제 3자에게 제공되지 않습니다.</h5>
					</div>	
				</div>	
				<div class="row">
					<div class="col-10 " style="float: none; margin: 0 auto;">	
						<div class="form-group">
							<label for="mberId" class="cols-sm-2 control-label">아이디</label>
							<div class="input-group">
								<i class="fa fa-id-card" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="text" class="form-control" name="mberId" id="mberId" minlength="6" maxlength="20" value="${DTO.mberId}" readonly/>
							</div>
							<div id="idCk" style="font-size: 12px;"></div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-10 " style="float: none; margin: 0 auto;">
						<div class="form-group">
							<label for="mberNm" class="cols-sm-2 control-label">이름</label>
							<div class="input-group">
								<i class="fa fa-user fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="text" class="form-control" name="mberNm" id="mberNm"   value="${DTO.mberNm }"/>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-10 " style="float: none; margin: 0 auto;">
						<div class="form-group">
							<label for="mberEmail" class="cols-sm-2 control-label">이메일</label>
							<div class="input-group">
								<i class="fa fa-envelope fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="text" class="form-control mberEmail" name="mberEmail" id="mberEmail" value="${DTO.mberEmail }" />
								<font style="font-size: 20px; margin-top: 3px;">@</font>
								<input type="text" class="form-control mberEmail" name="emSite" id="emSite" value="${DTO.emSite }" />
							</div> 
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-10 " style="float: none; margin: 0 auto;">
						<div class="form-group">
							<label for="email" class="cols-sm-2 control-label">핸드폰번호</label>
							<div class="input-group">
								<i class="fa fa-phone-square fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="tel" class="form-control" name="mberTel" id="mberTel"  minlength="11" maxlength="11" value="${DTO.mberTel }" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-10 " style="float: none; margin: 0 auto;">
						<div class="form-group">
							<label for="password" class="cols-sm-2 control-label">비밀번호 수정</label>
							<div class="input-group">
								<i class="fa fa-unlock fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="password" class="form-control" name="mberPw" id="mberPw" minlength="6" maxlength="20"  placeholder="비밀번호를 입력하세요." />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-10 " style="float: none; margin: 0 auto;">
						<div class="form-group">
							<label for="confirm" class="cols-sm-2 control-label">비밀번호 확인</label>
							<div class="input-group">
								<i class="fa fa-lock fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="password" class="form-control" name="confirmPw" id="confirmPw"  vc="6" maxlength="20"  placeholder="비밀번호를 다시한번 입력하세요." />
							</div>
							<div id="pwCkMsg" style="font-size: 12px;"></div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-10 " style="float: none; margin: 0 auto;">
						<div class="form-group " style="float: right;margin-bottom: 100px;">
							<input  type="submit" id = "update" class="btn btn-secondary" value="수정하기" style="width: 150px;">
							<button type="button" id = "cancle" class="btn btn-secondary" style="width: 150px;">취소</button>
						</div>
					</div>
				</div>
				</form>
			</div>
		</div>
	</div>
		



<script type="text/javascript" src="js/common.js"></script>		
</body>
</html>