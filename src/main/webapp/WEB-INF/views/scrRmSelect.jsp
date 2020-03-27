<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="resources/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
</head>
<style>
   .backcolor1{ 
   background-color:menu; 
   color:black; 
   }
</style>
<body>
            <div class="card mb-4">
                            <div class="card-header">
                            <span>${LIST[0].theatNm} 상연관정보</span>
                            </div>
                            <div class="card-body" >
                                <div class="table-responsive">
                           
                                    <table class="table table-bordered" id="dataTable">
                                        <thead>
                                            <tr>
                                                <th>상연관 이름</th>
                                                <th>총 좌석수</th>
                                                <th>상영관 상태</th>
                                                <th>좌석 정보</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="dto" items="${LIST}">
                                          
                                            <tr>
                                             <td><a href="scrRmUpdateForm?theatId=${dto.theatId}&scrRmId=${dto.scrRmId}">${dto.scrRmNm}</a></td>
                                             <td>${dto.totSeat}</td>
                                             <td>
                                             <c:if test="${dto.clsAt == 'Y'}">
                                             개관중
                                             </c:if>
                                             <c:if test="${dto.clsAt == 'N'}">                                                       
                                             폐관
                                             </c:if>
                                             </td>
                                             <td><a href="seatSelectAll?theatId=${dto.theatId}&scrRmId=${dto.scrRmId}">보기</a></td>
                                            </tr>
                                            
                                        </c:forEach>
                                        </tbody>
                                    </table>
                 
                                </div>
                            </div>
                        </div>
                        <div class="card-header dropdown-toggle" id="scrRmNmAdd">
                        <label for="inputName">상연관 등록</label>
                        </div>
                         <form role="form" method=POST action=scrRmInsert onsubmit="return writeSave()">
                         <div class="form-group-1" style="display: none">
                         <div class="form-group-2">
                         <div>
                         <input type="hidden" id="theatId" name="theatId" value="${LIST[0].theatId}">
                        
                           <br>
                        <div class="input-group-prepend">
						<span class="input-group-text">상영관 이름</span>
                        <input type="text" class="scrRmNm" name="scrRmNm" placeholder="상연관 이름을 입력해 주세요" style="width:250px;" required autocomplete="off"><br>
                        <span> &nbsp;&nbsp;&nbsp; </span>
                        <span class="input-group-text">총좌석수</span>
                        <input type="number" min="1" class="totSeat" name="totSeat"  style="width:100px;" required><br>
                        <span> &nbsp;&nbsp;&nbsp; </span>
                        <span class="input-group-text">행</span>
                        <input type="number" min="1" class="seatRow" name="seatRow" style="width:50px;" required><br>
                        <span> &nbsp;&nbsp;&nbsp; </span>
                        <span class="input-group-text">열</span>
                        <input type="number" min="1" class="seatCol" name="seatCol" style="width:50px;" required><br>
                        <span> &nbsp;&nbsp;&nbsp; </span>
                        <input class="btn btn-outline-secondary" type="button" id="scrRmNmAddOne" value="추가"><br>
                        </div>	
                           
                         </div>
                         </div>
                         <div class="row">
                         <br>
                         </div>
                          <div class="form-group text-center">
                         <button type="submit" id="scrRm-submit" class="btn btn-primary" >
                            상영관 등록<i class="fa fa-check spaceLeft"></i>
                        </button>
                        </div>
                         </div>
                       </form>
        <script src="resources/js/jquery.dataTables.min.js"></script>
        <script src="resources/js/dataTables.bootstrap4.min.js" ></script>
        <script src="resources/js/datatables-demo.js"></script>
<script>

function writeSave(){
	
    if($(".scrRmNm").val() ==''){
        alert('상영관 이름을 입력하세요');
        $(".scrRmNm").focus();
        return false;
    }
}	


