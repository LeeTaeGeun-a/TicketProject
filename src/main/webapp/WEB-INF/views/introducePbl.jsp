<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/bootstrap-grid.css" rel="stylesheet">
<link href="css/bootstrap-reboot.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" media="screen">
<link href="css/main.css" rel="stylesheet">


<style type="text/css">
#detailInfo tr, td{
	border: solid 1px;
	font-size: 15px;
}
.ti{
	background-color: #dadbde;
}
</style>

</head>
<body>
<h4 style="margin-top: 60px;">티켓 수령</h4>
<hr>
현장수령
<br><br><br>
<h4>포스터</h4>
<hr>
<div class="row">
	<div class="col text-center">
		<img src="${pblJoinDto.detailImgLc}" style="width:90%; none; margin: 0 auto;">
	</div>
</div>
<br><br><br>
<h4>상세정보</h4>
<hr>
<br>
<table id="detailInfo">
	<tr>
		<td class="ti">극장</td>
		<td>${pblJoinDto.theatName}</td>
	</tr>
	<tr>
		<td class="ti">배우</td>
		<td>${pblJoinDto.actor}</td>
	</tr>
	<tr>
		<td class="ti">유효시간 /<br>이용조건</td>
		<td>${pblJoinDto.period} 예매한 공연 날짜, 시간에 한해 이용 가능</td>
	</tr>
	<tr>
		<td class="ti">예매취소조건</td>
		<td>
			취소일자에 따라 아래와 같이 취소수수료가 부과됩니다. <br>
			예매일 기준보다 관람일 기준이 우선 적용됩니다. <br>
			관람일 10일전 이내 : 취소수수료 없음 <br>
			관람일 9일전 ~ 7일전 : 티켓금액의 10% <br>
			관람일 6일전 ~ 3일전 : 티켓금액의 20% <br>
			관람일 2일전 ~ 1일전 : 티켓금액의 30% <br>
			공연취소 시 : 취소수수료 없음
		</td>
	</tr>
	<tr>
		<td class="ti">취소환불방법</td>
		<td>
			예매/취소 내역에서 취소마감 시간 이내에 취소할 수 있습니다. <br>
			단 , 티켓을 발권한 이후에는 인터넷 취소가 불가하며 취소마감 시간 이전에 발권한 티켓을 주최사로 연락 후 제출해야 합니다. <br>
			취소 수수료는 주최사의 수령일자 기준으로 부과됩니다. <br>
		</td>
	</tr>
</table>


	
	

</body>
</html>