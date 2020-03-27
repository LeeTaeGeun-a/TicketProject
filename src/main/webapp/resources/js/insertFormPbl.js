var theatId = "";
var theatNm = "";
var condition = "";
var searchWord = "";
var pageNum = "";

function selectTheat(pageNum, condition , searchWord) {
	$('#resContainer').html(null);
	$('#theatPaging').html(null);
	var url = "/TiketProject/selectTheat.do";
	
	$.getJSON(url,{"pageNum":pageNum ,"condition":condition, "searchWord":searchWord}, function(json) 
			{
				var theatList	  = eval(json.theatMap.theatList);
				var totTheatCount = json.theatMap.totTheatCount;
				var pageCount     = json.theatMap.pageCount;
				var startPage     = json.theatMap.startPage;
				var endPage       = json.theatMap.endPage;
				var res = "";
				var	pagingRes="";
				
				if(theatList == null)
				{
					res +="<h6>조회결과가 없습니다.</h6>";
					$('#resContainer').append(res);
					return;
				}
				else
				{
					res += "<table id='thTable' class='table table-hover'><thead class='thead-dark'><tr><th scope='col'>ID</th><th scope='col'>NAME</th><th scope='col'>LOCATION</th><th scope='col'>TEL</th></tr></thead><tbody>";	
					
					$.each(theatList , function(i){
						res +="<tr>";
						res +="<th scope ='row'>"+theatList[i].theatId+"</th>";
						res +="<td>"+theatList[i].theatNm+"</td>";
						res +="<td>"+theatList[i].theatLoc+"</td>";
						res +="<td>"+theatList[i].theatTel+"</td></tr>";
					})
					
					pagingRes += "<ul class='pagination justify-content-center'>";
					pagingRes += "<li class='page-item disabled' id='previous'>";
					pagingRes += "<a class='page-link' href='#' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
					
					for(var i=startPage; i<=endPage ; i++)
					{
						pagingRes += "<li class='page-item'>";
						pagingRes += "<a class='page-link theatPageNum' href='#'>";
						pagingRes += i;
						pagingRes += "</a></li>";
					}
					
					pagingRes += "<li class='page-item disabled' id='next'>";
					pagingRes += "<a class='page-link' href='#' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li></ul>";
					
					
					$('#resContainer').append(res);
					$('#theatPaging').append(pagingRes);
					
					$('#thTable tr').hover(function() {
						$(this).css('cursor', 'pointer');
					})
					
					$('#thTable tr').click(function() {
						
						$('#thTable tr').css("background-color","white");
						var tr = $(this);
						var td = tr.children();
						
						tr.css("background-color","#ffffac");
						
						theatId = td.eq(0).text();
						theatNm = td.eq(1).text();	
					})
					
					if(startPage>5)
					{
						$('#previous').removeClass('disabled');
					}
					
					if(endPage < pageCount)
					{
						$('#next').removeClass('disabled');
					}
					
					$('.theatPageNum').click(function() {
						pageNum = $(this).text();
						selectTheat(pageNum,condition,searchWord);
					})
					
					$('#previous').click(function(){
						var prePage = parseInt(startPage)-5;
						selectTheat(prePage,condition,searchWord);
					})
					
					$('#next').click(function () {
						var aftPage = parseInt(startPage)+5;
						selectTheat(aftPage,condition,searchWord);
					})
					
					
					
					
				}
			})
			
	
}

$( function() {
	  
	//극장Modal 관련 처리
	
	$('#theatSearch').click(function() {
		
		condition  = $('#theatSearchCdt').val();
		searchWord = $('#theatSearchWord').val();

		if(condition == "")
		{
			alert("검색조건 을 선택해주세요");
			return;
		}
		
		selectTheat('1',condition,searchWord);
		

	})
	
	
	$('#btnStore').click(function() {
		$('#theatNm').val(theatNm);
		$('#theatId').val(theatId);
		//-- 극장 선택시 해당 상영관들 불러오는 로직
		var scUrl = "/TiketProject/selectScrRm.do";
		
		$.getJSON(scUrl,{"theatId":theatId}, function(data){
			$('#scrRmSelect').html("");
			var scrRmList = eval(data.scrRmList);	
			var resScrRm = "<option id='basicOp' value ='' selected>선택해주세요</option>";
			var listSize = data.listSize;
			
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
			
		})
		
	})
	
	
	
	//----------------------------------------------- 
	
	
	$('#titleImg').on('change',function(){
		if(window.FileReader){
			var fileObj = $(this)[0].files[0];
			if(fileObj == null)
			{
				$('#titleImgLabel').text("Choose File...");
				return;
			}
			var filename = $(this)[0].files[0].name;
			$('#titleImgLabel').text(filename);
		}
		
	})  
	
	$('#detailImg').on('change',function(){
		if(window.FileReader){
			var fileObj = $(this)[0].files[0];
			if(fileObj == null)
			{
				$('#detailImgLabel').text("Choose File...");
				return;
			}
			var filename = $(this)[0].files[0].name;
			$('#detailImgLabel').text(filename);
			
		}
	})  
	

	
    var dateFormat = "mm/dd/yy",
      from = $( "#from" )
        .datepicker({
          defaultDate: "0",
          changeMonth: true,
          numberOfMonths: 2
        })
        .on( "change", function() {
          to.datepicker( "option", "minDate", getDate( this ) );
        }),
      to = $( "#to" ).datepicker({
        defaultDate: "0",
        changeMonth: true,
        numberOfMonths: 2
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
    
    
	// 정상등록 되었을시 메세지 출력
	var sucInsert = $('#pblInsertRes').val();
	if(sucInsert == 'good')
	{
		alert("정상등록되었습니다.");
	}

	//이미지 미리보기 처리
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
  });