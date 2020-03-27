<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="resources/js/postcode.v2.js"></script>
</head>
<body onload="insertOk()">
                <div class="row card-header">
                <div class="col-5">
                <h1>극장 등록</h1>
                </div>
                </div>
            <div class ="row card-body">
                <form role="form" method=POST action=theatInsert onsubmit="return confirm('극장을 등록 하시겠습니까?')">
                    <div class="input-group-prepend">
                        <input type="hidden" value="${insertRes}" id="insertRes">
                        <span class="input-group-text">극장 이름</span>
                        <span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </span>
                        <input type="text" class="form-control" id="theatNm" name="theatNm" placeholder="이름을 입력해 주세요" style="width:410px;" required>
                    </div>
                    
                    <div class="row">
                    <br>
                    </div>
                    <div class="input-group-prepend">
 
                       <span class="input-group-text">극장 주소</span>
                       <span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>

                       <input class="required" type="text" id="sample6_postcode" placeholder="우편번호" readonly required>
                       <input class="required" type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기" required><br>
                    </div>
                    <div class="input-group-prepend">
                       <span class="col-2"></span>
                       <input class="required" type="text" id="sample6_address" placeholder="주소" readonly style="height: 35px" required><br>
                    </div>
                       <div class="input-group-prepend">
                       <span class="col-2"></span>
                       <input type="text" id="sample6_detailAddress" placeholder="상세주소" style="height: 35px">
                       <input type="text" id="sample6_extraAddress" placeholder="참고항목" readonly style="height: 35px">
                       </div>
                       
                       
                       
                       <input type="hidden" id="theatLoc" name="theatLoc" >
                    
                    
                    <div class="row">
                    <br>
                    </div>
                    
                    <div class="input-group-prepend">
                        <span class="input-group-text">극장 전화번호</span>
                        <span> &nbsp;&nbsp;&nbsp; </span>
                        <select name=hw id="inputTel1" name="inputTel1"> 
                          <option value="010">010 
                          <option value="02" selected>02 
                          <option value="051">051
                          <option value="051">053
                          <option value="032">032 
                          <option value="062">062 
                          <option value="042">042 
                          <option value="052">052 
                          <option value="044">044 
                          <option value="031">031 
                          <option value="033">033 
                          <option value="043">043 
                          <option value="041">041 
                          <option value="063">063 
                          <option value="061">061 
                          <option value="054">054 
                          <option value="055">055 
                          <option value="064">064 
                        </select> 
                        -
                        <input onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" oninput="maxLengthCheck(this)" type="text" id="inputTel2" maxlength="4" max="9999" min="1" name="inputTel2" style="width:100px;" required>
                        -
                        <input onKeyup="this.value=this.value.replace(/[^0-9]/g,'');" oninput="maxLengthCheck(this)" type="text" id="inputTel3" maxlength="4" max="9999" min="1" name="inputTel3" style="width:100px;" required>
                        
                        <input type="hidden" id="theatTel" name="theatTel" >
                        
                    </div>
                    <div class="row">
                    <br>
                    </div>
                    <div class="form-group-1">
                        <div class="input-group-prepend">
                        <span class="input-group-text">상연관 등록</span>
                        <span> &nbsp;&nbsp;&nbsp; </span>
                        <input class="btn btn-outline-secondary" type="button" id="scrRmNmAdd" value="추가">
                        </div>
                        <br>
                        <div class="col-xs-4">
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
                        </div>	
                        </div>
                    </div>
                    <div class="form-group text-center">
                    <br>
                        <button type="submit" id="theat-submit" class="btn btn-primary" >
                            입력완료<i class="fa fa-check spaceLeft"></i>
                        </button>
                        <button type="reset"  class="btn btn-warning">
                            입력취소<i class="fa fa-times spaceLeft"></i>
                        </button>
                    </div>
                </form>
            </div>
<script>

function maxLengthCheck(object){

	   if (object.value.length > object.maxLength){

	    object.value = object.value.slice(0, object.maxLength);

	   }    

	  }

function insertOk(){
	
	var inRes = $('#insertRes').val();
	
	if(inRes == "0")
	{
		alert("오류발생");
	}
	else if(inRes == "1")
	{
		alert("극장등록 완료");
	}
}	

	
$(document).ready(function(){ 
	
	$('#theat-submit').click (function () {    
	
		var a = $('#sample6_postcode').val();
		
		if(a=="")
			{
			$('#sample6_postcode').focus();
			return false;
			}
	  });
	$('#scrRmNmAdd').click (function () {                                        
		
		$('.form-group-1').append (  
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
	
	$('#inputTel3').focusout(function(){ 
		 var tel = document.getElementById("inputTel1").value+'-'+
	               document.getElementById("inputTel2").value+'-'+
                   document.getElementById("inputTel3").value;
         document.getElementById("theatTel").value = tel ;
	});
	
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
		

	$('#sample6_detailAddress').focusout(function(){ 
		 var dtAddr = document.getElementById("sample6_detailAddress").value;
		 if(dtAddr == "")
			 {}
		 else
			 {
			 dtAddr = ' , '+dtAddr;
			 }
		 
		 var loc = 
                   document.getElementById("sample6_address").value+" "+
                   dtAddr+
		           document.getElementById("sample6_extraAddress").value+
		           ' <'+document.getElementById("sample6_postcode").value+'>'; 
		 document.getElementById("theatLoc").value = loc; 
	});
});
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = '(' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("sample6_extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }

</script>   
    </body>
</html>