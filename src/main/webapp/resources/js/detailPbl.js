function introducePbl(){
	var pblId = $("#pblId").val();
	$('#sub_container').load("introducePbl.do?pblId="+pblId);
}

function checkLogin(){
	var loginedId = $('#loginedId').val();
	var checkSelect = $('#scrTime option:selected').val();
	if(loginedId == "")
	{
		alert("로그인 후 이용가능한 서비스 입니다.");
		$('#loginModal').modal('show');
		return false;
	}
	if(checkSelect == "0")
	{
		alert("관람일 과 시간을 선택해주세요");
		return false;
	}
}


$( function(){
	// 달력 한글화 를 위한 작업
	  $.datepicker.setDefaults({
		    dateFormat: 'yy.mm.dd',
		    prevText: '이전 달',
		    nextText: '다음 달',
		    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
		    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
		    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		    showMonthAfterYear: true,
		    yearSuffix: '년',
		    minDate: $('#calMinDate').val(),
		    maxDate: $('#calMaxDate').val()
		});


	  // 달력 에 날짜 선택시 날짜 받아오기
	  $( "#datepicker").datepicker({onSelect: function(dateText, inst) {
		  /*  var date = dateText; */
		 var pblId = $("#pblId").val();
		// $("#pickedDate").text(dateText);
		$('#scrTime').empty();		 
		 var url = "/TiketProject/selectAllscrinng.do";
		 
		  $.getJSON(url, {"pblId":pblId, "pickedDate":dateText}, function(json) {
			 
			 var result = eval(json.scrTimeList);
			 var res ="";
			 
			 if(result == ""){
				 res +="<option value='1'>해당 날짜에는 공연이 없습니다.</option>";
				 $('#scrTime').append(res);
				 return;
			 }else{
				 $.each(json.scrTimeList, function(i) {
					 var timeAndSeat = json.scrTimeList[i];
					 var time = timeAndSeat.substr(0, 5);
					 var seat = timeAndSeat.substr(10);
					 seat = parseInt(seat);
					 if(seat <1)
				     {
						 res += "<option value='0' disabled>"+time+" 매진</option>";
				     }
					 else{
						 res += "<option value="+dateText+"/"+time+">"+json.scrTimeList[i]+"</option>";
					 }
					
				  })
				  
				  $('#scrTime').append(res);
				// var dd= $('#scrTime option:selected').val();
				
			 }  
		 })
	  }});
	  	
	  
	  $(".nav-link").click(function() {
		$(".navlist").removeClass("active");
	  	$(this).addClass("active");
	  })
	  
	

	  $("#introducePbl").click(function() {
		  var pblId = $("#pblId").val();
		  $('#sub_container').load("introducePbl.do?pblId="+pblId);
	  
	  })
	 
	  
	  $("#introducePlace").click(function(){
		var theatId = $("#theatId").val();
		$('#sub_container').load("placeInfo.do?theatId="+theatId);
	  })
	  
	  $('#review').click(function() {
	  	var pblprfrId = $('#pblId').val();
	  	$('#sub_container').load("selectReviewAboutPbl.do?pblprfrId="+pblprfrId);
	  });
	  
	  
	//--------------------- 찜하기 처리-----------------------------------
	// 기본세팅
	var instRes = $('#instRes').val();
	var loginedId =$('#loginedId').val();
	
	if(loginedId != "" && instRes =="1")
	{
		$('#intrstBtn').removeClass("far");
		$('#intrstBtn').addClass("fas");
		$('#intrstBtn').attr('data-state','1');
	}
	
	//버튼 클릭시
	$('#intrstBtn').on("click", function() {
		
		var state = $('#intrstBtn').attr("data-state");
		var url = "";
		if(loginedId == "")
		{
			$('#intrstBtn').attr('data-target', '#loginModal');
			return;
		}
		else if(loginedId != "" && state == "1")
		{
			url = 'deleteIntrstPbl.do';
			$.getJSON(url, {"pblprfrId":$('#pblId').val()}, function(json) {
				var res = json.instProcRes;
				if(res=="1")
				{
					$('#intrstBtn').attr('data-state','0');
					$('#intrstBtn').removeClass("fas");
					$('#intrstBtn').addClass("far");
				}
			})
		}
		else if(loginedId != "" && state == "0")
		{
			url = 'insertIntrstPbl.do';
			$.getJSON(url, {"pblprfrId":$('#pblId').val()}, function(json) {
				var res = json.instProcRes;
				if(res=="1")
				{
					$('#intrstBtn').attr('data-state','1');
					$('#intrstBtn').removeClass("far");
					$('#intrstBtn').addClass("fas");
				}
			})
		}
		
	}) 
	//--------------------------------------------------------	

	  
	  
});