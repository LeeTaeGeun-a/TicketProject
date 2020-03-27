$(function() {
			
		var data = '${pblList[0].pblNm}';
		if(data == ""){
			$('#data_container').text("해당 데이터가 없습니다.");
		}
		
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
		
		var genre    = $('#hidGenre').val();
		var area  	 = $('#hidArea').val();
		var schedule = $('#hidSchedule').val();

		switch(genre){
		
			case 'all': 
				$('#genre option').removeAttr('selected');
				$('#genre #allGenre').attr('selected', 'selected');
				break;
				
			case 'drama':
				$('#genre option').removeAttr('selected');
				$('#genre #drama').attr('selected', 'selected');
				break;
				
			case 'musical':
				$('#genre option').removeAttr('selected');
				$('#genre #musical').attr('selected', 'selected');
				break;
				
			case 'concert':
				$('#genre option').removeAttr('selected');
				$('#genre #concert').attr('selected', 'selected');
				break;
				
			case 'childdrama':
				$('#genre option').removeAttr('selected');
				$('#genre #childdrama').attr('selected', 'selected');
				break;		
		}
		
		switch(area){
		
			case 'all': 
				$('#area option').removeAttr('selected');
				$('#area #allArea').attr('selected', 'selected');
				break;
				
			case 'area01':
				$('#area option').removeAttr('selected');
				$('#area #area01').attr('selected', 'selected');
				break;
				
			case 'area02':
				$('#area option').removeAttr('selected');
				$('#area #area02').attr('selected', 'selected');
				break;
				
			case 'area03':
				$('#area option').removeAttr('selected');
				$('#area #area03').attr('selected', 'selected');
				break;
				
			case 'area04':
				$('#area option').removeAttr('selected');
				$('#area #area04').attr('selected', 'selected');
				break;
				
			case 'area05':
				$('#area option').removeAttr('selected');
				$('#area #area05').attr('selected', 'selected');
				break;		
		}
		
		switch(schedule){
		
			case 'allSchedule': 
				$('#schedule option').removeAttr('selected');
				$('#schedule #all').attr('selected', 'selected');
				break;
				
			case 'today':
				$('#schedule option').removeAttr('selected');
				$('#schedule #today').attr('selected', 'selected');
				break;
				
			case 'tomorrow':
				$('#schedule option').removeAttr('selected');
				$('#schedule #tomorrow').attr('selected', 'selected');
				break;
		}	
	})