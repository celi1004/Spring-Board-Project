<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>board</title>

<script>

	$(document).ready(function(){
		showReplyList();
	});

	// move to board list
	$(document).on('click', '#btnList', function(){
		location.href = "${pageContext.request.contextPath}/board/getBoardList?category="+"${boardContent.cate_cd}";
	});
	
	//click modify button
	$(document).on('click', '#btnUpdate', function(){
		var url = "${pageContext.request.contextPath}/board/editForm";
		url = url + "?bid="+${boardContent.bid};
		url = url + "&mode=edit";

		location.href = url;
	});

	//click delete button
	$(document).on('click', '#btnDelete', function(){
    	var url = "${pageContext.request.contextPath}/board/deleteBoard";
    	url = url + "?bid=" + ${boardContent.bid};
		location.href = url;
	});
	
	function showReplyList(){
		var url = "${pageContext.request.contextPath}/restBoard/getReplyList";
		var paramData = {"bid": "${boardContent.bid}"};
		
		$.ajax({
			type:'POST',
			url: url,
			data: paramData,
			dataType: 'json',
			success: function(result){
				var htmls = "";
				if(result.length < 1){
					htmls = "<div class='board_cate' style='font-size:10pt;'>등록된 댓글이 없습니다.</div>";
				}else{
					$(result).each(function(){
						htmls += '<div class="media text-muted pt-3" id="rid'+this.rid+'">';
						htmls += '<img src="/resources/images/icon/profile.png" style="width:32px;heigth:32px;margin-right:10px;"></img>';
	                    htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
	                    htmls += '<span class="d-block">';
	                    htmls += '<strong class="text-gray-dark">' + this.reg_id + '</strong>';
	                    htmls += '<span style="padding-left: 7px; font-size: 9pt">';
	                    htmls += '<a href="javascript:void(0)" onclick="fn_editReply(' + this.rid + ', \'' + this.reg_id + '\', \'' + this.content + '\' )" style="padding-right:5px">수정</a>';
	                    htmls += '<a href="javascript:void(0)" onclick="fn_deleteReply(' + this.rid + ')" >삭제</a>';
	                    htmls += '</span>';
	                    htmls += '</span>';
	                    htmls += this.content;
	                    htmls += '</p>';
	                    htmls += '</div>';
					});
				}
				$("#replyList").html(htmls);
			}
		});
	}
	
	//click the save reply button
	$(document).on('click', '#btnReplySave', function(){
		var replyContent = $('#content').val();
		var replyReg_id = $('#reg_id').val();
		
		if(replyContent=="" || replyReg_id==""){
			alert("댓글 내용과 작성자 이름을 입력해주세요.");
		}else{
			var paramData = JSON.stringify({"content": replyContent
				, "reg_id": replyReg_id
				, "bid":'${boardContent.bid}'
			});
		
			var headers = {"Content-Type" : "application/json"
					, "X-HTTP-Method-Override" : "POST"};
	
			$.ajax({
				url: "${pageContext.request.contextPath}/restBoard/saveReply"
				, headers : headers
				, data : paramData
				, type : 'POST'
				, dataType : 'text'
				, success: function(result){
					showReplyList();
	
					$('#content').val('');
					$('#reg_id').val('');
				}
				, error: function(error){
					console.log("에러 : " + error);
				}
			});
		}
	});
	
	function fn_editReply(rid, reg_id, content){

		var htmls = "";

		htmls += '<div class="media text-muted pt-3" id="rid' + rid + '">';
		
		htmls += '<img src="/resources/images/icon/profile.png" style="width:32px;heigth:32px;margin-right:10px;"></img>';
		htmls += '<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">';
		htmls += '<span class="d-block">';
		htmls += '<strong class="text-gray-dark">' + reg_id + '</strong>';
		htmls += '<span style="padding-left: 7px; font-size: 9pt">';
		htmls += '<a href="javascript:void(0)" onclick="fn_updateReply(' + rid + ', \'' + reg_id + '\')" style="padding-right:5px">저장</a>';
		htmls += '<a href="javascript:void(0)" onClick="showReplyList()">취소<a>';
		htmls += '</span>';
		htmls += '</span>';		
		htmls += '<textarea name="editContent" id="editContent" class="form-control" rows="3">';
		htmls += content;
		htmls += '</textarea>';
		htmls += '</p>';
		htmls += '</div>';

		$('#rid' + rid).replaceWith(htmls);
		$('#rid' + rid + ' #editContent').focus();
	}
	
	function fn_updateReply(rid, reg_id){

		var replyEditContent = $('#editContent').val();
		
		if(replyEditContent != ""){
			var paramData = JSON.stringify({"content": replyEditContent, "rid": rid});

			var headers = {"Content-Type" : "application/json", "X-HTTP-Method-Override" : "POST"};

			$.ajax({
				url: "${pageContext.request.contextPath}/restBoard/updateReply"
				, headers : headers
				, data : paramData
				, type : 'POST'
				, dataType : 'text'
				, success: function(result){
	                console.log(result);
					showReplyList();
				}
				, error: function(error){
					console.log("에러 : " + error);
				}
			});
		}else{
			alert("내용을 입력해주세요.");
		}
	}
	
	function fn_deleteReply(rid){

		var paramData = {"rid": rid};

		$.ajax({
			url: "${pageContext.request.contextPath}/restBoard/deleteReply"
			, data : paramData
			, type : 'POST'
			, dataType : 'text'
			, success: function(result){
				showReplyList();
			}
			, error: function(error){
				console.log("에러 : " + error);
			}
		});
	}

	
