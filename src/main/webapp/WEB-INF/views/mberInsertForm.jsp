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
<link href="css/mbrJoin.css" rel="stylesheet">
<title>KG Tiket 회원가입</title>
<script type="text/javascript">
$(function() {
//회원가입 결과 처리
	
	var mberId		= '${insertedInfo.mberId}';
	var mberNm 		= '${insertedInfo.mberNm}';
	var mberEmail	= '${insertedInfo.mberEmail}';
	var mberEmsite	= '${insertedInfo.emSite}';
	var mberTel 	= '${insertedInfo.mberTel}';
	var mberpw		= '${insertedInfo.mberPw}';
	
	var insertRes = $('#insertRes').val();
	if(insertRes == '1')
	{
		alert("회원가입 완료되었습니다.");
		location("/TiketProject");
	}
	else if(insertRes == '0')
	{
		alert("이미 해당 Id가 존재합니다.");
		$('#mberId').focus();
		$('#mberNm').val(mberNm);
		$('#mberEmail').val(mberEmail);
		$('#emSite').val(mberEmsite);
		$('#mberTel').val(mberTel);
	}
	else if(insertRes == '2')
	{
		$('#pwCkMsg').html("<font color='red'>비밀번호가 일치하지 않습니다.</font>");
		$('#confirmPw').focus();
		$('#mberId').val(mberId);
		$('#mberpw').val(mberPw);
		$('#mberNm').val(mberNm);
		$('#mberEmail').val(mberEmail);
		$('#emSite').val(mberEmsite);
		$('#mberTel').val(mberTel);
	}
	
	$('#mberId').keyup(function() {
		var mberId = $('#mberId').val();
		if(mberId == "")
		{
			$('#idCk').html("");
		}
	})
	
	$('#mberIdCk').click(function() {
		
		var url 	= "mberIdCk.do";
		var mberId  = $('#mberId').val();
		
		if(mberId =="")
		{
			alert("ID를 입력해주세요");
			return;
		}
		
		$.getJSON(url,{"mberId":mberId} , function(json) {
			
			var res = json.mberIdCkRes;
			if(res == "1")
			{
				$('#idCk').html("<font color='green'>사용가능한 ID 입니다.</font>");
				$('#mberId').focus();
			}
			else if (res == "0")
			{
				$('#idCk').html("<font color='red'>중복된 ID 입니다.</font>");
				$('#mberId').focus();
			}
			
		})
		
	})
	
})

</script>

</head>
<body>
	<div class="container">
		<div class="row main">
		<div class="col">
			<div class="main-login main-center">
				<div class="text-center">
					<a href="/TiketProject"><img src="img/titleLog.png" class="block" width="400" height="100" style="margin-bottom: 20px; margin-right: 70px;"></a>
				</div>
				<form class="form-horizontal" method="post" action="mberInsert.do">
					<div class="form-group">
						<label for="mberId" class="cols-sm-2 control-label">아이디</label>
						<button class="btn btn-sm btn-secondary" style="float: right;" id="mberIdCk">아이디 중복확인</button>
						<div class="cols-sm-10">
							<div class="input-group">
								<i class="fa fa-id-card" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="text" class="form-control" name="mberId" id="mberId" minlength="6" maxlength="20" placeholder="아이디를 입력하세요." required/>
							</div>
							<div id="idCk" style="font-size: 12px;"></div>
						</div>
					</div>
					
					<div class="form-group">
						<label for="mberNm" class="cols-sm-2 control-label">이름</label>
						<div class="cols-sm-10">
							<div class="input-group">
								<i class="fa fa-user fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="text" class="form-control" name="mberNm" id="mberNm"  placeholder="이름을 입력하세요." required/>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="mberEmail" class="cols-sm-2 control-label">이메일</label>
						<div class="cols-sm-10">
							<div class="input-group">
								<i class="fa fa-envelope fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="text" class="form-control mberEmail" name="mberEmail" id="mberEmail" placeholder="이메일을 입력하세요." required/>
								<font style="font-size: 20px; margin-top: 3px;">@</font>
								<input type="text" class="form-control mberEmail" name="emSite" id="emSite" placeholder="ex)naver.com" required/>
							</div>
						
						</div>
					</div>
					
					<div class="form-group">
						<label for="email" class="cols-sm-2 control-label">핸드폰번호</label>
						<div class="cols-sm-10">
							<div class="input-group">
								<i class="fa fa-phone-square fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="tel" class="form-control" name="mberTel" id="mberTel"  minlength="11" maxlength="11" placeholder="핸드폰 번호를 입력하세요.('-'생략)" required/>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="password" class="cols-sm-2 control-label">비밀번호</label>
						<div class="cols-sm-10">
							<div class="input-group">
								<i class="fa fa-unlock fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="password" class="form-control" name="mberPw" id="mberPw" minlength="6" maxlength="20"  placeholder="비밀번호를 입력하세요." required/>
							</div>
						</div>
					</div>

					<div class="form-group">
						<label for="confirm" class="cols-sm-2 control-label">비밀번호 확인</label>
						<div class="cols-sm-10">
							<div class="input-group">
								<i class="fa fa-lock fa" style="font-size: 32px;margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
								<input type="password" class="form-control" name="confirmPw" id="confirmPw" minlength="6" maxlength="20"  placeholder="비밀번호를 다시한번 입력하세요." required/>
							</div>
									<div id="pwCkMsg" style="font-size: 12px;"></div>
						</div>
					</div>

					<div class="form-group ">
						<input type="submit" class="btn btn-warning btn-lg btn-block login-button" value="가입완료">
					</div>
					<div class="login-register">
						<button type="button" id="cancle" class="btn btn-primary btn-lg btn-block login-button">취소</button>
					</div>
				</form>
				<input type="hidden" id="insertRes" value="${insertRes}">
			</div>
		</div>
		</div>
	</div>	
<script type="text/javascript" src="js/mbrJoin.js"></script>
</body>
</html>