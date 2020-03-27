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
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/main.css" rel="stylesheet">
<link href="css/mbrJoin.css" rel="stylesheet">
<link href="css/advantkResForm.css" rel="stylesheet">
<title>KG TIKET 예매완료</title>
<script type="text/javascript">
$(function() {
	
	$('#homeBtn').click(function() {
		document.location = "/TiketProject";
	})
	
	$('#confirmAdvBtn').click(function() {
		document.location = "advantkManageForUser.do";
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
						<h3>예매가 완료되었습니다.</h3>
						<h5 class="text-muted">2020.09.25/14:00</h5>
					</div>
					<table>
						<tr>
							<th><div>예매번호</div></th>
							<td><div>${advantkDto.advantkId}</div></td>
						</tr>
						<tr>
							<th><div>예매정보</div></th>
							<td>
								<div>[${pblJoinDto.genre}]&nbsp;${pblJoinDto.pblNm}&nbsp;</div>
								<div>[${advantkDto.advantkSeats}]</div>
								<div>${advantkDto.purchsPc}원</div>
								<div>${pblJoinDto.theatLoc}</div>
							</td>
						</tr>
						<tr>
							<th><div>예약자정보</div></th>
							<td>
								<div>${mberDto.mberNm}</div>
								<div>${mberDto.mberTel}</div>
							</td>
						</tr>
						<tr>
							<th><div>관람자정보</div></th>
							<td>
								<div>${advantkDto.viewPsNm}</div>
								<div>${advantkDto.viewPsTel}</div>
								<div>${advantkDto.viewPsEmail}</div>
							</td>
						</tr>
						<tr>
							<th><div>취소가능 일시</div></th>
							<td>
								<div>${canclePsDate} 18:00 전 까지</div>
							</td>
						</tr>
					</table>
					<div class="text-center">
						<button class="btn btn-secondary" id="homeBtn">홈</button>
						<button class="btn btn-danger"    id="confirmAdvBtn">예매확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>	

</body>
</html>