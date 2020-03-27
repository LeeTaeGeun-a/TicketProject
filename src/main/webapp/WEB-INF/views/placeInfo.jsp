<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="css/bootstrap-grid.css" rel="stylesheet">
<link href="css/bootstrap-reboot.min.css" rel="stylesheet">
<link href="css/bootstrap.css" rel="stylesheet" media="screen">
<link href="css/main.css" rel="stylesheet">
<link href="css/jquery-ui.css" rel="stylesheet">
 

<style type="text/css">

</style>

<style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 400px;
        width:  700px;
        margin-top: 30px;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
      
      #theatInfo{
		margin-top: 15px;
	  }
	  
	  #theatInfo tr{
	  	height: 45px;
	  }

	  #theatInfo td{
        font-size: 18px;
	  }
      
</style>

<script type="text/javascript">

		var geocoder;
		var map;
		
		function initialize() {
			
			geocoder = new google.maps.Geocoder();
		    var mapOptions = {
		      zoom: 15,
		    }
		    map = new google.maps.Map(document.getElementById('map'), mapOptions);
			
		    var address = document.getElementById('address').value;
		    geocoder.geocode( { 'address': address}, function(results, status) {
		      if (status == 'OK') {
		        map.setCenter(results[0].geometry.location);
		        var marker = new google.maps.Marker({
		            map: map,
		            position: results[0].geometry.location
		        });
		      } else {
		        alert('Geocode was not successful for the following reason: ' + status);
		      }
		    });
		  }
	
</script>


</head>
<body  onload="initialize()">
	
	<table id="theatInfo">
		<tr>
			<td>극장명</td>
			<td>&nbsp;&nbsp;&nbsp;${theatDto.theatNm}</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>&nbsp;&nbsp;&nbsp;${theatDto.theatLoc}</td>
		</tr>
		<tr>
			<td>연락처</td>
			<td>&nbsp;&nbsp;&nbsp;${theatDto.theatTel}</td>
		</tr>
	</table>
	

		<div id="map"></div>
		<input id="address" type="text" hidden="" value="${theatDto.theatLoc}">    
	
	
	

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAOKR05oWHHN8EUNKRFCDAzNA0bjhibU70&callback=initialize" async defer></script>
</body>
</html>