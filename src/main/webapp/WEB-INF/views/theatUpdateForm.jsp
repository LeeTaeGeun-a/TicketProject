<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body onload="updateData()">
                <div class="row card-header">
                <div class="col-5">
                <h1>극장 정보 수정</h1>
                </div>
                </div>
            <div class ="row card-body">
                <form role="form" method=POST action=theatUpdate onsubmit="return confirm('극장을 수정 하시겠습니까?')">
                    <div class="form-group">
                        <label for="inputName">극장 이름</label>
                        <input type="hidden" id="theatId" name="theatId" value="${dto.theatId}">
                        <input type="text" class="form-control" id="theatNm" name="theatNm" value="${dto.theatNm}" style="width:410px;" required> 
                    </div>
                    <div class="form-group">
                       <label for="inputAddr">극장 주소</label><br>
                       <input type="text" id="sample6_postcode" placeholder="우편번호" readonly>
                       <input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
                       <input type="text" id="sample6_address" placeholder="주소" readonly><br>
                       <input type="text" id="sample6_detailAddress" placeholder="상세주소">
                       <input type="text" id="sample6_extraAddress" placeholder="참고항목" readonly>
                       <input type="hidden" id="theatLoc" name="theatLoc" value="${dto.theatLoc}">
                    </div>
                    <div class="form-group">
                        <label for="inputTel">극장 전화번호</label><br>
                        <select id="inputTel1" name="inputTel1"> 
                          <option value="010">010 
                          <option value="02" >02 
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
                        <input type="number" id="inputTel2" oninput="maxLengthCheck(this)" maxlength="4" max="9999" name="inputTel2" style="width:100px;" required>
                        -
                        <input type="number" id="inputTel3" oninput="maxLengthCheck(this)" maxlength="4" max="9999" name="inputTel3" style="width:100px;" required>
                        
                        <input type="hidden" id="theatTel"  name="theatTel" value="${dto.theatTel}" >
                        
                    </div>
                    
                     <div class="form-group">
                        <label for="theatAt">극장 영업여부</label><br>
                        <select id="theatAt" name="bizQitAt"> 
                          <option value="Y" selected>영업중
                          <option value="N">페업
                        </select> 
                    </div>
                    
                    <div class="form-group text-center">    
                        <button type="submit" id="theat-submit" class="btn btn-primary">
                            입력완료<i class="fa fa-check spaceLeft"></i>
                        </button>
                        <button type="reset" class="btn btn-warning">
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

function writeSave(){
	
    if($("#theatNm").val() ==''){
        alert('극장 이름을 입력하세요');
        $("#theatNm").focus();
        return false;
    }

    var loc = $('#theatLoc').val();
    if($('#theatLoc').val() == ''){
        alert('주소를 입력하세요');
        return false;
    } 

    if($("#inputTel2").val() ==''){
        alert('전화번호를 입력하세요');
        $("#inputTel2").focus();
        return false;
    } 
    
    if($("#inputTel3").val() ==''){
        alert('전화번호를 입력하세요');
        $("#inputTel3").focus();
        return false;
    } 
}

function updateData() { 
	var addr0 = document.getElementById("theatLoc").value;
	
	var a
		var addr1 = addr0.split("  , ");
	
		if(addr0==addr1[0])
		{
			
		var addr2 = addr1[0].split(" (");
		
		a = addr2[1];
	
		var addr3 = a.split(" <");
		
		document.getElementById("sample6_postcode").value = addr3[1].replace(">","")  ;
		
		document.getElementById("sample6_address").value = addr2[0] ;
		document.getElementById("sample6_extraAddress").value = "(" + addr3[0] ;	
		}
		else
		{
			
		var addr2 = addr1[1].split("(");
	    a = addr2[1];
	    
	    var addr3 = a.split(" <");
	    
	    document.getElementById("sample6_postcode").value = addr3[1].replace(">","")  ;
		document.getElementById("sample6_address").value = addr1[0] ;
		document.getElementById("sample6_detailAddress").value = addr2[0] ;
		document.getElementById("sample6_extraAddress").value = "(" + addr3[0] ;	
		}
		
	var tel0 = document.getElementById("theatTel").value;
	
	    var tel1 = tel0.split("-");
	    
	    $('#inputTel1').val(tel1[0]).prop("selected", true);
	    
	    document.getElementById("inputTel2").value = tel1[1];
		document.getElementById("inputTel3").value = tel1[2] ;
		
	}

$(document).ready(function(){ 	
	
	$('#inputTel3').focusout(function(){ 
		 var tel = document.getElementById("inputTel1").value+'-'+   
	               document.getElementById("inputTel2").value+'-'+
                   document.getElementById("inputTel3").value;
         document.getElementById("theatTel").value = tel ;
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
                        extraAddr = ' (' + extraAddr + ')';
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