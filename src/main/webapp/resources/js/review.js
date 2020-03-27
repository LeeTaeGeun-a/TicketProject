
function selectReview(pageNum,pblId) {
	$('#review_container').html(null);
	$('#review_paging').html(null);
	var url = "/TiketProject/selectReviewPaging.do";
	
	$.getJSON(url,{"pageNum":pageNum ,"pblprfrId":pblId}, function(json) 
	{
		var reviewList	   = eval(json.resMap.reviewList);
		var totReviewCount = json.resMap.totReviewCount;
		var pageCount      = json.resMap.pageCount;
		var startPage      = json.resMap.startPage;
		var endPage        = json.resMap.endPage;
		var res = "";
		var	pagingRes="";
					
		$.each(reviewList , function(i){
			var score = reviewList[i].score;
				score = parseInt(score);
			res += "<div><div class='row' style='margin-top: 30px; padding-left: 20px; padding-right: 20px;'>";		
			res += "<div class='col-2'>";			
			if(score == 0)
			{
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
			}
			else if(score == 1)
			{
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
			}
			else if(score == 2)
			{
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
			}
			else if(score == 3)
			{
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-off.png'>";
				res += "<img src='img/star-off.png'>";
			}
			else if(score == 4)
			{
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-off.png'>";
			}
			else if(score == 5)
			{
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
				res += "<img src='img/star-on.png'>";
			}
				
			res+= "</div>";
			res+= "<div class='col-10'>";
			res+= "<div style='font-size: 13px; padding-top: 10px;'>"+reviewList[i].content+"</div>";
			res+= "<button class='btn btn-sm btn-secondary delBtn' style='float: right' hidden='' data-mberId='"+reviewList[i].mberId+"' data-regDt='"+reviewList[i].registDt+"'>삭제</button>";
			res+= "<div class='text-muted' style='font-size: 9px; margin-top: 18px;'>"+reviewList[i].mberId+"|"+reviewList[i].registDt+"</div>";
			res+= "</div></div>";	
			res+= "<hr></div>";
				
		}) // foreach 끝
				
		pagingRes += "<ul class='pagination justify-content-center'>";
		pagingRes += "<li class='page-item disabled' id='previous'>";
		pagingRes += "<a class='page-link'style='cursor: pointer;'  aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
					
		for(var i=startPage; i<=endPage ; i++)
		{
			pagingRes += "<li class='page-item'>";
			pagingRes += "<a class='page-link reviewPageNum' style='cursor: pointer;'>";
			pagingRes += i;
			pagingRes += "</a></li>";
		}
					
		pagingRes += "<li class='page-item disabled' id='next'>";
		pagingRes += "<a class='page-link' style='cursor: pointer;' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li></ul>";
		
		
		$('#review_container').append(res);
		$('#review_paging').append(pagingRes);	
							
		if(startPage>5)
		{
			$('#previous').removeClass('disabled');
		}
					
		if(endPage < pageCount)
		{
			$('#next').removeClass('disabled');
		}
					
		$('.reviewPageNum').on("click",function() {
			pageNum = $(this).text();
			selectReview(pageNum,pblId);
		})

		$('#previous').click(function(){
			var prePage = parseInt(startPage)-5;
			selectReview(prePage,pblId);
		})

		$('#next').click(function () {
			var aftPage = parseInt(startPage)+5;
			selectReview(aftPage,pblId);
		})
		
		var level     = $('#level').val();
		var pblId     = $('#rpblId').val();
		if(level == "0")
		{
			$('.delBtn').removeAttr("hidden");
		}	
		
		//삭제버튼 클릭시 처리
		$('.delBtn').on("click",function() {
			var mberId = $(this).attr("data-mberId");
			var regDt  = $(this).attr("data-regDt");
			
			var deleteBtn = $(this);
			
			var url = "/TiketProject/deleteReview.do";
			$.getJSON(url,{"mberId":mberId,"registDt":regDt,"pblprfrId":pblId}, function(json) {
				
				var deleteRes = json.reviewDeleteRes;
				
				if(deleteRes == "1")
				{
					alert("후기 삭제처리 완료하였습니다.");
					var line = deleteBtn.parent().parent().parent().html("");
					
				}
			})
		})
				
 })
}
$( function() {
	
	
	var pblId = $('#rpblId').val();
	var startPage = $('#startPage').val();
	var endPage   = $('#endPage').val();
	var pageCount = $('#pageCount').val();
	var level     = $('#level').val();
	
	
	// 관리자일 경우 삭제 버튼보이게
	if(level == "0")
	{
		$('.delBtn').removeAttr("hidden");
	}
	
	//삭제버튼 클릭시 처리
	$('.delBtn').click(function() {
		var mberId = $(this).attr("data-mberId");
		var regDt  = $(this).attr("data-regDt");
		
		var deleteBtn = $(this);
		
		var url = "/TiketProject/deleteReview.do";
		$.getJSON(url,{"mberId":mberId,"registDt":regDt,"pblprfrId":pblId}, function(json) {
			
			var deleteRes = json.reviewDeleteRes;
			
			if(deleteRes == "1")
			{
				alert("후기 삭제처리 완료하였습니다.");
				var line = deleteBtn.parent().parent().parent().html("");
				
			}
		})
	})
	
	
	if(startPage>5)
	{
		$('#previous').removeClass('disabled');
	}
	
	if(endPage < pageCount)
	{
		$('#next').removeClass('disabled');
	}
	
	$('.reviewPageNum').on("click",function() {
		pageNum = $(this).text();
		selectReview(pageNum,pblId);
	})

	$('#previous').click(function(){
		var prePage = parseInt(startPage)-5;
		selectReview(prePage,pblId);
	})

	$('#next').click(function () {
		var aftPage = parseInt(startPage)+5;
		selectReview(aftPage,pblId);
	})

})

