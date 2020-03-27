$(function() {
	
	//페이지로 들어온 데이터값 저장하기
	var startPage = $('#startPage').val();
	var endPage   = $('#endPage').val();
	var pageCount = $('#pageCount').val();
	var minDate	  = $('#minDate').val();
	var maxDate	  = $('#maxDate').val();
	
	//상태 업데이트 결과 처리
	var upRes = $('#updateRes').val();
	var inRes = $('#insertRes').val();
	
	if(inRes == "0")
	{
		alert("오류발생(해당 상영관에 이용가능한 좌석이 없습니다.)");
	}
	else if(inRes == "1")
	{
		alert("상연등록 완료");
	}
	else if(inRes == "2")
	{
		alert("데이터가 중복되었습니다. 등록실패!!");
	}
	
	if(upRes == "1")
	{
		alert("상태전환 완료");
	}
	
	
	
	//상태전환 버튼 처리
	$('#allCheckCancle').hide();
	
	$("#allCheck").unbind("click").bind("click" , function(e)
	{
		if($(this).prop("checked")) 
		{
			$('input:checkbox[name="scrinngDt"]').each(function(index) 
			{
				$(this).prop("checked", true);                     //checked all
			});
		} else {
			$('input:checkbox[name="scrinngDt"]').each(function(index) 
			{
				$(this).prop("checked", false);                    //unchecked all
			}); 
		}
	}); 
		
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
	//---------------------------
	$( "#accordion" ).accordion({
    	collapsible: true
    });
    
	// 달력 처리
   
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
	    minDate: minDate,
	    maxDate: maxDate
	});
    
    $("#searchDateInput" ).datepicker();
    $("#oneDateInpue").datepicker();
    
    
    // 시간 추가 버튼 1
    $('#addTimeBtn1').click(function() {
    	var timeBox  = "<div><i class='far fa-clock text-primary' style='font-size: 25px; margin-top: 3px;'></i>";
    		timeBox += "<span class='align-middle' style='font-family: monospace;'>시간(상연시작)</span>";
    		timeBox += "<input type='time' class='form-control' name='scrTime' required></div>";
    		 		
		$('#addContainer1').append(timeBox);
        $( "#accordion" ).accordion( "refresh" );
		})
		
		$('#deleteTimeBtn1').on('click',function() {
    	
    	$('#addContainer1 div').last().remove();
    	$( "#accordion" ).accordion( "refresh" );   
	});  
    
    // 시간 추가 버튼 2
    $('#addTimeBtn2').click(function() {
    	var timeBox  = "<div><i class='far fa-clock text-primary' style='font-size: 25px; margin-top: 3px;'></i>";
    		timeBox += "<span class='align-middle' style='font-family: monospace;'>시간(상연시작)</span>";
    		timeBox += "<input type='time' class='form-control' name='scrTime' required></div>";
    	
		$('#addContainer2').append(timeBox);
        $( "#accordion" ).accordion( "refresh" );
		})
		
		$('#deleteTimeBtn2').on('click',function() {
    	
    	$('#addContainer2 div').last().remove();
    	$( "#accordion" ).accordion( "refresh" );   
	});  
	
    // 달력 기간
    var dateFormat = "yy.mm.dd",
    from = $( "#startDateInput" ).datepicker({
	   
	    changeMonth: true,
	    numberOfMonths: 1
    })
    .on( "change", function() {
    to.datepicker( "option", "minDate", getDate( this ));
    }),
    to = $( "#endDateInput" ).datepicker({
	        
	        changeMonth: true,
            numberOfMonths: 1
          })
    .on( "change", function() {
        from.datepicker( "option", "maxDate", getDate( this ) );
    });
     
     function getDate( element ) {
       var date;
       try {
             date = $.datepicker.parseDate( dateFormat, element.value );
           } catch( error ) {
             date = null;
           }
            return date;
     }
	
})

//체크박스에 체크 안하고 상태전환 눌렀는지 확인하는 로직
function checkCkBox() {
	
	var chk=0;
	$('input:checkbox[name="scrinngDt"]').each(function(index) {
		if($(this).prop("checked"))
		{
			chk=1;
		}
	});
	if(chk == 0)
	{
		alert("선택된 상연이 없습니다.")
		return false;
	}
	
	var ckConfirm = confirm("상연 상태 변경시 예매된 티켓이 있다면 모두 취소 처리 됩니다.\n진행하시겠습니까?");
	
	if(ckConfirm == false)
	{
		return false;
	}
	
	return true;
}
