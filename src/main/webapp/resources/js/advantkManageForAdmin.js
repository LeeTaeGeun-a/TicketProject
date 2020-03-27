$(function() {
	

	// 상세보기 숨김처리
	$('#detail_container').hide(); 
	
	//테이블 row 클릭되었을때 발생 이벤트
	$('#advantkTable td').click(function(){
	
		$('#advantkTable tr').css("background-color","white");
		$('#detail_container').show();
		var tr = $(this).parent();
		var td = tr.children();
		tr.css("background-color","#ffffac"); 
		
		var advantkId = td.eq(0).text();
		var url = "selectOneAdvantkDetail.do";
		
		$.getJSON(url, {"advantkId":advantkId}, function(json) {
			var scrRmDto   = eval(json.detailMap.scrRmDto);
			var pblJoinDto = eval(json.detailMap.pblJoinDto);
			var advantkDto = eval(json.detailMap.advantkDto);
			var mberDto    = eval(json.detailMap.mberDto);
			
			// 좌석 view 에서 보이는거 바꾸기 [1-4],[1,5] 형태로
			var seats = advantkDto.advantkSeats;
			var seatsArr = seats.split(",");
			seats ="";
			for(var i=0; i<seatsArr.length;i++)
			{
				seats = seats+"["+seatsArr[i]+"]";
				if(i != seatsArr.length-1)
				{
					seats = seats+",";
				}
			}
			$('#txPblTitleImg').attr("src", pblJoinDto.titleImgLc);
			$('#txAdvantkId').text(advantkDto.advantkId);
			$('#txPblNm').text(pblJoinDto.pblNm);
			$('#txTheatNm').text(pblJoinDto.theatName);
			$('#txScrRmNm').text(scrRmDto.scrRmNm);
			$('#txScrDt').text(advantkDto.scrinngDt);
			$('#txAdNmrs').text(advantkDto.advantkNmrs+"매");	
			$('#txAdSeats').text(seats);
			$('#txPblPc').text(pblJoinDto.price+"원");
			$('#txAdPurPc').text(advantkDto.purchsPc+"원");
			$('#txTheatLoc').text(pblJoinDto.theatLoc);
			
			$('#txMberNm').text(mberDto.mberNm);
			$('#txViewPsNm').text(advantkDto.viewPsNm);
			$('#txAdvanDt').text(advantkDto.advantkDt);
			$('#adCancleBtn').attr("data-advantId",advantkDto.advantkId);
			
			//상태가 예매완료 상태가 아니면 예매취소 버튼 사용불가능하게 하기
			var state = advantkDto.advantkSt;
			if(state == 'F')
			{
				$('#adCancleBtn').removeAttr("disabled");
			}
			else
			{
				$('#adCancleBtn').attr("disabled","disabled");
			}
		})	
	})
	
	// 예매 취소 버튼 클릭시 처리
	$('#adCancleBtn').click(function() {
		
		var ckRes = confirm("취소일에 따라 취소수수료가 부과 될수도 있습니다.\n정말로 예매취소 하시겠습니까?");
		if(ckRes == false)
		{
			return;
		}
		
		var advantkId = $(this).attr("data-advantId");
		
		var url="cancleAdvantk.do";
		$.getJSON(url, {"advantkId":advantkId}, function(json) {
			
			var cancleRes = json.cancleRes;
			
			if(cancleRes =="0")
			{
				document.location = "erroPage";
			}
			else if(cancleRes =="1")
			{
				alert("취소 처리 완료되었습니다.");
				location.reload();
			}
			else if(cancleRes == "2")
			{
				alert("취소 가능일이 지났습니다.");
			}
		})
	})
	
	
	//검색버튼 클릭시 처리
	$('#advntkSearchBtn').on('click',function() {
		var condition = $('#condition option:selected').val();
		if(condition == "all")
		{
			$('#searchWord').removeAttr("required");
		}
		else
		{
			$('#searchWord').attr("required","required");
		}
	})
	
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
	});
	
	
	// 조건 상태 변화에 따른 처리
	$('#condition').change(function() {
		var condition = $('#condition option:selected').val();
		var text = "";
		
		if(condition =="period")
		{
			$('#search_container').html("");
			text += "<input type='text' placeholder='날짜선택' class='form-control' name='searchWord' id='dateSearch' onfocus='this.blur();'autocomplete='off' required>";	
			text += "<input type='submit' class='btn btn-primary' id='advntkSearchBtn' value='조회'>";
			$('#search_container').html(text);
			
			// 달력 입력창 선택시 나옴
			$( "#dateSearch" ).datepicker();
		
		}
		else if(condition =="state")
		{
			$('#search_container').html("");
			text += "<select class='form-control' name = 'searchWord' required='required'>";	
			text += "<option value='F'>예매 완료</option>";
			text += "<option value='C'>예매 취소</option>";
			text += "<option value='E'>사용 완료</option></select>";
			text += "<input type='submit' class='btn btn-primary' id='advntkSearchBtn' value='조회'>";
			$('#search_container').html(text);
		}
		else
		{
			$('#search_container').html("");
			text += "<input type='text' placeholder='search...' class='form-control' name='searchWord'>";
			text += "<input type='submit' class='btn btn-primary' id='advntkSearchBtn' value='조회'>";
			$('#search_container').html(text);
		}
	})
	
	
	

	
	
})