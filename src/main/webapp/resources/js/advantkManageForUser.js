$(function() {
	
	//후기 등록 결과 처리
	var reviewRes=$('#reviewRes').val();
	if(reviewRes =="1")
	{
		alert("후기 작성이 완료되었습니다.");
	}
	
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
	
	//예매 Id 클릭했을시 발생 이벤트
	$('.advantkId').click(function() {
		
		$('#detailAdvantk').removeAttr("hidden");
		var advantkId = $(this).text();
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
	
	//후기 버튼 클릭시 처리
	$('.reviewBtn').click(function() {
		var pblId = $(this).attr("data-pblprfrId");
		$('#hiPblId').val(pblId);
		$('#reviewModal').modal('show');
	})
	
	
	
})