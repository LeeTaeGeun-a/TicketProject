<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
      
            <div class="card mb-4">
                            <div class="card-header">
                            극장정보 검색
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                           
                                    <table class="table table-bordered" id="dataTable">
                                        <thead>
                                            <tr>
                                                <th>극장 아이디</th>
                                                <th>극장 이름</th>
                                                <th>극장 위치</th>
                                                <th>극장 전화번호</th>
                                                <th>상영관</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach var="dto" items="${LIST}">
                                            <tr>
                                             <td>${dto.theatId}</td>
                                             <td><a href="theatUpdateForm?theatId=${dto.theatId}">${dto.theatNm}</a></td>
                                             <td>${dto.theatLoc}</td>
                                             <td>${dto.theatTel}</td>
                                             <td><a href="scrRmSelectAll?theatId=${dto.theatId}">상영관 정보</a></td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                 
                                </div>
                            </div>
                        </div>
     

        <script src="resources/js/jquery.dataTables.min.js"></script>
        <script src="resources/js/dataTables.bootstrap4.min.js" ></script>
 <script src="resources/js/datatables-demo.js"></script>

    </body>
</html>