<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/seat.css" rel="stylesheet"/>
</head>
<body>
             <input type="hidden" id="theatId" name="theatId" value="${LIST[0].theatId}" >
             <input type="hidden" id="scrRmId" name="scrRmId" value="${LIST[0].scrRmId}" >
             <input type="hidden" value="${insertRes}" id="insertRes">
            <div class="card mb-4">
                            <div class="card-header">
                            좌석정보
                            </div>
           <div class="card-body" >
           
           <c:set var="size" value="${LIST.size()}" />
           <div id="seatArea" class="card-body" style="text-align: center; padding-left: 10px; padding-right: 10px">
           <c:forEach var="i" begin="0" end="${LIST[size-1].seatRow-1}">
           <div class="row card-body">
           <c:forEach var="dto" items="${LIST}">
           <c:if test="${dto.seatRow == i+1}">
           
           <c:if test="${dto.usefulAt == 'Y'}">
           <span class="all_agree">
           <span> &nbsp;&nbsp;&nbsp; </span>
           <input class="aaa" type="checkbox" id="${dto.seatRow}_${dto.seatCol}" name="seatId" value="${dto.seatRow}_${dto.seatCol}" style="display: none;"/>
           <label for="${dto.seatRow}_${dto.seatCol}"> <span class="jb-large">[${dto.seatRow}-${dto.seatCol}]</span> </label>
           </span><!-- .all_agree -->
           <span> &nbsp;&nbsp;&nbsp; </span>
           </c:if>

           <c:if test="${dto.usefulAt == 'N'}">
          
           <span class="all_agree1">
           <span> &nbsp;&nbsp;&nbsp; </span>
           <input class="aaa" type="checkbox" id="${dto.seatRow}_${dto.seatCol}" name="seatId" value="${dto.seatRow}_${dto.seatCol}" style="display: none;"/>
           <label for="${dto.seatRow}_${dto.seatCol}"> <span class="jb-large">[${dto.seatRow}-${dto.seatCol}]</span> </label>
           </span><!-- .all_agree -->
           <span> &nbsp;&nbsp;&nbsp; </span>
           </c:if>
           </c:if>
           </c:forEach>
           </div>
           </c:forEach>
           </div>
           <input class="btn btn-warning" type="button" id="seatUpdate" value="선택좌석 상태변경" onclick="updateSeat(value);" style="float: right; margin-right: 70px; display: none;"><br><br>
         </div>
          <div class="form-group text-center">
                       
                       <input class="btn btn-primary" type="button" id="seatAdd" value="좌석 추가" onclick="updateSeat(value)">
                       <input class="btn btn-primary" type="button" id="seatColAdd" value="열 추가" onclick="updateSeat(value)">
                       <input class="btn btn-primary" type="button" id="seatRowAdd" value="행 추가" onclick="updateSeat(value)"><br>
	       </div>
         </div>
<script>
$(document).ready(function(){ 
	$(".aaa").click(function() {
		$("#seatUpdate").show();
	});

});
function updateSeat(value) {
	
	if (confirm(value+"를(을) 하시겠습니까??") == true){}
	else{   //취소
	    return;
	}
	
		var theatId = $('#theatId').val();
		var scrRmId = $('#scrRmId').val();
		var seatId = new Array();
		seatId.length = 0;
		  $("input[name='seatId']:checked").each(function(a){   //jQuery로 for문 돌면서 check 된값 배열에 담는다
			 seatId.push($(this).val());
		  });
		  
	      if(value=="선택좌석 상태변경")
	    	  {
	    	  var scUrl = "/TiketProject/updateSeat.do";
	    	  }
	      else if(value=="좌석 추가")
	    	  {
	    	  var scUrl = "/TiketProject/insertSeat.do";
	    	  }
	      else if(value=="열 추가")
    	      {
    	      var scUrl = "/TiketProject/insertSeatCol.do";
    	      }
	      else if(value=="행 추가")
	          {
	          var scUrl = "/TiketProject/insertSeatRow.do";
	          }
		  
			$.getJSON(scUrl,{"theatId":theatId,"scrRmId":scrRmId,"seatId":seatId}, function(data){
				$('#seatArea').html("");
				var seatList = eval(data.LIST1);	
				var seatListSize = eval(data.SIZE);
				var seatArea = "";
				for(var aa = 0 ; aa < seatList[seatListSize-1].seatRow; aa++)
				{ 
					seatArea += '<div class="row card-body">';
					for(var bb =0 ;bb < seatListSize;bb++)
					{
					if(seatList[bb].seatRow == aa+1)
					{
					if(seatList[bb].usefulAt=='Y')
					{
				    seatArea += '<span class="all_agree"> ' 
					}else{
					seatArea += '<span class="all_agree1"> ' 
					}
				    seatArea += '<span> &nbsp;&nbsp;&nbsp; </span>' 
						       +'<input class="aaa" type="checkbox" id="'+seatList[bb].seatRow+'_'+seatList[bb].seatCol+'" name="seatId" value="'+seatList[bb].seatRow+'_'+seatList[bb].seatCol+'" style="display: none;" />' 
						       +'<label for="'+seatList[bb].seatRow+'_'+seatList[bb].seatCol+'"> <span class="jb-large">'+'['+seatList[bb].seatRow+'-'+seatList[bb].seatCol+']'+'</span> </label>'
						       +'</span> <span> &nbsp;&nbsp;&nbsp; </span>';
					}
					else {}
					}
					seatArea += '</div>';
				}            
				$('#seatArea').append(seatArea);
				seatList.length = 0;	
			});

}
</script>

    </body>
</html>