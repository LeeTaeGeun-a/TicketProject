<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>아이디 찾기</title>
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
</head>
<body>
	<div class="container">
		<div class="row main">
			<div class="col">
				<div class="main-login main-center">
					<div class="text-center">
						<a href="/TiketProject"><img src="img/titleLog.png"
							class="block" width="400" height="100"
							style="margin-bottom: 20px; margin-right: 70px;"></a>
					</div>
					<form class="form-horizontal" method="post" action="mberIdFind.do">


						<div class="form-group">
							<label for="mberNm" class="cols-sm-2 control-label">이름</label>
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
							<label for="mberEmail" class="cols-sm-2 control-label">이메일</label>
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
						
						<div class="row" style="margin-top: 30px;">
						
							<div class="col">
								<div class="login-register ">
									<input type="submit" class="btn btn-success btn-lg btn-block login-button" value="ID찾기">
								</div>
							</div>
							<div class="col">
								<div class="login-register">
									<button type="button" onclick="location = 'mberPwFindForm.do'" class="btn btn-success btn-lg btn-block login-button">비밀번호찾기</button>
								</div>
							</div>
						</div>
						<div class="login-register">
							<button type="button" id="cancle"
								class="btn btn-warning btn-lg btn-block login-button">취소</button>
						</div>
					</form>
					<c:if test="${CHECK == 'fail'}">
						<script type="text/javascript">
							alert("입력하신 정보와 일치하는 아이디가 없습니다.\n정보를 다시 입력하시고 아이디 찾기를 시행해주세요.");
						</script>
						<br>
						<br>
						<br>
						<hr width=60% color="#819FF7" align="center" size=2 />
						<h2 align = "center">가입된 ID가 없습니다.</h2>
						<hr width=60% color="#819FF7" align="center" size=2 />
					</c:if>
					<c:if test="${CHECK == 'success'}">
						<script type="text/javascript">
							alert("입력하신 정보와 일치하는 아이디는 아래와 같습니다.\n개인정보보호를 위해 끝자리는 *로 표시합니다.");
						</script>
						<br>
						<br>
						<br>
						<hr width=60% color="#819FF7" align="center" size=2 />
						<h2 align = "center">${FIND}</h2>
						<hr width=60% color="#819FF7" align="center" size=2 />
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript" src="js/mbrJoin.js"></script>
</body>

</html>