<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>비밀번호 찾기</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script src="https://kit.fontawesome.com/56df2e9734.js"
	crossorigin="anonymous"></script>
<link href="css/bootstrap-grid.css" rel="stylesheet">
<link href="css/bootstrap-reboot.min.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/main.css" rel="stylesheet">
<link href="css/mbrJoin.css" rel="stylesheet">
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {

					var mberId = '${info.mberId}';
					var mberNm = '${info.mberNm}';
					var mberEmail = '${info.mberEmail}';
					var mberEmsite = '${info.emSite}';
					
					
					if ('${STEP}' == 'second' || '${STEP}' == 'third') 
						{
							$('#mberId').val(mberId);
							$('#mberNm').val(mberNm);
							$('#mberEmail').val(mberEmail);
							$('#emSite').val(mberEmsite);
							$('#mberCrtfc').focus();
						}

	});
</script>
</head>

<body>

	<c:if test="${STEP == 'second' }">
		<c:if test="${CHECK == 'success'}">
			<script type="text/javascript">
				alert("이메일로 인증번호가 전송되었습니다.");
			</script>
		</c:if>
		<c:if test="${CHECK == 'fail'}">
			<script type="text/javascript">
				alert("입력하신 정보와 일치하는 정보가 없습니다.\n정보를 다시 입력하시고 아이디 찾기를 시행해주세요.");
			</script>
		</c:if>
	</c:if>
	<c:if test="${STEP == 'third' }">
		<c:if test="${CHECK == 'success'}">
			<script type="text/javascript">
				alert("인증번호가 일치합니다.");
			</script>
		</c:if>
		<c:if test="${CHECK == 'fail'}">
			<script type="text/javascript">
				alert("인증번호를 다시 입력해주세요");
			</script>
		</c:if>
	</c:if>
	<c:if test="${STEP == 'forth' }">
	
		<c:if test="${CHECK == 'success'}">
			<script type="text/javascript">
				alert("이메일로 임시비밀번호를 전송했습니다.");
				window.location.href = '/TiketProject';
			</script>
		</c:if>
		<c:if test="${CHECK == 'success'}">
			<script type="text/javascript">
				alert("오류가 발생했습니다.\n다시 진행해주십시오.");
				window.location.href = '/TiketProject';
			</script>
		</c:if>
	</c:if>
	회원가입 시 등록하신 아이디와 이름, 이메일주소를 통해 임시비밀번호를 재발급
	<br> 받으실 수 있습니다. 회원가입시 등록하신 이메일을 입력해주시기 바랍니다.
	<div class="container">
		<div class="row main">
			<div class="col">
				<div class="main-login main-center">
					<div class="text-center">
						<a href="/TiketProject"><img src="img/titleLog.png"
							class="block" width="400" height="100"
							style="margin-bottom: 20px; margin-right: 70px;"></a>
					</div>
					<form class="form-horizontal" method="post">
						<!--  action="mberPwFind.do" -->
						<div class="form-group">
							<label for="mberId" class="cols-sm-2 control-label"></label>
							<div class="cols-sm-10">
								<div class="input-group">
									<i class="fa fa-user fa"
										style="font-size: 32px; margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
									<input type="text" class="form-control" name="mberId"
										id="mberId" placeholder="ID를 입력해주시기 바랍니다." required />
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="mberNm" class="cols-sm-2 control-label"></label>
							<div class="cols-sm-10">
								<div class="input-group">
									<i class="fa fa-user fa"
										style="font-size: 32px; margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
									<input type="text" class="form-control" name="mberNm"
										id="mberNm" placeholder="회원가입 시 등록하신 실명을 입력해주시기 바랍니다."
										required />
								</div>
							</div>
						</div>

						<div class="form-group">
							<label for="mberEmail" class="cols-sm-2 control-label"></label>
							<div class="cols-sm-10">
								<div class="input-group">
									<i class="fa fa-envelope fa"
										style="font-size: 32px; margin-top: 3px;" aria-hidden="true"></i>&nbsp;&nbsp;
									<input type="text" class="form-control mberEmail"
										name="mberEmail" id="mberEmail"
										placeholder="회원가입 시 등록하신 이메일을 입력해주시기 바랍니다." required /> <font
										style="font-size: 20px; margin-top: 3px;">@</font> <input
										type="text" class="form-control mberEmail" name="emSite" 
										id="emSite" placeholder="ex)naver.com" required />
								</div>


							</div>
						</div>
						<div class="login-register ">
						<c:if test="${STEP == null}">
							<input type="submit"
								class="btn btn-primary btn-lg btn-block login-button"
								value="인증번호 받기" formaction="mberCrtfc.do">
						</c:if>
						<c:if test="${STEP == 'second'}">

							<input type="text" class="form-control" name="mberCrtfc"
								style="margin-top: 5px;" id="mberCrtfc"
								placeholder="인증번호를 입력해주세요" required />
									<span  id="confirm"></span>
							<input type="submit"
								class="btn btn-primary btn-lg btn-block login-button"
								value="인증하기" formaction="mberCrtfcConfirm.do"> 

						</c:if>
							<c:if test="${STEP == 'third'}">
							<input type="submit"
								class="btn btn-primary btn-lg btn-block login-button"
								value="임시비밀번호 발급" formaction="mberPwFind.do">
							</c:if>	
						</div>
						<div class="login-register">
							<button type="button" id="cancle"
								class="btn btn-primary btn-lg btn-block login-button">취소</button>
						</div>
					</form>

				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/mbrJoin.js"></script>
</body>
</html>