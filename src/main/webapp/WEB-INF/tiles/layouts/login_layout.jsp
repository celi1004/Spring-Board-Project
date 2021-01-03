<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html lang="kr">
<head>
	<meta charset="UTF-8">
	
<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

<!-- Custom styles for this template -->
<link rel="stylesheet" href="<c:url value='/resources/common/css/loginin.css'/>" >

<style>
	body{padding : 0px}
	#tile_body { width:100%; float:left; }
</style>

</head>

<body class="text-center">
	<div id="tile_body"><tiles:insertAttribute name="tile_body" /></div>
</body>

</html>
