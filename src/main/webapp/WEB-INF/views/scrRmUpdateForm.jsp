<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body >
                <div class="row card-header">
                <div class="col-5">
                <h1>상영관 정보 수정</h1>
                </div>
                </div>
            <div class ="row card-body">
                <form role="form" method=POST action=scrRmUpdate onsubmit="return writeSave()">
                        <input type="hidden" id="theatId" name="theatId" value="${dto.theatId}">
                        <input type="hidden" id="scrRmId" name="scrRmId" value="${dto.scrRmId}"> 
                        <input type="hidden" id="totSeat" name="totSeat" value="${dto.totSeat}">                 
                    <div class="input-group-prepend">
						<span class="input-group-text">상영관 이름</span>
                        <input type="text" class="scrRmNm" name="scrRmNm" placeholder="상연관 이름을 입력해 주세요" style="width:250px;" required value="${dto.scrRmNm}"><br>
                     </div>	
                    <br>
                     <div class="input-group-prepend">
                        <span class="input-group-text">상영관 개관여부</span>
                        <select id="clsAt" name="clsAt"> 
                          <option value="Y">개관
                          <option value="N">페관
                        </select> 
                    </div>
                    <br>
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

$(document).ready(function(){ 

	var claAt = "<c:out value='${dto.clsAt}'/>";
    
    $('#clsAt').val(claAt).prop("selected", true);
	
});
</script>   
    </body>
</html>