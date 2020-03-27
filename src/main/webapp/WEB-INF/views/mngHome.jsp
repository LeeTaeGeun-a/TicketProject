<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">

<style type="text/css">
a:link {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: none;
}

div.dd {
	border: 1px solid #dcdcdc;
	box-shadow: 10px 10px 5px #dcdcdc;
}
</style>
</head>
<body>
	<div class="container-fluid"
		style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
			<div class="col">
				<div class="row">
					<div class="col-12 text-center">
						<br> <br>
						<h2>KG 문화 티켓 관리자메인 화면</h2>
						<br>
					</div>
				</div>
				<hr width="500px;">
				<div class="row">
					<br>
				</div>
				<div class="row dd">
					<div class="col-12">
						<a href="advantkManageForAdmin.do"><i
							style="float: right; font-size: 15px; margin-top: 10px;">more+</i></a>
						<br> <font style="font-size: 25px;">예매 현황</font><br> <br>

						<table class="table">
							<thead class="thead-dark">
								<tr>
									<th scope="col">예매번호</th>
									<th scope="col">예매자ID</th>
									<th scope="col">공연제목</th>
									<th scope="col">관람일시</th>
									<th scope="col">예매일시</th>
									<th scope="col">매수</th>
									<th scope="col">결제금액</th>
									<th scope="col">상태</th>
								</tr>
							</thead>
							<c:if test="${advantkList != null }">
								<tbody>
									<c:forEach var="list" items="${advantkList}">
										<tr>
											<td class="text-center" style="font: bold;">${list.advantkId}</td>
											<td class="text-center">${list.mberId}</td>
											<td class="text-center">${list.pblprfrNm}</td>
											<td class="text-center">${list.scrinngDt}</td>
											<td class="text-center">${list.advantkDt}</td>
											<td class="text-center">${list.advantkNmrs}매</td>
											<td class="text-right">${list.purchsPc}원</td>
											<c:if test="${list.advantkSt =='F'}">
												<td class="text-center text-primary">예매완료</td>
											</c:if>
											<c:if test="${list.advantkSt =='C'}">
												<td class="text-center text-danger">예매취소</td>
											</c:if>
											<c:if test="${list.advantkSt =='E'}">
												<td class="text-center text-success">사용완료</td>
											</c:if>
										</tr>
									</c:forEach>
								</tbody>
							</c:if>
						</table>
					</div>
				</div>
				<div class="row" style="margin-top: 30px;">
					<div class="col-6">
						<div class="dd">
							<div
								style="margin-left: 15px; margin-right: 15px; text-align: center;">
								<a href="mngInqListSelect.do"><i
									style="float: right; font-size: 15px; margin-top: 10px;">more+</i></a>
								<br> <font style="font-size: 25px;">새로운 고객문의</font><br>
								<br>


								<table class="table">
									<thead class="thead-dark">
										<tr>
											<th>고객 ID</th>
											<th>문의 제목</th>
											<th>문의 날짜</th>
											<th>답변 여부</th>
										</tr>
									</thead>
									<c:if test="${list != null }">
										<tbody>
											<c:forEach var="list" items="${list}">
												<tr>
													<td class="text-center" style="font: bold;">${list.mberId}</td>
													<td class="text-center">${list.inqrySj}</td>
													<td class="text-center">${list.registDate}</td>
													<c:if test="${list.answerAt == 'N' }">
												<td class="align-middle"><input type="button" class="btn btn-success"
													value="답변하기" style="width: 100px; "
													onclick="location = 'mngInqSelectForm.do?inqryNo=${list.inqryNo}'">
											</c:if>
												</tr>
											</c:forEach>
										</tbody>
									</c:if>
								</table>


							</div>
						</div>
					</div>
					<div class="col-6">
						<div class="dd">
							<div
								style="margin-left: 15px; margin-right: 15px; text-align: center;">
								<br> <font style="font-size: 25px;">상연 종료 공연
									${count}건</font>
								<button style="float: right; font-size: 15px; margin-top: 5px;"
									onclick="location.href = 'closeProc.do'">상연 정보 업데이트</button>
								<br> <br>
								<table class="table">
									<thead class="thead-dark">
										<tr>
											<th>공연 이름</th>
											<th>상연 극장</th>
											<th>상연 기간</th>
										</tr>
									</thead>
									<c:if test="${scrinngJoinDto != null }">
										<tbody>
											<c:forEach var="list" items="${scrinngJoinDto}">
												<tr>
													<td class="text-center" style="font: bold;">${list.pblprfrNm}</td>
													<td class="text-center">${list.theatNm}</td>
													<td class="text-center">${list.scrinngDt}</td>
												</tr>
											</c:forEach>
										</tbody>
									</c:if>
								</table>
								<c:if test="${count >3 }">
									<font style="font-size: 20px;">............</font>
									<br>
									<br>
								</c:if>
							</div>
						</div>
					</div>
				</div>

			</div>

			<!-- 오른쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>

		</div>
	</div>
	<div class="row">
		<br>
	</div>
</body>
</html>