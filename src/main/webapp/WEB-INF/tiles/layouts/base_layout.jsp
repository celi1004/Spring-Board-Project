<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>

<!DOCTYPE html>
<html lang="kr">
<head>
	<meta charset="UTF-8">
	
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<!-- common CSS -->
<link rel="stylesheet" href="<c:url value='/resources/common/css/common.css?ver=1.2'/>" > 

<%@ include file="/WEB-INF/tiles/layouts/header.jsp"%>

<style>
	body{padding : 0px}
	#tile_header { width:100%; }
	#tile_body { width:100%; float:left; }
</style>

</head>

<body >

	<div class="main_content align-self-stretch" id="tile_body"><tiles:insertAttribute name="tile_body" /></div>

	<div class="bg-light" id="tile_footer"><tiles:insertAttribute name="tile_footer"/></div>
	
	<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js" integrity="sha384-q2kxQ16AaE6UbzuKqyBE9/u/KzioAlnx2maXQHiDX9d4/zp8Ok3f+M7DPm+Ib6IU" crossorigin="anonymous"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-pQQkAEnwaBkjpqZ8RU1fF1AKtTcHJwFl3pblpTlHXybJjHpMYo79HY3hIi4NKxyj" crossorigin="anonymous"></script>
</body>
</html>