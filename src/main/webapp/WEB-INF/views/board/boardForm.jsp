<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib prefix="form" uri = "http://www.springframework.org/tags/form" %> 

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script src="https://cdn.ckeditor.com/ckeditor5/24.0.0/classic/ckeditor.js"></script>


<c:url var="getMenuListURL" value="/restMenu/getMenuList"></c:url>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">
<style>
.ck-editor__editable{
	min-height: 300px;
}
</style>
<title>board</title>

<script>
	var contentEditor;
	
	$(document).on('click', '#btnSave', function(e){
		e.preventDefault();
		if ($("#title").val() == "" || contentEditor.getData()==""){
			alert("내용을 입력해주세요.");
		}
		else{
			$("#form").submit();
			
		}
		
	});

	$(document).on('click', '#btnList', function(e){
		e.preventDefault();
		location.href="${pageContext.request.contextPath}/board/getBoardList?category="+'<c:out value="${boardContent.cate_cd}"/>';
	});
	
	$(document).ready(function(){
		
		var mode = '<c:out value="${mode}"/>';
		
	    ClassicEditor
        	.create( document.querySelector( '#content' ),{
        		alignment:{
        			options: ['left', 'center', 'right']
        		},
        		image : {
        				toolbar: ['imageTextAlternative','imageStyle:alignLeft', 'imageStyle:full', 'imageStyle:side'],
        				styles: ['full', 'alignLeft','alignRight', 'side']
        		},
        		ckfinder: {
        			uploadUrl: '/restBoard/fileUpload'
        		}
        	} )
        	.then ( editor => {
        		contentEditor = editor;
        		if(mode == 'edit'){
    
        			//몇시간을 헤맸는지... Ckeditor 문제가 아니라 c:out 자체 문제였다
        			//XSS 방지 위해 자동으로 < > 얘네들 바꿔줘서 생기는 문제...
        			var content = '<c:out value="${boardContent.content}" escapeXml="false"/>';
        			contentEditor.setData(content);
        		}
        		console.log(contentEditor);
        	})
       	 	.catch( error => {
            	console.error( error );
       		 } );

	    
		
		if ( mode == 'edit'){
			//입력 폼 셋팅
			$("#reg_id").prop('readonly', true);
			
			$("input:hidden[name='bid']").val(<c:out value="${boardContent.bid}"/>);
			$("input:hidden[name='mode']").val('<c:out value="${mode}"/>');
			
			$("#reg_id").val('<c:out value="${boardContent.reg_id}"/>');
			$("#title").val('<c:out value="${boardContent.title}"/>');
			
			$("#tag").val('<c:out value="${boardContent.tag}"/>');
			
			$("select[name='category']").find("option[value='<c:out value="${boardContent.cate_cd}"/>']").attr("selected", true);
		}
	});

</script>


</head>

<body>
	<article>
		<div class="container" role="main">

			<h2 class="board_cate">Board Form</h2>

			<form:form name="form" id="form" role="form" modelAttribute="boardVO" method="post" action="${pageContext.request.contextPath}/board/saveBoard">
				<form:hidden path="bid"/>
				<input type="hidden" name="mode"/>
				
				<div class="mb-3">
					<label for="cate_cd">카테고리</label>
					<form:select path="cate_cd" class="form-control form-control-sm" name="category" id="category">
						<c:forEach items="${categoryList}" var="category">
							<form:option value="${category.code}" label="${category.codename}"/>
						</c:forEach>
					</form:select>
				</div>
				
				<div class="mb-3">
					<label for="title">제목</label>
					<form:input path="title" id="title" class="form-control" placeholder="제목을 입력해 주세요"/>
				</div>

				<div class="mb-3">
					<label for="reg_id">작성자</label>
					<form:input path="reg_id" id="reg_id" class="form-control" placeholder="이름을 입력해 주세요"/>
				</div>

				<div class="mb-3">
					<label for="content">내용</label>
					<form:textarea path="content" id="content" class="form-control" rows="10" placeholder="내용을 입력해 주세요" />
				</div>

				<div class="mb-3">
					<label for="tag">TAG</label>
					<form:input path="tag" id="tag" class="form-control" placeholder="태그를 입력해 주세요"/>
				</div>

			</form:form>
			<div >
				<button type="button" class="btn btn-sm btn-primary" id="btnSave">저장</button>
				<button type="button" class="btn btn-sm btn-primary" id="btnList">목록</button>
			</div>
		</div>
	</article>
	</body>
</html>

