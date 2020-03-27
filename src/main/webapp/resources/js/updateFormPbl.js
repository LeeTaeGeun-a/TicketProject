$(function() {
	
	var updateRes = $('#updateRes').val();
	updateRes = parseInt(updateRes);
	
	if(updateRes == 1)
	{
		alert("수정처리 완료");
	}
	else if(updateRes == 0)
	{
		alert("수정오류 발생");
	}
	
	//이미지 삭제버튼 처리
	$('#dlTitleImg').click(function() {
		$('#preView').attr("src","img/basicSumnail.PNG" );
		$('#titleImgLabel').text("choose File...");
		$('#ckTitleImg').val("delete");
	})
	
	$('#dlDetailImg').click(function() {
		$('#detailImgLabel').text("choose File...");
		$('#ckDetailImg').val("delete");
	})
	
	//추가 이미지 처리
	$('#titleImg').on('change',function(){
		$('#ckTitleImg').val("change");
	})
	
	$('#detailImg').on('change',function(){
		$('#ckDetailImg').val("delete");
	})
	
	
	var titleImgFile = document.querySelector('#titleImg');
	titleImgFile.onchange = function() {
		var fileList = titleImgFile.files;
		
		if(fileList[0]== null)
		{
			$('#preView').attr("src","img/basicSumnail.PNG" );
			return false;
		}
		
		var reader = new FileReader();
		reader.readAsDataURL(fileList[0]);
		
		reader.onload = function () {
			document.querySelector('#preView').src = reader.result;		
			
		};
	};
	
	//페이징 처리위한것
	var startPage = $('#startPage').val();
	var endPage   = $('#endPage').val();
	var pageCount = $('#pageCount').val();

	
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
	
	// 업데이트 컨테이너 숨김처리
	$('#updateForm').hide();
	
	// 테이블 로우 클릭되었을때 발생 이벤트
	$('#pblTable tr .fine').click(function() {
		
		
		$('#pblTable tr').css("background-color","white");
		
		$('#updateForm').show();
		var tr = $(this).parent();
		var td = tr.children();
		
		tr.css("background-color","#ffffac");
		
		var pblId = td.eq(0).text();
		
		var url = "/TiketProject/selectOnePblForUpdate";
		$.getJSON(url,{"pblId":pblId}, function(json) {
			
			$('#pblprfrId').val(json.pblprfrId);
			$('#theatNm').val(json.theatNm);
			$('#theatId').val(json.theatId);
			$('#pblNm').val(json.pblNm);
			$('#price').val(json.price);
			$('#from').val(json.startPeriod);
			$('#to').val(json.endPeriod);
			$('#runTime').val(json.runTime);
			$('#actor').val(json.actor);
			$('#dirc').val(json.dirc);
			
		
			//상영관 불러 오는 로직
			var scUrl = "/TiketProject/selectScrRm.do";
			$.getJSON(scUrl,{"theatId":json.theatId}, function(data){
				$('#scrRmSelect').html("");
				var scrRmList = eval(data.scrRmList);	
				var resScrRm = "<option id='basicOp' value ='' selected>선택해주세요</option>";
				
				if(scrRmList == "")
				{
					$('#scrRmSelect').html(resScrRm);
					$('#basicOp').text("해당 극장에는 상영관이 없습니다.");
					return;
				}
				else
				{
					$.each(scrRmList, function(i) {

						resScrRm += "<option value ='"+scrRmList[i].scrRmId+"'>"+scrRmList[i].scrRmNm+"</option>";
					})
					
					$('#scrRmSelect').html(resScrRm);
				}
				$('#basicOp').removeAttr("selected");
				var scrinngRmId = json.scrinngRmId;
				$('#scrRmSelect option').each(function() {
					var value = $(this).val();
					if(value == scrinngRmId)
					{
						$(this).attr("selected", "selected");
					}
					
				})
				
			})
			
			//장르 
			var genre = json.genre;
			$('#genre').children().removeAttr("selected");
			$('#genre option').each(function() {
				var value = $(this).val();
				if(value == genre)
				{
					$(this).attr("selected", "selected");
				}
				
			})
			
			//관람등급
			var grade = json.grade;
			$('#grade').children().removeAttr("selected");
			$('#grade option').each(function() {
				var value = $(this).val();
				if(value == grade)
				{
					$(this).attr("selected", "selected");
				}
			})
			
			//공연여부
			var pblAt = json.pblprfrAt;
			if(pblAt == 'N')
			{
				$('#pblAtYes').removeAttr("checked");
				$('#pblAtNo').attr("checked","checked");
			}
			else if(pblAt == 'Y')
			{
				$('#pblAtNo').removeAttr("checked");
				$('#pblAtYes').attr("checked","checked");
			}		
			
			//이미지 처리
			var titleImgLc  = json.titleImgLc;
			var detailImgLc = json.detailImgLc;
				
			if(titleImgLc != null)
			{
				$('#preView').attr("src", titleImgLc);
				titleImgLc = titleImgLc.substring(17);
			}
			else
			{
				$('#preView').attr("src","img/basicSumnail.PNG" );
				titleImgLc = "choose File...";
			}
			
			if(detailImgLc != null)
			{
				detailImgLc = detailImgLc.substring(17);
			}
			else
			{
				detailImgLc = "choose File...";
			}
			$('#titleImgLabel').text(titleImgLc);
			$('#detailImgLabel').text(detailImgLc);
			
			
		})
		
		
	})
	
	
	
})