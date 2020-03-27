<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/bootstrap.min.css" rel="stylesheet" media="screen">
<script type="text/javascript" src="js/bootstrap.min.js"></script>
<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="js/review.js"></script>	
<script type="text/javascript" src="js/jquery.raty.js"></script>
<script type="text/javascript">

$(function() {
      $('#star').raty({
        score: $('#totScore').val()
        ,path : "img/"
        ,width : 200
        ,readOnly: true
    });   
});
</script> 
</head>
<body>
<!-- hidden -->
	<input type="hidden" id="totScore"  value="${pblprfrDto.totScore}">
	<input type="hidden" id="rpblId"    value="${pblprfrDto.pblprfrId}">
	<input type="hidden" id="startPage" value="${resMap.startPage}">
	<input type="hidden" id="endPage"	value="${resMap.endPage}">
	<input type="hidden" id="pageCount" value="${resMap.pageCount}">
	<input type="hidden" id="level"     value="${level}">
<!--  -->
	<div class="row" style="margin-top: 30px; padding-left: 20px; padding-right: 20px;">
		<div class="col border text-center">
			<div>별점 <span class="text-danger" style="font-size: 30px;">${pblprfrDto.totScore}</span>(총 ${resMap.totReviewCount}명 )</div>
			<div id="star"></div>
			<div class="text-danger" style="font-size: 12px;">실제 관객이 남김 평균 별점입니다.</div>
		</div>
	</div>
<div id ="review_container">
	<c:if test="${reviewList.size()>0}"> 
		<c:forEach var="reviewDto" items="${reviewList}">
		<div>
			<div class="row" style="margin-top: 30px; padding-left: 20px; padding-right: 20px;" data-dd="dd">
				<div calss="col-2">
					<c:if test="${reviewDto.score == 0}">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					</c:if>
					<c:if test="${reviewDto.score == 1}">
					<img src="img/star-on.png">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					</c:if>
					<c:if test="${reviewDto.score == 2}">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					</c:if>
					<c:if test="${reviewDto.score == 3}">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					<img src="img/star-off.png">
					<img src="img/star-off.png">
					</c:if>
					<c:if test="${reviewDto.score == 4}">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					<img src="img/star-off.png">
					</c:if>
					<c:if test="${reviewDto.score == 5}">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					<img src="img/star-on.png">
					</c:if>
				</div>
				<div class="col-10">
					<div style="font-size: 13px; padding-top: 10px;">
						${reviewDto.content}
					</div>
					<button class="btn btn-sm btn-secondary delBtn" style="float: right" data-mberId="${reviewDto.mberId}" data-regDt="${reviewDto.registDt}" hidden="">삭제</button>
					<div class="text-muted" style="font-size: 9px; margin-top: 18px;">${reviewDto.mberId}|${reviewDto.registDt}</div>
				</div>
			</div>
			<hr>
		</div>
		</c:forEach>
	</c:if>
	<div class="row" style="margin-top: 20px;">
		<div class="col-12 text-center">
			<c:if test="${reviewList == null}">등록된 후기가 없습니다.</c:if>
		</div>
	</div>
</div>	

	<div class="row" style="margin-top: 30px;">
		<div class="col-2 text-center" style="float: none; margin: 0 auto;">
		<div id="review_paging">	
			<ul class="pagination justify-content-center">
				<li class="page-item disabled" id="previous">
					 <a class="page-link" style="cursor: pointer"  aria-label="Previous">
						 <span aria-hidden="true">&laquo;</span>
					 </a>
				</li>
				<c:forEach var="i" begin="${resMap.startPage}" end="${resMap.endPage}">
				<li class="page-item">
					<a class="page-link pageNum reviewPageNum" style="cursor: pointer;">${i}</a>
				</li>
				</c:forEach>
				<li class="page-item disabled" id="next">
					<a class="page-link" style="cursor: pointer;" aria-label="Next">
						<span aria-hidden="true">&raquo;</span>
					</a>
				</li>
			</ul>
		</div>	
		</div>
	</div>

</body>
</html>