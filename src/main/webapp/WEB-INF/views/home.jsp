<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>KG Tiket</title>
</head>
<body>

	<!-- 나중에 예매조회 페이지로 옮길 내용 -->
	<input type="hidden" id="advantkInRes" value="${insertAdvantkRes}">
	<script type="text/javascript">
	$(function() {
		var advantkInRes = $('#advantkInRes').val();
		if(advantkInRes == "1")
		{
			alert("정상예매 되었습니다.");
		}
	})
	
	</script>
	<!--  -->
	<div class="container-fluid" style="padding-left: 0px; padding-right: 0px; padding-bottom: 0px;">
		<!-- nav라인 까지 ROW 종료 -->
		<div class=row id="thebody">
			<!-- 왼쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
			<div class="col">
				<div class="row">
					<div class="col-6 offset-1 border text-center">
						<br>
						<h4>공연예정</h4>
						<hr width="200px">
						<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel" style="margin-top: 5px; margin-bottom: 5px;">
						  <ol class="carousel-indicators">
						    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
						    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
						  </ol>
						  <div class="carousel-inner" style="height: 400px;" >
						    <div class="carousel-item  center-block active">
						      <a href="#"><img src="img/wpost1.jpg" class="d-block w-100" style="height: 400px;" alt="..."></a>  
						    </div>
						    <div class="carousel-item center-block">
						      <a href="#"><img src="img/wpost2.jpg" class="d-block w-100" style="height: 400px;"alt="..."></a>
						    </div>
						    <div class="carousel-item center-block">
						      <a href="#"><img src="img/wpost3.png" class="d-block w-100" style="height: 400px;"alt="..."></a>
						    </div>
						  </div>
						  
						  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
						    <span class="carousel-control-prev-icon"  aria-hidden="true"></span>
						    <span class="sr-only">Previous</span>
						  </a>
						  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
						    <span class="carousel-control-next-icon" aria-hidden="true"></span>
						    <span class="sr-only">Next</span>
						  </a>
						</div>
					</div>
					<div class="col-4 border text-center" style="margin-left: 30px;">
					
						<br>
						<h4>실시간 랭킹</h4>
						<br>
						<div class="row" style="margin-top: 20px;">
							<div class="col-4 text-left text-truncate text-muted">
								<c:forEach var="i" begin="0" end="6" step="1">
									<a href="pblSelectOne.do?pblprfrId=${rankList[i].pblprfrId}" data-img="${rankList[i].titleImgLc}" data-id="${rankList[i].pblprfrId}" class="rankNm">${i+1}. ${rankList[i].pblNm}</a><br><br>
								</c:forEach>
							</div>
							<div class="col-8">
							<a id="rankImga" href="pblSelectOne.do?pblprfrId=${rankList[0].pblprfrId}">
								<img id="rankImgOut" class="rounded" src="${rankList[0].titleImgLc}" width="80%" height="300px;" style="margin-top: 20px;">
							</a>
							</div>
						</div>	
					</div>
				</div>
			
			
			
			<div class= "row text-center" style="margin-top: 20px;">
				
				<div class="col text-center ">
				<hr>
					<br>
					<h4> 예매 순위 BEST10 </h4>
					<hr width="200px;"> 
					<c:forEach var="i" begin="0" end="${adRankList.size()}" step="5" >
						<div class="row" style="margin-top:80px">
							<div class="col-1"></div>	
								<c:forEach var="j" begin = "0" end = "4" step="1">
								<c:if test="${i<adRankList.size()}" >
			
									<div class="col-2" >
										<div class="card" style="width: 100%">
											<a href="pblSelectOne.do?pblprfrId=${adRankList[i].pblprfrId}">
											<img class="card-img-top" src="${adRankList[i].titleImgLc}" style="width: 100%;height: 230px;">
											</a>
											<div class="card-body text-truncate">
												<h5 class="card-title">${adRankList[i].pblNm }</h5>
												<p class="card-text" style="font-size: 12px; margin-bottom: 2px; float: left;">극장 : ${adRankList[i].theatName}</p>
												<p class="card-text" style="font-size: 12px; margin-bottom: 2px; float: left;">기간 : ${adRankList[i].period}</p><br><br>
												<a class="btn btn-primary" href="pblSelectOne.do?pblprfrId=${adRankList[i].pblprfrId}" style="margin-top: 10px;">예매하기</a>
											</div>
										</div>	
									</div>
										<c:set var="i">${i=i+1}</c:set>
									</c:if>
								</c:forEach> 
							<div class="col-1"></div>		
						</div>
					</c:forEach> 
				</div>
			</div>
				<!-- imgSumnail 끝 -->
			</div>

			<!-- 오른쪽 여백을 만들기 위한 div -->
			<div class="col-1"></div>
		</div>
	</div>

</body>
</html>