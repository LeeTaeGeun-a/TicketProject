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
<!-- <link href="css/bootstrap-grid.css" rel="stylesheet">
<link href="css/bootstrap-reboot.min.css" rel="stylesheet">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<link href="css/main.css" rel="stylesheet"> -->
<script>
 $(function() {
	var check = '${CHECK}';

	if(check =='fail')
	{
		alert("로그인 후 이용바랍니다.");
		 $('#loginModal').modal('show');
	}
/* 	$("#mberAtUpdate").click(function(){

		
		if(confirm("회원 탈퇴를 하시겠습니까?") == true)
		{
			document.form.submit(); */

});

</script>

<title>KG Tiket</title>
</head>
<body>
	<div class="container">
		<div class="row" style="margin-top: 50px;">
			<div class="col-12" style="float: none; margin: 0 auto;">
				<form action="mngMberSelect.do" method="post">
					<div class="form-row form-group">
						<div class="input-group col-3 offset-8">
							<!-- 콤보박스 만들어야함 아이디,이름 -->
							<select name="cmb">
								<option value="id">아이디</option>
								<option value="name">이름</option>
							</select> <input type="text" placeholder="search..." class="form-control"
								name="input" id="input">
						</div>
						<div class="input-group col-1">
							<input type="submit" class="btn btn-primary" id="pblSearchBtn"value="조회">
						</div>
					</div>
				</form>
			</div>
		</div>
		<hr>
		<div class="row" style="margin-top: 30px;">
			<div class="col-12" style="float: none; margin: 0 auto;">
				<table class="table table-hover" id="pblTable">
					<thead class="thead-dark">
						<tr class="text-center">
							<th scope="col">아이디</th>
							<th scope="col">이름</th>
							<th scope="col">이메일</th>
							<th scope="col">전화번호</th>
							<th scope="col">회원상태</th>
							<th scope="col">상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:if test="${LIST.size() == 0 || LIST == NULL}">
									<td colspan="9" style="text-align: center">해당 데이터가 없습니다.</td>
						</c:if>
						<c:if test="${LIST.size() != 0}">
						<c:forEach var="dto" items="${LIST}">
							<tr align="center">
								<td >${dto.mberId}</td>
								<td >${dto.mberNm}</td>
								<td >${dto.mberEmail}</td>
								<td >${dto.mberTel}</td>
								<td >${dto.mberAt}</td>
								<td ><a href="mngMberUpdateForm.do?mberId=${dto.mberId}">수정</a></td>
							</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>
    </body>
</html>