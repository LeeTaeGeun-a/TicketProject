<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="js/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/insertFormPbl.js"></script>
<link href="css/jquery-ui.css" rel="stylesheet">
</head>
<body>
	<!-- hidden -->
	<input type="hidden" id ="pblInsertRes" value="${successInsert}">  
    <!-- 극장Modal -->
	<div class="modal fade" id="theatModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content" style="width: 800px;">
	      <div class="modal-header">
	        <h5 class="modal-title" id="exampleModalLabel">극장조회</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<div class="form-row form-group">
	      		<div class="input-group col-3">
	      			<select class="custom-select" name="theatSearchCdt" id="theatSearchCdt">
						<option value ="" selected>검색조건</option>
						<option value ="theatNm">극장명</option>
						<option value ="theatLc">지역</option>
					</select>
	        	</div>
	        	<div class="input-group col-7">
	        		<input type="text"  class="form-control" id="theatSearchWord">
	        	</div>
	        	<div class="input-group col-2">
	        		<input type="button" class="btn btn-primary" id="theatSearch" value="조회">
	        	</div>
	        </div>
	       <div id="resContainer"></div>
		       <div class="row" style="margin-top: 50px;">
						<div class="col-2 text-center" id ="theatPaging" style="float: none; margin: 0 auto;"></div>
			   </div> 
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
	        <button type="button" class="btn btn-primary" id="btnStore" data-dismiss="modal">저장</button>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="container" >
		<div class="row" style="margin-top: 50px;">
			<div class="col-10" style="float: none; margin: 0 auto;">
			<!-- form 시작 -->
				<form class ="was-validated" method="post" action="insertPblprfr.do" enctype="multipart/form-data">
					<div class="form-row form-group">
						<div class="input-group col-3 offset-9">
							<div class="input-group-prepend">
								<span class="input-group-text">공연 ID</span>
							</div>
							<input type="text" class="form-control" value="${maxPblId}" name="pblprfrId" readonly="readonly" >	   
						</div>
					</div>
					<br>
					<div class ="row">
						<div class="col-3">
							<img src="img/basicSumnail.PNG" class="img-thumbnail" id="preView" style="width: 200px; height: 270px;">	 
						</div>
						<div class="col-9">
							<div class="form-row form-group">
								<div class="input-group col-6" >
									<div class="input-group-prepend">
										<span class="input-group-text">대표 포스터</span>
									</div>
									<div class="custom-file">
									   <input type="file" class="custom-file-input"  name="titleImg" id="titleImg" accept=".jpg,.jpeg,.png,.gif">
									   <label class="custom-file-label text-truncate" for="titleImg" id="titleImgLabel">Choose File..</label>
									   <div class="invalid-feedback">대표 포스터를 등록해주세요.</div>
									   <div class="valid-feedback">&nbsp;</div>
									</div>
									&nbsp;
							
								</div>
								<div class="input-group col-6" >
									<div class="input-group-prepend">
										<span class="input-group-text">상세 포스터</span>
									</div>
									<div class="custom-file">
										<input type="file" class="custom-file-input" name="detailImg" id="detailImg" accept=".jpg,.jpeg,.png,.gif">
										<label class="custom-file-label text-truncate" id="detailImgLabel" for="detailImg" >Choose File..</label>								
										<div class="invalid-feedback">상세 포스터를 등록해주세요.</div>
										<div class="valid-feedback">&nbsp;</div>
									</div>
									&nbsp;
								
								</div>
							</div>	
							<div class="form-row form-group">
								<div class="input-group col-7">
									<div class="input-group-prepend">
										<span class="input-group-text">극장</span>
									</div>
									<input type="text" class="form-control" placeholder="ex)조회버튼클릭해주세요" id="theatNm" onfocus="this.blur();" autocomplete="off" required>
									&nbsp;
									<button type="button" class="btn btn-outline-secondary" data-toggle="modal" data-target="#theatModal" id="btnTheatSearch" >극장조회</button>
									<div class="invalid-feedback">
							         	 극장을 선택해주세요.
							        </div>
							        <div class="valid-feedback">
								     	&nbsp;
								    </div>	
								</div>
								<input type="text" id= "theatId" name="theatId" hidden=""> <!-- 선택된 극장 ID담는 부분 -->
								<div class="input-group col-5">
									<div class="input-group-prepend">
										<span class="input-group-text">상영관</span>
									</div>
									<select class="custom-select" id="scrRmSelect"  name="scrinngRmId" required>
										<option value ="" selected>선택해주세요</option>
									</select>
									<div class="invalid-feedback">
							        	 상영관을 선택해 주세요.
							        </div>
							        <div class="valid-feedback">
								     	&nbsp;
								    </div>	
								</div>
							</div>
							<div class="form-row form-group">
								<div class="input-group col-8">
									<div class="input-group-prepend">
										<span class="input-group-text">공연 제목</span>
									</div>
									<input type="text" class="form-control" placeholder="ex)오백에 삼십" name="pblNm" autocomplete="off" required>
									<div class="invalid-feedback">
							         	 공연 제목을 입력해주세요.
							        </div>
							        <div class="valid-feedback">
								     	&nbsp;
								    </div>	  
								</div>
								<div class="input-group col-4">
									<div class="input-group-prepend">
										<span class="input-group-text">장르</span>
									</div>
									<select class="custom-select" name="genre" required>
										<option value ="" selected>선택해주세요</option>
										<option value ="연극" >연극</option>
										<option value ="뮤지컬">뮤지컬</option>
										<option value ="콘서트">콘서트</option>
										<option value ="아동극">아동극</option>
									</select>
									<div class="invalid-feedback">
							         	장르를 선택해주세요.
							        </div>
							        <div class="valid-feedback">
								     	&nbsp;
								    </div>	
								</div>
								
							</div>
							<div class="form-row form-group">
								<div class="input-group col-12">
									<div class="input-group-prepend">
										<span class="input-group-text">공연 시작일</span>
									</div>
									<input type="text" class="form-control is-invaild" placeholder="달력에서 선택" onfocus="this.blur();" id="from" name="startPeriod" autocomplete="off" required >
									<div class="input-group-prepend">
										<span class="input-group-text">공연 종료일</span>
									</div>
									<input type="text" class="form-control is-invaild" placeholder="달력에서 선택" onfocus="this.blur();" id="to" name="endPeriod" autocomplete="off" required>
									<div class="invalid-feedback">
							         	 기간을 입력해주세요.
							        </div>
							        <div class="valid-feedback">
								     	&nbsp;
								    </div>	
								</div>
							</div>
						</div>
					</div>
					
					<div class="row" style="margin-top: 5px;">
						<div class="col-12">
							<div class="form-row form-group">
								<div class="input-group col-4" >
									<div class="input-group-prepend">
										<span class="input-group-text">런타임</span>
									</div>
									<input type="number" class="form-control" placeholder="ex)60(분단위 입력)" name="runTime" maxlength="3" required >
									<div class="invalid-feedback">
							         	 런타임을 입력해주세요.
							        </div>
							        <div class="valid-feedback">
								     	&nbsp;
								    </div>	
								</div>
								<div class="input-group col-4" >
									<div class="input-group-prepend">
										<span class="input-group-text">관람등급</span>
									</div>
									<select class="custom-select" name="grade" required>
										<option value ="" selected>선택해주세요</option>
										<option value ="A" >전체이용가</option>
										<option value ="T">12세이용가</option>
										<option value ="F">15세이용가</option>
										<option value ="N">성인등급</option>
									</select>
									<div class="invalid-feedback">
							         	관람등급을 선택해주세요.
							        </div>
							        <div class="valid-feedback">
								     	&nbsp;
								    </div>	
								</div>
								<div class="input-group col-4">
									<div class="input-group-prepend">
										<span class="input-group-text">가격</span>
									</div>
									<input type="number"class="form-control" placeholder="ex)7000" name="price"  required>
									<div class="invalid-feedback">
							         	 가격을 입력해주세요(숫자만입력가능)
							        </div>
							        <div class="valid-feedback">
								     	&nbsp;
								    </div>	
								</div>
							</div>
							<div class="form-row form-group">
								<div class="input-group col-10">
									<div class="input-group-prepend">
										<span class="input-group-text">출연배우 명단</span>
									</div>
									<textarea class="form-control" name ="actor" placeholder="ex)주연:현빈,주연:한예슬,조연:원빈,카메오:김태희"></textarea>
									<div class="valid-feedback">
								     	생략가능
								    </div>	
								</div>
								<div class="input-group col-2" >
									<label for="raioes" style="padding-top: 5px;">공연여부</label>
									<div id="radioes" style="padding-top: 5px; margin-left: 5px;">
										<div class="custom-control custom-radio">
										  <input class="custom-control-input" type="radio" name="pblprfrAt" id="inlineRadio1" value="Y" checked required>
										  <label class="custom-control-label" for="inlineRadio1">YES</label>
										</div>
										<div class="custom-control custom-radio">
										  <input class="custom-control-input" type="radio" name="pblprfrAt" id="inlineRadio2"  value="N" required>
										  <label class="custom-control-label" for="inlineRadio2">NO</label>
										</div>
									</div>	
								</div>
							</div>
							<div class="form-row form-group">
								<div class="input-group col">
									<div class="input-group-prepend">
										<span class="input-group-text">연출</span>
									</div>
									<textarea class="form-control" name ="dirc" placeholder="ex)감독:홍길동 ,카메라감독 :고길동"></textarea>
									<div class="valid-feedback">
								     	생략가능
								    </div>	
								</div>
							</div>
							
						</div>
					</div>

					<div style="float: right;">
					<input class="btn btn-primary" type="submit" id="submitPbl" value="등록">
					<input class="btn btn-primary" type="reset" value="초기화">
					</div>
				</form>
			</div>
		</div>
	</div>
    </body>
</html>