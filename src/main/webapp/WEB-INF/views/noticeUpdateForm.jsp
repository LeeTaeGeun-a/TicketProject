<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<style>


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
							<h1 class="fns" id="fns">공지사항</h1>
							<p class="desc" id="desc">KG문화티켓의 새로운소식</p>
						</div>
					</div>
					<!--//title_box-->
				</div>
				
				<div class="section_body mw1200">
					<div class="list_search_head clearbox" id="noticeDiv" style="position: static;">
						<div class="search_box fr">
								
					<form role="form" method=POST action=noticeUpdate?pageNum=1 onsubmit="return confirm('공지를 등록 하시겠습니까?')">
                    <br>
                    <div class="input-group-prepend">
                        <input type="hidden" name="noticeNo" value="${dto.noticeNo}" id="noticeNo">
                        <input type="hidden" name="mberId" value="${dto.mberId}" id="mberId">
                         <span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </span>
                        <span class="input-group-text">공지 제목</span>
                        <span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </span>
                        <input type="text" class="form-control" id="noticeSj" name="noticeSj" value="${dto.noticeSj}" style="width:625px;" required>
                    </div>
                    
                    <div class="row">
                    
                    <br>
                    </div>
                    <div class="input-group-prepend">
                    
                       <span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  </span>
                       <span class="input-group-text">공지 내용</span>
                       <span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span>

                       <textarea name="content" class="form-control" rows="13"cols="100"style="width: 625px">${dto.content}</textarea>
                    </div>
                    <div class="form-group text-center">
                    <br>
                        <button type="submit" id="theat-submit" class="btn btn-primary" >
                            입력완료<i class="fa fa-check spaceLeft"></i>
                        </button>
                        <button type="reset"  class="btn btn-warning">
                            입력취소<i class="fa fa-times spaceLeft"></i>
                        </button>
                        <button type="button" class="btn_list" onclick="location.href = 'noticeSelectAll?mng=0'">목록</button>
                    </div>
                </form>
								
							</div>
							
						</div>
					</div>
			</section> 
        </div>
</body>
</html>