$(function() {
	
	// 로그인 안하고 들어올때 처리
	var needLogin = $('#needLogin').val();
	if(needLogin =="Y")
	{
		$('#needLoginService').removeAttr("hidden");
		$('#thebody').hide();
		$('#loginModal').modal('show');
	};
	
	//페이징 처리위한것
	startPage = parseInt(startPage);
	pageCount = parseInt(pageCount);
	endPage   = parseInt(endPage);
	
	if(startPage > 5)
	{
		$('#previous').removeClass('disabled');
	}
	
	if(endPage < pageCount)
	{
		$('#next').removeClass('disabled');
	}
	
	//이미지 클릭했을시 처리 
	$('.pblImg').click(function() {
		var pblAt = $(this).attr("data-pblAt");
		var pblId = $(this).attr("data-pblid");
		if(pblAt=='N')
		{
			alert("이미 종료된 공연 입니다.");
			return;
		}
		document.location = "pblSelectOne.do?pblprfrId="+pblId;
	})
	
	//삭제버튼 처리
	$('button[name=deleteBtn]').click(function() {
		var pblId = $(this).attr("data-pblid");
		var url = 'deleteIntrstPbl.do';
		$.getJSON(url, {"pblprfrId":pblId}, function(json) {
			var res = json.instProcRes;
			if(res=="1")
			{
				alert("삭제되었습니다.");
				location.reload();
			}
		})
		
	})
})