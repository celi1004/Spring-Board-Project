<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<c:url var="saveURL" value="/restMenu/saveMenu"></c:url>
<c:url var="deleteURL" value="/restMenu/deleteMenu"></c:url>
<c:url var="updateURL" value="/restMenu/updateMenu"></c:url>
<c:url var="getMenuListURL" value="/restMenu/getMenuList"></c:url>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Menu List</title>

<script>
	$(function(){
		fn_showList();
	});
	
	function fn_showList(){
		var paramData = {};
		
		$.ajax({
			url : "${getMenuListURL}" 
			, type : "POST"
			, dataType : "json"
			, data : paramData
			, success : function(result){ 
				console.log(result); 
				
				if (result.status == "OK"){ 
					if ( result.menuList.length > 0 ) {
						var list = result.menuList;
						var htmls = "";
						result.menuList.forEach(function(e) {
							htmls += '<tr>';
							htmls += '<td>'; 
							htmls += '<a href="#" onClick="fn_menuInfo( '+'\'' + e.code +'\',' + e.sort_num + ', \''+ e.reg_dt+ '\',\'' + e.comment + '\')" >'; 
							htmls += e.code; 
							htmls += '</a>'; 
							htmls += '</td>';
							htmls += '<td>' + e.sort_num + '</td>';
							htmls += '<td>' + e.reg_dt + '</td>';
							htmls += '<td>' + e.comment + '</td>';
							htmls += '</tr>';
						});
					}
				} else {
					console.log("조회실패");
				}
				
				$('#menuList').html(htmls);
			}
		});
	}
	
	$(document).on('click', '#btnSave', function(e){
		e.preventDefault();
		var url = "${saveURL}";
	
		if ($("#code").is("[readonly]") == true) { var url = "${updateURL}"; }

		var paramData = { "code" : $("#code").val() , "sort_num" : $("#sort_num").val() , "reg_dt": $("reg_dt").val(), "comment" : $("#comment").val() };
		
		$.ajax({
			url : url
			, type : "POST"
			, dataType : "json"
			, data : paramData
			, success : function(result){
				fn_showList();
				
	
				$("#btnInit").trigger("click");
				location.reload();
			}
		});
	});
	
	$(document).on('click', '#btnInit', function(e){
		$('#code').val(''); 
		$('#sort_num').val('');
		$('#reg_id').val('');
		$('#comment').val('');
		
		$("#code").attr("readonly", false); 
	});
	
	//setting menu infomation
	function fn_menuInfo(code, sort_num, reg_dt, comment) {  
		$("#code").val(code);
		$("#sort_num").val(sort_num); 
		$("#reg_dt").val(reg_dt);
		$("#comment").val(comment);
		
		//코드 부분 읽기 모드로 전환
		$("#code").attr("readonly", true); 
	}

	$(document).on('click', '#btnDelete', function(e){
		e.preventDefault();
		
		if ($("#code").val() == "") {
			alert("삭제할 코드를 선택해 주세요."); 
			return;
		}
		
		var url = "${deleteURL}"; 
		var paramData = { "code" : $("#code").val() };
		
		$.ajax({
			url : url
			, type : "POST"
			, dataType : "json"
			, data : paramData 
			, success : function(result){
				fn_showList(); 
				
				//삭제 후 셋팅값 초기 
				$("#btnInit").trigger("click");
				location.reload();
			}
		});
	});

</script>


<style>
	#paginationBox{ padding : 10px 0px; }
	
	.form-control:focus{
		border-color: #ABD0CE;
		box-shadow: 0 0 0 0.2rem rgba(171,208,206,0.6);
	}
</style>

</head>

<body>
<article>
	<div class="container">
	
	<!-- Menu form {s} -->
	<h4 class="mb-3 board_cate">Create Category</h4>
	<div class="bg-white rounded shadow-sm" style="margin-bottom:20px;">
		<form:form name="form" id="form" role="form" modelAttribute="menuVO" method="post" action="${pageContext.request.contextPath}/menu/saveMenu">
			<form:hidden path="mid" id="mid"/>
			<div class="row">
				<div class="col-md-4 mb-3 ml-3 mr-3">
					<label for="code">Code</label>
					<form:input path="code" id="code" class="form-control" placeholder="" value="" required="" /> 
					<div class="invalid-feedback"> Valid Code is required. </div>
				</div>
			
				
				<div class="col-md-3 mb-3 ml-3 mr-3">
					<label for="sort_num">Sort</label>
					<form:input path="sort_num" class="form-control" id="sort_num" placeholder="" required="" />
				</div>
			</div>
			
			<div class="row">
				<div class="col-md-9 mb-3 ml-3 mr-3">
					<label for="comment">Comment</label>
					<form:input path="comment" class="form-control" id="comment" placeholder="" value="" required="" />
				</div>
			</div>
		</form:form>
	</div>
	<!-- Menu form {e} -->
	
	<div class="d-grid gap-2 d-md-flex justify-content-md-end">
		<button type="button" class="btn btn-sm btn-primary me-md-4" id="btnSave">Save</button>
		<button type="button" class="btn btn-sm btn-primary me-md-2 ml-2" id="btnDelete">Delete</button>
		<button type="button" class="btn btn-sm btn-primary ml-2" id="btnInit">Reset</button>
	</div>
	
	<h4 class="mb-3 board_cate" style="padding-top:15px">Category List</h4>
	
	<!-- List{s} -->
	<div class="table-responsive">
		<table class="table table-sm" style="text-align:center;">
			<colgroup>
				<col style="width:10%; " />
				<col style="width:20%;" />
				<col style="width:25%;" />
				<col style="width:auto;" />
			</colgroup>
			
			<thead>
			<tr>
				<th>code</th>
				<th>sort</th>
				<th>creation time</th>
				<th>command</th>
			</tr>
			</thead> 
			
			<tbody id="menuList"></tbody>
			
		</table>
	</div>
	<!-- List{e} -->
	
	</div>
</article>
</body>
</html>
