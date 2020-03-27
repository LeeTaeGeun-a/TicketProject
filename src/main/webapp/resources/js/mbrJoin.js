$(function() {
	// 폼 입력시 특수문자 영문 및 숫자 처리
	$('#mberId').keyup(function() {
		var text = $(this).val();
		text = blockKoAndSpecial(text);
		$(this).val(text);
	})
	
	$('#mberEmail').keyup(function() {
		var text = $(this).val();
		text = blockKoAndSpecial(text);
		$(this).val(text);
	})
	
	$('#emailSite').keyup(function() {
		var text = $(this).val();
		var ck = 0;
		text = text.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, "");
		
		for (var i=0; i < text.length; i++) { 
		    ch_char = text.charAt(i);
		    ch = ch_char.charCodeAt();
	
		    if( (ch >= 33 && ch <= 45) || (ch >= 58 && ch <= 64) || (ch >= 91 && ch <= 96) || (ch >= 123 && ch <= 126) ) {
		            
		    }
		}
		if(ck == 1){
			alert('특수문자를 사용할수 없습니다.');
		}
		$(this).val(text);
	})
	
	$('#mberTel').keyup(function() {
		var text = $(this).val();
		text = blockKoAndSpecial(text);
		text = text.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣A-Za-z]/g, "");
		$(this).val(text);
	})
	
	function blockKoAndSpecial(text) {
		
		text = text.replace(/[\ㄱ-ㅎㅏ-ㅣ가-힣]/g, "");
		var ck = 0;
		for (var i=0; i < text.length; i++) { 
		    ch_char = text.charAt(i);
		    ch = ch_char.charCodeAt();
	
		    if( (ch >= 33 && ch <= 47) || (ch >= 58 && ch <= 64) || (ch >= 91 && ch <= 96) || (ch >= 123 && ch <= 126) ) {
		    		ck = 1;
		    }
		}
		if(ck == 1){
			alert('특수문자를 사용할수 없습니다.');
		}

		return text;
	}
	// cancle btn 처리
	$('#cancle').click(function() {
		document.location = "/TiketProject";
	})
	
 
})