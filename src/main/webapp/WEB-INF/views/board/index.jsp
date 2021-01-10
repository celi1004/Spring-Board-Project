<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:url var="getBoardList" value="/board/getBoardList"></c:url>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>board</title>

<script>
		$(document).on('click', '#btnWriteForm', function(e){
			e.preventDefault();
			location.href = "${pageContext.request.contextPath}/board/boardForm";
		});
		
		function fn_contentView(bid){
			var url = "${pageContext.request.contextPath}/board/getBoardContent";
			url = url + "?bid="+bid;
			location.href = url;
		}

		//previous button
		function fn_prev(category, page, range, rangeSize, searchType, keyword){
			var page = ((range-2)*rangeSize) + 1;
			var range = range - 1;
			
			var url="${getBoardList}";
			url = url + "?category=" + category;
			url = url + "&page=" + page;
			url = url + "&range=" + range;
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + keyword;

			location.href = url;
		}
		
		//click the page number
		function fn_pagination(category, page, range, rangeSize, searchType, keyword) {

			var url = "${getBoardList}";
			url = url + "?category=" + category;
			url = url + "&page=" + page;
			url = url + "&range=" + range;
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + keyword;
	
			location.href = url;	
		}
		
		//next button
		function fn_next(category, page, range, rangeSize, searchType, keyword) {
			
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			var url = "${getBoardList}";
			url = url + "?category=" + category;
			url = url + "&page=" + page;
			url = url + "&range=" + range;
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + keyword;
	
			location.href = url;
		}
		
		// for search
		$(document).on('click', '#btnSearch', function(e){
			if($('#keyword').val() == ""){
				alert("No keyword for search");
			}else{
				e.preventDefault();
				console.log("btnSearch")
				var url="${getBoardList}";
				url = url + "?searchType=" + $('#searchType').val();
				url = url + "&keyword=" + $('#keyword').val();
				location.href = url;
				console.log(url);
			}
		});
		
</script>

<style type="text/css">
	.table-hover tbody tr:hover{
 		background-color:rgb(220,243,241, 0.4);
 	}
</style>

</head>
<body>
	<article>
		<div class="container">
			 
			<h2 class="board_cate">
				<c:choose>
					<c:when test="${pagination.category eq null or pagination.category eq 'all'}">
						All Posts
					</c:when>
					<c:otherwise>${pagination.category}</c:otherwise>
				</c:choose>
			</h2>
			
			
				<table class="table table-hover table-sm">
					<colgroup>
						<col style="width:30%;" />
						<col style="width:15%;" />
						<col style="width:10%;" />
						<col style="width:10%;" />
					</colgroup>
			
			
					<tbody>
						<c:choose>
							<c:when test="${empty boardList }" >
								<tr><td colspan="5" align="center">No data</td></tr>
							</c:when> 
							<c:when test="${!empty boardList}">
								<c:forEach var="list" items="${boardList}">
									<tr>
										<td style="padding:10px;">
											<a href="#" onClick="fn_contentView(<c:out value="${list.bid}"/>)" style="text-decoration:none;">
												<div style="font-size:14pt; font-weight:550; margin-left:15px;">
													<c:out value="${list.title}"/>
												</div>
					
												<div style="color:#6E7783; font-size:10pt; float:left; margin-top:3px; margin-left:20px;">
													<c:out value="${list.reg_id}"/>
													&nbsp;&nbsp;,&nbsp;&nbsp;
													<c:out value="${list.reg_dt}"/>
												</div>
												<div style="float:right; font-size: 8pt; color:#a3a1a1; width:50px; margin-top:3px;">
													<img src="/resources/images/icon/view.png" style="width:16px;heigth:16px;margin-right:5px;"></img>
													<span style=""><c:out value="${list.view_cnt}"/></span>
												</div>
											</a>
											
										</td>
									</tr>
								</c:forEach>
							</c:when>
						</c:choose>
					</tbody>
				</table>
			
			<!-- search{s} -->
			<div class="form-group row jusity-content-center" style="float:right; margin:5pt; margin-right:10pt; margin-bottom:30pt;">
				<div class="w100" style="padding-right:10px">
					<select class="form-control form-control-sm" name="searchType" id="searchType">
						<option value="all">all</option>
						<option value="title">title</option>
						<option value="Content">content</option>
						<option value="reg_id">writer</option>
					</select>
				</div>
				<div class="w300" style="padding-right:10px">
					<input type="text" class="form-control form-control-sm" name="keyword" id="keyword" value="${pagination.keyword}" >
				</div>
				<div>
					<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">Search</button>
				</div>
			</div>
			<!-- search{e} -->
			
			<div style="float:left; margin-left: 15pt; margin-top:5pt; margin-bottom:30pt;">
				<button type="button" class="btn btn-sm btn-primary" id="btnWriteForm">Post</button>
			</div>
			
			<br>
			
			<!-- pagination{s} -->
			<div id="paginationBox" style="clear:both;">
				<ul class="pagination justify-content-center">
					<c:if test="${pagination.prev}">
						<li class="page-item"><a class="page-link" href="#" onClick="fn_prev('${pagination.category}', '${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${search.searchType}', '${search.keyword}')">Previous</a></li>
					</c:if>
		
					<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">
						<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
						<a class="page-link" href="#" onClick="fn_pagination('${pagination.category}', '${idx}', '${pagination.range}', '${pagination.rangeSize}', '${search.searchType}', '${search.keyword}')"> ${idx} </a></li>
					</c:forEach>
		
						
					<c:if test="${pagination.next}">
						<li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.category}', '${pagination.range}', '${pagination.range}', '${pagination.rangeSize}', '${search.searchType}', '${search.keyword}')" >Next</a></li>
					</c:if>
				</ul>
			</div>
			<!-- pagination{e} -->
		
		</div>
	</article>
</body>
</html>