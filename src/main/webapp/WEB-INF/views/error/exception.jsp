<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board</title>
</head>
<body>
	<article>
		<div class="container">
			<p>데이터를 처리 하는 과정에서 문제가 발생하였습니다.</p>
			<p>관리자에게 문의하여 주십시오.</p>
			<h3>${exception.getMessage()}</h3>
			<ul>
			<c:forEach items="${exception.getStackTrace()}" var="stack">
				<li>${stack.toString()}</li>
			</c:forEach>
			</ul>
		</div>
	</article>
</body>
</html>