<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>

	
	function fn_prev(page, range, rangeSize) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
		var url = "${globalCtx}/user/getUserList";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		location.href = url;
	} 
	
	function fn_pagination(page, range, rangeSize) {
		var url = "${getUserListURL}";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		console.log(url); location.href = url; 
	} 
	
	function fn_next(page, range, rangeSize) { 
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		var url = "${globalCtx}/user/getUserList";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		location.href = url;
	}
</script>

<article>
	<div class="container">
		<h3 class="board_cate">User List</h3>
			<div class="table-responsive">
				<table class="table table-sm" style="text-align:center;">
					<colgroup> 
						<col style="width:20%;" /> 
						<col style="width:20%;" /> 
						<col style="width:25%;" /> 
						<col style="width:15%;" /> 
						<col style="width:20%;" /> 
					</colgroup> 
					
					<thead> 
						<tr> 
							<th>User ID</th> 
							<th>User Name</th> 
							<th>E-Mail</th> 
							<th>Grade</th> 
							<th>Joined</th> 
						</tr> 
					</thead> 
					
					<tbody>
						<c:choose> 
							<c:when test="${empty userList }" > 
								<tr>
									<td colspan="5" align="center">No Data.</td>
								</tr> 
							</c:when> 
							
							<c:when test="${!empty userList}"> 
								<c:forEach var="list" items="${userList}"> 
									<tr> 
										<td><c:out value="${list.uid}"/></td> 
										<td><c:out value="${list.name}"/></td> 
										<td><c:out value="${list.email}"/></td> 
										<td><c:out value="${list.grade}"/></td> 
										<td><c:out value="${list.reg_dt}"/></td> 
									</tr> 
								</c:forEach> 
							</c:when> 
						</c:choose> 
					</tbody> 
				</table> 
			</div> 
			
			<!-- pagination{s} -->
			<div id="paginationBox" style="margin:20px;"> 
				<ul class="pagination justify-content-center"> 
					<c:if test="${pagination.prev}"> 
						<li class="page-item">
							<a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}')">Previous</a>
						</li> 
					</c:if>
					
					<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
						<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
							<a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}' )"> ${idx} </a>
						</li> 
					</c:forEach>
					
					<c:if test="${pagination.next}"> 
						<li class="page-item">
							<a class="page-link" href="#" onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">Next</a>
						</li> 
					</c:if> 
				</ul> 
			</div> 
			<!-- pagination{e} --> 
			
			
	</div>
</article>
