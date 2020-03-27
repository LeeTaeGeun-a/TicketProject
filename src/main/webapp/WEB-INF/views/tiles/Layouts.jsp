<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>   
<%@ taglib prefix="tiles" uri = "http://tiles.apache.org/tags-tiles" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>KG Tiket</title>
</head>
<body>
	<header id="siteTop">
		<tiles:insertAttribute name="siteTop"/>
	</header>
	<div id ="content">
		<tiles:insertAttribute name="content"/>
	</div>
	<footer id="siteBottom">
		<tiles:insertAttribute name="siteBottom"/>
	</footer>
</body>
</html>