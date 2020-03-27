<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>
ul.mylist li, ol.mylist li { 
    list-style: none; 
    display: table;
    padding: 5px 0px 14px 5px; 
    margin-top: 5px; 
    margin-bottom: 10px; 
    border-bottom: 1px solid #efefef; 
    font-size: 12px; 
    width: 700px;
  margin-left: auto;
  margin-right: auto;
    
} 

 a:link { color: black; text-decoration: none;}
 a:visited { color: black; text-decoration: none;}
 a:hover { color: black; text-decoration: none;}

span.grid_list_date{
float: right;
}


span.grid_list_tit{

 text-align: center;
}

div.page_list{
 text-align: center;
}

span.aa{
float: right;
}

div.search_box {
border-top: 1px solid #efefef; 
 border-bottom: 1px solid #efefef; 
}

div.section_head{
 text-align: center;
}

</style>


</head>


<div >
        	<section class="section mypage">
				<div class="ct_top">
					<!--title_box 20181215 수정 -->
					<div class="section_head">
						<div class="inner mw1200">
						<br><br>
							<h1 class="fns" id="fns">공지사항</h1>
							<p class="desc" id="desc">KG문화티켓의 새로운소식</p>
							<input type="hidden" name="mberId" value="${mberId}" id="mberId">
						</div>
					</div>
					<!--//title_box-->
				</div>
				<c:if test="${mng == 0}">
				<span style="text-align: center;">  
				<a href="noticeInsertForm"><button type="button" id="theat-submit" class="btn btn-primary">
                           새 공지 작성</button></a>
                </span>
                </c:if>
				<div class="section_body mw1200">
					<!-- search_box -->
					<div class="list_search_head clearbox" id="noticeDiv">
						<div class="search_box fr">
							<div class="input_box">
								<form action="noticeSelectAllKey" method="get" id="form" class="example">
		                            <br>
		                            <span class="aa">
		                            <input type="hidden" name="mng" value="${mng}" id="mng">
		                            <input type="text" placeholder="검색어를 입력해주세요." id="searchKeyword" name="searchKeyword" value="" style="border: none; background: transparent;">
		                            <button class="btn btn-primary" type="submit"><i class="fas fa-search"></i></button>
                        		</span>
                        		<br>
                        		<br>
                        		</form>
							</div>
							
						</div>
					</div>
					<!-- //search_box -->
					<!-- grid_list -->
					
	                <div class="grid_list" id="gridlist">
	                    <ul class="mylist">
	                         <c:forEach var="dto" items="${LIST}">
	                        <li>
	                            <a href="noticeUpdateForm?noticeNo=${dto.noticeNo}&mng=${mng}">
	                                <span class="grid_list_impo">${dto.noticeNo} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>
	                                <span class="grid_list_tit">${dto.noticeSj}</span>
	                                <span class="grid_list_date">${dto.registDt}</span>
	                            </a>
	                        </li>
	                        </c:forEach>
	                    </ul>
	                </div>
	
	                <!-- paging -->
	                <div class="paging_box mt40">
	                    <div class="page_list" id="pageList">
	                	  <c:if test="${strPage > 10}">
		<a href = "noticeSelectAll?pageNum=${strPage - 10}">[이전]</a>
    </c:if>
	
	<c:forEach var="i" begin="${strPage}" end="${endPage}">
			<a href = "noticeSelectAll?pageNum=${i}&mng=${mng}">
	[${ i }]</a>
	</c:forEach>
		
    <c:if test="${endPage < pageCnt}">
		<a href = "noticeSelectAll?pageNum=${strPage+1-10}">[다음]</a>
    </c:if>
	                    </div>
	                </div>
	                <!-- //paging -->
                </div> 
                
             
			</section> 
			
          
        </div>


</body>
</html>