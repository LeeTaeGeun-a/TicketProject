
// 결제하기 버튼 클릭시 확인할것들
function ckSubmit() {
	// 좌석 선택되었는지 확인
	var chk=0;
	$('.checkBox-wrap input[type=checkbox]').each(function(index) {
		if($(this).prop("checked"))
		{
			chk=1;
		}		
	});
	
	if(chk == 0)
	{
		alert("선택된 좌석이 없습니다.")
		return false;
	}
	//---------------------
	var confirmRes = confirm("결제를 진행하시겠습니까?");
	if(confirmRes == false)
	{
		return false;
	}
	
	return true;
}


$(function(){
	  
    $( "#accordion" ).accordion();
    
    // 처음 좌석상태 읽어들여서 예약된 상태인 좌석 표시하기
    $('.checkBox-wrap input[type=checkbox]').each(function(index) {
		if($(this).attr("data-state")=="N")
		{
			$(this).attr("disabled","disabled");
			$(this).css('cursor', 'default');
			$(this).next().addClass("text-muted");
		}
	});
        
    // 좌석 선택시 발생 이벤트
    $('.checkBox-wrap input[type=checkbox]').click(function() {
    	var ck = $(this).prop("checked");
    	var pblPrice  = $('#pblPrice').val();
    	var purchsPc = $('#purchsPc').val();
    	pblPrice  = parseInt(pblPrice);
    	purchsPc = parseInt(purchsPc);
    	if(ck==true)
    	{
 			purchsPc += pblPrice;
    	}
    	else if(ck == false)
    	{
    		purchsPc -= pblPrice;
    	}
    	
    	$('#purchsPc').val(purchsPc);
    })
    
 	// 로그인 안하고 들어올때 처리
	var needLogin = $('#needLogin').val();
	if(needLogin =="Y")
	{
		$('#needLoginService').removeAttr("hidden");
		$('#thebody').hide();
		$('#loginModal').modal('show');
	};

});