<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>


div.section_head{
 text-align: center;
   border-bottom: 1px solid #efefef; 
}

div.aa{
border-bottom: 1px solid #efefef; 
}

</style>
</head>


<div class = "aa">
        	<section class="section mypage">
				<div class="ct_top">
					<!--title_box 20181215 수정 -->
					<div class="section_head">
						<div class="inner mw1200">
						<br>
							<h3 class="fns" id="fns">${dto.noticeSj}</h3>
							<p class="desc" id="desc">${dto.registDt}</p>
						</div>
					</div>
					<!--//title_box-->
				</div>
				<div class="section_body mw1200">
	                <div class="grid_list" id="gridlist" style="margin-left: 300px">
	                    <pre>${dto.content}</pre>
	                <br>
	                <br>
	                </div>
                </div> 
			</section> 
        </div>
             <div class="btn_box" style="text-align: right;">
               <button type="button" class="btn_list" onclick="location.href = 'noticeSelectAll'">목록</button>
             </div>

</body>
</html>