<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="tiles" uri = "http://tiles.apache.org/tags-tiles" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>KG 문화 티켓 관리자 메인</title>
        <link href="resources/css/styles.css" rel="stylesheet" />
        <link href="resources/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
        <link href="css/jquery-ui.css" rel="stylesheet">
        <script src="resources/js/all.min.js"></script>
        <script src="resources/js/jquery-3.4.1.min.js" ></script>
        <script type="text/javascript" src="js/jquery-ui.min.js"></script>

<style>
.main_container{ 
 position:static; 
  top:0px; 
  /* border:lpx dotted red; */ 
} 
</style> 
</head>
<body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle"><i class="fas fa-bars"></i></button
            >
            <a class="navbar-brand" href="mngHome.do">KG 문화 티켓 관리페이지</a>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
                <div class="input-group">
                </div>
            </form>
            <!-- Navbar-->
            <ul class="navbar-nav ml-auto ml-md-0" style="float: right;">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="userDropdown" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
                    <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
                        <a class="dropdown-item" href="mngMberUpdateForm.do?mberId=${loginedId}">사용자정보</a>
                        <a class="dropdown-item" href="/TiketProject">메인으로 가기</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="logOut.do">로그아웃</a>
                    </div>
                </li>
            </ul>
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu">
                        <div class="nav">
                            <a class="nav-link" href="/TiketProject">
                             KG 문화 티켓 홈페이지</a>
                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts" aria-expanded="false" aria-controls="collapseLayouts">
                                극장
                            </a>
                            <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                <a id ="theatSelect" class="nav-link" href="theatSelectAll">극장 관리</a>
                                <a id ="theatInsert" class="nav-link" href="theatInsertForm">극장 등록</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts4" aria-expanded="false" aria-controls="collapseLayouts">
                                공연
                            </a>
                            <div class="collapse" id="collapseLayouts4" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                <a id ="pblprfrUpdete" class="nav-link" href="updateFormPbl.do">공연 관리</a>
                                <a id ="pblprfrInsert" class="nav-link" href="insertFormPbl.do">공연 등록</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts2" aria-expanded="false" aria-controls="collapseLayouts2">
                                회원
                            </a>
                            <div class="collapse" id="collapseLayouts2" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                <a id = "mberSelect" class="nav-link" href="mngMberSelectForm.do">회원 관리</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages2" aria-expanded="false" aria-controls="collapsePages2">
                             예매
                            </a>
                            <div class="collapse" id="collapsePages2" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                                   <a id = "mberSelect" class="nav-link" href="advantkManageForAdmin.do">예매 관리</a>
                        
                                    <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-parent="#sidenavAccordionPages">
                                    </div>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseLayouts3" aria-expanded="false" aria-controls="collapseLayouts3">
                                게시판 관리
                            </a>
                            <div class="collapse" id="collapseLayouts3" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                                <nav class="sb-sidenav-menu-nested nav">
                                <a class="nav-link " href="noticeSelectAll?mng=0">공지글 관리</a>
                                <a class="nav-link " href="mngInqListSelect.do">문의글 관리</a>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <div class="sb-sidenav-footer">
                        <div class="small">Logged in as:</div>
                        Start Bootstrap
                    </div>
                </nav>
            </div>
            <div id="layoutSidenav_content" class="main_container" >
            	<div id ="mainContent">
					<tiles:insertAttribute name="mainContent"/>
				</div>
            </div>
            </div>
        
        <script src="resources/js/bootstrap.bundle.min.js" ></script>
        <script src="resources/js/scripts.js"></script>
        <script src="resources/js/jquery.dataTables.min.js"></script>
        <script src="resources/js/dataTables.bootstrap4.min.js" ></script>
        <script src="resources/js/datatables-demo.js"></script>
    
</body>
</html>