</script>

<style>
.image img{
	max-width: 100%!important;
	height: auto!important;
	display: block;
	margin: 0px auto;
	margin-bottom: 10px;
}

.board_content::after{
	display: block;
	content:"";
	clear: both
}

figure{
	position: relative;
	display: block;
	width: fit-content;
	margin: 0px auto;
}

.image-style-align-left{
	width: auto;
}

.image-style-side{
	width: auto;
}

.image-style-align-left img{
	float: left;
	margin-right: 10px;
}

.image-style-side img{
	float: right;
}

.image-style-align-left figcaption{
	color: #fff;
	background: #666;
	position: absolute;
	left: 0;
	right: unset;
	top: 0;
	bottom: unset;
	opacity: 0;
	box-sizing: border-box;
	padding: 4px;
	transition: .5s;
}

.image-style-side figcaption{
	color: #fff;
	background: #666;
	position: absolute;
	left: unset;
	right: 0;
	top: 0;
	bottom: unset;
	opacity: 0;
	box-sizing: border-box;
	padding: 4px;
	transition: .5s;
}

figcaption{
	color: #fff;
	background: #666;
	position: absolute;
	left: 0;
	right: 0;
	bottom: 0;
	opacity: 0;
	box-sizing: border-box;
	padding: 4px;
	transition: .5s;
	text-align: center;
}

figure:hover > figcaption{
	opacity: .8;
}

.board_line{
	margin:30px;
}
</style>

</head>

<body>
	<article>
		<div class="container" role="main">

			<div class="board_cate">Category > <c:out value="${boardContent.cate_cd}"/></div>

			<div class="bg-white rounded shadow-sm">
				<div class="board_title"><c:out value="${boardContent.title}"/></div>
				
				<div class="board_info_box">
					<span class="board_author"><c:out value="${boardContent.reg_id}"/>&nbsp;&nbsp;&nbsp;&nbsp;|</span><span class="board_date"><c:out value="${boardContent.reg_dt}"/></span>
				</div>
				
				<hr class="board_line">
				
				<div class="board_content">${boardContent.content}</div>
				
				<div class="board_tag">TAG  &nbsp;:&nbsp;&nbsp;<c:out value="${boardContent.tag}"/></div>
			</div>

			<div class="d-grid gap-4 col-3 mx-auto" style="margin-top : 30px">
				<button type="button" class="btn btn-sm btn-primary" id="btnUpdate" style="margin-top: 5px">수정</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnDelete" style="margin-top: 5px">삭제</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList" style="margin-top: 5px">목록</button>
			</div>
			
			<!-- login on admin
			<div class="d-grid gap-4 col-1 mx-auto" style="margin-top : 30px">
				<button type="button" class="btn btn-primary" id="btnList">목록</button>
			</div> -->
			
			<!-- Reply Form {s} -->
			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
				<form:form name="form" id="form" role="form" modelAttribute="replyVO" method="post">
				<form:hidden path="bid" id="bid"/>
				<div class="row">
					<div class="col-sm-10">
						<form:textarea path="content" id="content" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></form:textarea>
					</div>

					<div class="col-sm-2">
						<form:input path="reg_id" class="form-control" id="reg_id" placeholder="댓글 작성자"></form:input>
						<button type="button" class="btn btn-sm btn-primary" id="btnReplySave" style="width: 100%; margin-top: 10px"> 저 장 </button>
					</div>
				</div>
				</form:form>
			</div>
			<!-- Reply Form {e} -->

			<!-- Reply List {s}-->
			<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
				<h6 class="border-bottom pb-2 mb-0">Reply list</h6>
				<div id="replyList"></div>
			</div> 
			<!-- Reply List {e}-->

		</div>
	</article>
</body>
</html>
