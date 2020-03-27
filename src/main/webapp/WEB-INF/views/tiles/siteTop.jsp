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
<script type="text/javascript" src="js/common.js"></script>		
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script src="https://kit.fontawesome.com/56df2e9734.js" crossorigin="anonymous"></script>
<link href="css/jquery-ui.css" rel="stylesheet">
<link href="css/bootstrap-grid.css" rel="stylesheet">
<link href="css/bootstrap-reboot.min.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/main.css" rel="stylesheet">



<title>KG Tiket</title>
</head>
<body>
	<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="margin-top: 250px;">
		
			<div class="modal-header">
			<h4 class="modal-title" id="myModalLabel">Log in</h4>
			<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
			</div> <!-- /.modal-header -->
			<div class="modal-body">
				<form role="form"  action="login.do" method="post" id="loginForm">
					<div class="form-group">
						<div class="input-group">
							<input type="text" class="form-control" id="uLogin" name="mberId" placeholder="UserId" required>
							<img src="css/icons/person-fill.svg" width="32" height="32"> 
						</div>
					</div> 

					<div class="form-group">
						<div class="input-group">
							<input type="password" class="form-control" id="uPassword" name="mberPw" placeholder="Password" required>
							<img src="css/icons/lock-fill.svg" width="32" height="32"> 
						</div> 
					</div> 
					<div id="loginState"></div>
					<hr>
					<input type="submit" class="form-control btn btn-primary" value="LOGIN">
					<input type="hidden" id="loginRes"  value="${loginRes}"> 
					<input type="hidden" id="level"     value="${level}">
					<input type="hidden" id="inputedId" value="${inputedId}">
					<input type="hidden" id="loginedId" value="${loginedId}">
				</form>
					<div class="row" style="margin-top: 10px;">
						<div class="col-8 text-left">
							<a href="mberIdFindForm.do" style="text-decoration: none">아이디 찾기</a> / <a href="mberPwFindForm.do" style="text-decoration: none">비밀번호 찾기</a>
						</div>
						<div class="col-4 text-right">
							<a href="mberInsertForm.do" style="text-decoration: none">회원가입</a>
						</div>
					</div>
			</div> <!-- /.modal-body -->
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<div class="container-fluid"
		 style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">
		<div class="header_top" style="margin-bottom: 30px;">
			<!--header_top-->
			<div class="row">
				<div class="col-4 text-center" style="float: none; margin: 0 auto;" >
					<a href="/TiketProject"><img style="float: left;" src="img/logo1.png" width="120px" height="120px"></a>
					<p style="margin-top: 20px;" class="h1 text-dark"><a class="homeLink" href="/TiketProject" style="text-decoration: none;">문화 공연 플랫폼</a></p>
					<span class="h4 align-bottom text-muted"><font color="red">KG</font> 문화 티켓</span>
				</div>
			</div>
			<div class="row" style="margin-top: 30px; margin-bottom: 30px;">
				<div class="col-6 text-center" style="float: none; margin: 0 auto;" >
					
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12" style="float: none; margin: 0 auto;">
				<nav class="navbar navbar-dark bg-dark"> 
					<div class="col-1 offset-1">
						<button class="navbar-toggler" type="button"
							data-toggle="collapse" data-target="#navbarSupportedContent"
							aria-controls="navbarSupportedContent" aria-expanded=""
							aria-label="Toggle navigation" style="float: right;">
							<span class="navbar-toggler-icon" ></span>
						</button>
					</div>
					<div class="col-3">
						<nav class="nav" style=" padding-left: 15px;">
						  <a class="nav-link text-white hmenu" href="selectPblList.do?schedule=today" style="margin-right: 15px;">오늘공연</a>
						  <a class="nav-link text-white hmenu" href="selectPblList.do?schedule=tomorrow" style="margin-right: 15px;">내일공연</a>
						  <a class="nav-link text-white hmenu" href="selectPblList.do?schedule=all" >전체공연</a>
						</nav>
					</div>
					<div class="col-3">
						<form class="form-inline" action="selectPblList.do" method="get" style="padding-left:50px;">
							<input class="form-control"  type="search" style="margin-right: 10px; width: 70%"
					     	  	   placeholder="Search" aria-label="Search" name="searchWord">
							<button class="btn btn-warning" type="submit">검색</button>
						</form>
					</div>
					<!-- 검색창 -->
					<div class="col-4" >
						<nav class="nav" style="float: left;">
						  <a class="nav-link text-white hmenu" href="myPageHome.do" id="myPageBtn">마이페이지</a>
						  <a class="nav-link text-white hmenu" href="#" data-toggle="modal" data-target="#loginModal" id="login">로그인</a>
						  <a class="nav-link text-white hmenu" href="logOut.do" id ="logOut" >로그아웃</a>
						  <a class="nav-link text-white hmenu" href="noticeSelectAll">공지사항</a>
						  <div class="nav-item dropdown">
						  
						
						  </div> 
						  <a href="mngHome.do"><i class="fas fa-cog text-white" id="cog" style="font-size: 32px; margin-top: 5px;"></i></a>  
						</nav>
					</div>
				</nav>
			</div>
		</div>
		
			<!-- 메뉴옆에꺼 눌렀을때 아래에 뜨는거 -->
		<div class="collapse" id="navbarSupportedContent">
			<div class="p-4 bg-dark">
				<div class="row">
					
					<div class="col-8 bolcok-center" style="float: none; margin: 0 auto;">
					<hr class="bg-warning">
						<div class="row" id="subMenu">
							<div class="col-4">
								<h5 class="text-warning">장르별 공연</h5>
								<ul class="text-danger">
									<li><a href="selectPblList.do?genre=drama" 		class="text-decoration-none">연극</a></li>
									<li><a href="selectPblList.do?genre=musical" 	class="text-decoration-none">뮤지컬</a></li>
									<li><a href="selectPblList.do?genre=concert" 	class="text-decoration-none">콘서트</a></li>
									<li><a href="selectPblList.do?genre=childdrama" class="text-decoration-none">아동극</a></li>
								</ul>
							</div>
							<div class="col-4">
								<h5 class="text-warning">지역별 공연</h5>
								<ul class="text-danger">
									<li><a href="selectPblList.do?area=area01" class="text-decoration-none">경기/서울</a></li>
									<li><a href="selectPblList.do?area=area02" class="text-decoration-none">대전/충청</a></li>
									<li><a href="selectPblList.do?area=area03" class="text-decoration-none">경상/대구/부산</a></li>
									<li><a href="selectPblList.do?area=area04" class="text-decoration-none">전라/광주/전주</a></li>
									<li><a href="selectPblList.do?area=area05" class="text-decoration-none">기타지역</a></li>
								</ul>
							</div>
							<div class="col-4">
								<h5 class="text-warning">마이페이지</h5>
								<ul class="text-danger">
									<li><a href="advantkManageForUser.do" class="text-decoration-none">예매내역</a></li>
									<li><a href="selectMberInq.do" class="text-decoration-none">나의 문의</a></li>
									<li><a href="mberUpdatePassConfirmForm.do" class="text-decoration-none">개인정보수정</a></li>
									<li><a href="selectIntrst.do" class="text-decoration-none">관심목록</a></li>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>