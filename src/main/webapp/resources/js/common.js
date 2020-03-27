$(function() {
	$('.hmenu').hover(function() {
		$(this).removeClass("text-white");
		$(this).addClass("text-warning");
		
	}, function() {
		$(this).removeClass("text-warning");
		$(this).addClass("text-white");
		
	})
	
	$('.rankNm').hover(function() {
		var imgLc = $(this).attr('data-img');
		var id = $(this).attr('data-id');
		$('#rankImgOut').prop('src', imgLc);
		$('#rankImga').attr("href","pblSelectOne.do?pblprfrId="+id);
	}, function() {
		
	})
	
	// 로그인 처리관련 스크립트
	var loginRes = $('#loginRes').val();
	var preId 	 = $('#inputedId').val();
	var mberId 	 = $('#loginedId').val();
	var level 	 = $('#level').val();
	
	$('#loginForm').change(function() {
		$('#loginState').html("");
	})
	
	$('body').click(function() {
		$('#loginState').html("");
	})

	if(mberId == "")
	{
		$('#logOut').hide();
	}
	else
	{
		$('#login').hide();
	}
	
	
	if(loginRes == "1")
	{
		$('#login').click();
		$('#loginState').html("<font color='red'>PassWord가 틀립니다.</font>");
		$('#uLogin').val(preId);
	}
	
	if(loginRes == "2")
	{
		$('#login').click();
		$('#loginState').html("<font color='red'>존재하지 않는 ID 입니다.</font>");
		$('#uLogin').val(preId);
	}
	
	if(loginRes == "0")
	{
		alert(mberId+"님 환영합니다!");
		$('#login').hide();
		$('#logOut').show();
	}
	
	if(level == "0")
	{
		$('#cog').show();
	}
	else
	{
		$('#cog').hide();
	}
	
	$('#cog').hover(function() {
		$(this).removeClass("text-white");
		$(this).addClass("text-warning");
	}, function() {
		$(this).removeClass("text-warning");
		$(this).addClass("text-white");
	})

	//------------------------------------------
		
})