$(document).ready(function(){ 
	 	
	
	$('.seatRow').keyup(function(){ 
		
		var seatCol =  $(this).next().next().next();
		var totSeat =  $(this).prev().prev().prev();
		var seatRow =  $(this).val();
		
		$('.seatRow').click(function(){
			$(this).val("");
		});
		
	$('.seatRow').change(function(){ 

		if(totSeat.val()==""&&seatCol.val()==""){ 
			e.stopPropagation();
		}
		else if(!totSeat.val()==""&&seatCol.val()==""){
			seatRow =  $(this).val();
			seatCol.val(Math.ceil(totSeat.val()/seatRow));
			e.stopPropagation();
		}
		else if(!seatCol.val()==""&&totSeat.val()==""){
			seatRow =  $(this).val();
			totSeat.val(seatRow*seatCol.val());
			e.stopPropagation();
		}
		else if(!totSeat.val()==""&&!seatCol.val()==""){
			seatRow =  $(this).val();
			seatCol.val(Math.ceil(totSeat.val()/seatRow));
			e.stopPropagation();
		}
	});
	
	if(totSeat.val()>0)
	{	
	if(Number(seatRow) > Number(totSeat.val())){
		$(this).val(Number(totSeat.val()));
		seatCol.val(1);
	    }
	}
	
	});
	
	$('.seatCol').keyup(function(){ 
		var seatRow =  $(this).prev().prev().prev();
		var totSeat =  $(this).prev().prev().prev().prev().prev().prev();
		var seatCol =  $(this).val();
		
		$('.seatCol').click(function(){
			$(this).val("");
		});
	
	
	$('.seatCol').change(function(){ 

		if(totSeat.val()==""&&seatRow.val()==""){ 
			e.stopPropagation();
		}
		else if(!totSeat.val()==""&&seatRow.val()==""){
			seatCol = $(this).val();
			seatRow.val(Math.ceil(totSeat.val()/seatCol));
			e.stopPropagation();
		}
		else if(!seatRow.val()==""&&totSeat.val()==""){
			seatCol = $(this).val();
			totSeat.val(seatCol*seatRow.val());
			 e.stopPropagation();
		}
		else if(!seatRow.val()==""&&!totSeat.val()==""){
			seatCol = $(this).val();
			seatRow.val(Math.ceil(totSeat.val()/seatCol));
			e.stopPropagation();
		}
	});
	
	if(totSeat.val()>0)
	{	
	if(Number(seatCol) > Number(totSeat.val())){
		$(this).val(Number(totSeat.val()));
		seatRow.val(1);
	    }
	}
	});
	
	$('.totSeat').change(function(){ 
		var seatRow =  $(this).next().next().next();
		var seatCol =  $(this).next().next().next().next().next().next();
		var totSeat =  $(this).val();
		
		$('.totSeat').click(function(){
			$(this).val("");
		});
		
		if(seatCol.val()==""&&seatRow.val()==""){ 
			e.stopPropagation();
		}
		else if(!seatRow.val()==""&&seatCol.val()==""){
			seatCol.val(Math.ceil(totSeat/seatRow.val()));
			e.stopPropagation();
		}
		else if(!seatCol.val()==""&&seatRow.val()==""){
			seatRow.val(Math.ceil(totSeat/seatCol.val()));
			e.stopPropagation();
		}
		else if(!seatRow.val()==""&&!seatCol.val()==""){
			
			seatCol.val(Math.ceil(totSeat/seatRow.val()));
			e.stopPropagation();
		}
	});  
	
	$('#scrRmNmAdd').hover(function(){ 
		$(this).addClass('backcolor1'); 
	},    function(){ 
		$(this).removeClass("backcolor1"); 
	}); 
	
	    $("#clsBtn").click( function() {
	       return confirm("해당 상영관을 폐관처리 하시겠습니까?");
	    });

		$("#openBtn").click( function() {
	       return confirm("해당 상영관을 개관처리 하시겠습니까?");
	    });
	
	$('#scrRmNmAddOne').click (function () {                                        
        $('.form-group-2').append (                        
        		 ' <div class="input-group-prepend">'	
            	+' <span class="input-group-text">상영관 이름</span>'
                +' <input type="text" class="scrRmNm" name="scrRmNm" placeholder="상연관 이름을 입력해 주세요" style="width:250px;" required>'
                +' <span> &nbsp;&nbsp;&nbsp; </span>'
                +' <span class="input-group-text">총좌석수</span>'
                +' <input type="number" min="1" class="totSeat" name="totSeat" style="width:100px;" required>' 
                +' <span> &nbsp;&nbsp;&nbsp; </span>'
                +' <span> </span>'
                +' <span class="input-group-text">행</span>'
                +' <input type="number" min="1" class="seatRow" name="seatRow" style="width:50px;" required><br>'
                +' <span> &nbsp;&nbsp;&nbsp; </span>'
                +' <span class="input-group-text">열</span>'
                +' <input type="number" min="1" class="seatCol" name="seatCol" style="width:50px;" required><br>'
                +' <span> &nbsp;&nbsp;&nbsp; </span>'
                +' <input type="button" class="btnRemove" value="삭제"><br>'
                +' </div>'
            ); // end append           
    }); // end click  
    
    $(document).on('click',".btnRemove", function () { 
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
    	$(this).prev().remove (); // remove the textbox
        $(this).next ().remove (); // remove the <br>
        $(this).remove (); // remove the button
    });
    
	$(document).on('focusout','.seatRow', function () { 
		
    	var seatCol =  $(this).next().next().next().next('.seatCol');
		var totSeat =  $(this).prev().prev().prev().prev('.totSeat');
		var seatRow =  $(this).val();
		
		if(seatRow==""&&!totSeat.val()==""&&!seatCol.val()==""){
			$(this).val(Math.ceil(totSeat.val()/seatCol.val()));
		}
		if(totSeat.val()>0)
		{
		var maxCnd1 = Number(totSeat.val())+ Math.ceil(Number(totSeat.val())/Number(seatRow));
		var maxCnd2 = Number(seatRow)*Math.ceil(Number(totSeat.val())/Number(seatRow));
		var maxRow  = Math.ceil(Number(totSeat.val())/Number(seatCol.val()));
		
		if(Number(maxCnd1)<=Number(maxCnd2)){
			$(this).val(Number(maxRow));
		    }
		}
	});
	
	$(document).on('change','.seatRow', function () { 	 
		var seatCol =  $(this).next().next().next().next('.seatCol');
		var totSeat =  $(this).prev().prev().prev().prev('.totSeat');
		var seatRow =  $(this).val(); 
		
        if(totSeat.val()==""&&seatCol.val()==""){ 
			e.stopPropagation();
		}
		else if(!totSeat.val()==""&&seatCol.val()==""){
			seatRow =  $(this).val();
			seatCol.val(Math.ceil(totSeat.val()/seatRow));
			e.stopPropagation();
		}
		else if(!seatCol.val()==""&&totSeat.val()==""){
			seatRow =  $(this).val();
			totSeat.val(seatRow*seatCol.val());
			e.stopPropagation();
		}
		else if(!totSeat.val()==""&&!seatCol.val()==""){
			seatRow =  $(this).val();
			seatCol.val(Math.ceil(totSeat.val()/seatRow));
			e.stopPropagation();
		}
	});
	
	$(document).on('click','.seatRow', function () { 
			$(this).val("");
	});
		
	$(document).on('focusout','.seatCol', function () { 
		
		var seatRow =  $(this).prev().prev().prev().prev('.seatRow');
		var totSeat =  $(this).prev().prev().prev().prev().prev().prev().prev().prev('.totSeat');
		var seatCol =  $(this).val();
		
		if(seatCol==""&&!totSeat.val()==""&&!seatRow.val()==""){
			$(this).val(Math.ceil(totSeat.val()/seatRow.val()));
		}
		if(totSeat.val()>0)
		{
		if(Number(totSeat.val())<Number(seatCol)){
			$(this).val(Number(totSeat.val()));
		    }
		}
	});
		
	$(document).on('click','.seatCol', function () { 
		$(this).val("");
	});
	
	$(document).on('change','.seatCol', function () {
		var seatRow =  $(this).prev().prev().prev().prev('.seatRow');
		var totSeat =  $(this).prev().prev().prev().prev().prev().prev().prev().prev('.totSeat');
		var seatCol =  $(this).val();
		
		if(seatCol==""&&!totSeat.val()==""&&!seatRow.val()==""){
			$(this).val(totSeat.val()/seatRow.val());
		}
		else if(totSeat.val()==""&&seatRow.val()==""){ 
			e.stopPropagation();
		}
		else if(!totSeat.val()==""&&seatRow.val()==""){
			seatCol = $(this).val();
			seatRow.val(Math.ceil(totSeat.val()/seatCol));
			e.stopPropagation();
		}
		else if(!seatRow.val()==""&&totSeat.val()==""){
			seatCol = $(this).val();
			totSeat.val(seatCol*seatRow.val());
			 e.stopPropagation();
		}
		else if(!seatRow.val()==""&&!totSeat.val()==""){
			seatCol = $(this).val();
			seatRow.val(Math.ceil(totSeat.val()/seatCol));
			e.stopPropagation();
		}
	});
	
	$(document).on('focusout','.totSeat', function () { 
		
		var seatRow =  $(this).next().next().next().next('.seatRow');
		var seatCol =  $(this).next().next().next().next().next().next().next().next('.seatCol');
		var totSeat =  $(this).val();
		
		if(totSeat==""&&!seatRow.val()==""&&!seatCol.val()==""){
			$(this).val(Math.ceil(seatCol.val()*seatRow.val()));
		}
	});
	
	$(document).on('change','.totSeat', function () { 	 
		var seatRow =  $(this).next().next().next().next('.seatRow');
		var seatCol =  $(this).next().next().next().next().next().next().next().next('.seatCol');
		var totSeat =  $(this).val();
		
		if(totSeat<seatRow.val()||totSeat<seatCol.val()){
			seatRow.val(totSeat);
			seatCol.val(1);
		}
		else if(totSeat==""&&!seatRow.val()==""&&!seatCol.val()==""){
			$(this).val(seatRow.val()*seatCol.val());
		}
		else if(seatCol.val()==""&&seatRow.val()==""){ 
			e.stopPropagation();
		}
		else if(!seatRow.val()==""&&seatCol.val()==""){
			seatCol.val(Math.ceil(totSeat/seatRow.val()));
			e.stopPropagation();
		}
		else if(!seatCol.val()==""&&seatRow.val()==""){
			seatRow.val(Math.ceil(totSeat/seatCol.val()));
			e.stopPropagation();
		}
		else if(!seatRow.val()==""&&!seatCol.val()==""){
			
			seatCol.val(Math.ceil(totSeat/seatRow.val()));
			e.stopPropagation();
		}
	});  
		
	$(document).on('click','.totSeat', function () { 	
		$(this).val("");
	});
    
    
    
	$("#scrRmNmAdd").click(function(){
	      $(".form-group-1").slideToggle(); 
    });
});
</script>

    </body>
</html>