<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<script>
	$(document).on('click', '#btnSignup', function(e){
		if($('#uid').val()==""|| $('#name').val()=="" || $('#pwd1').val()=="" || $('#pwd2').val()=="" || $('#email').val()==""){
			alert("Please enter all fields")
		}else{
			e.preventDefault();
			$("#form").submit();
		}
	});
	
	$(document).on('click', '#btnCancel', function(e){ 
		e.preventDefault();
		$('#uid').val('');
		$('#name').val('');
		$('#pwd1').val('');
		$('#pwd2').val('');
		$('#email').val('');
		location.href="${pageContext.request.contextPath}/board/getBoardList";
	});
	
</script>

<article>
	<div class="container col-md-6 my-3" role="main"> 
		<div class="card"> 
			<div class="card-header">Register</div> 
			<div class="card-body"> 
				<form:form name="form" id="form" class="form-signup" role="form" modelAttribute="userVO" method="post" action="${pageContext.request.contextPath}/user/insertUser"> 
					<div class="form-group row"> 
						<label for="uid" class="col-md-3 col-form-label text-md-right">ID</label>
						<div class="col-md-5">
							<form:input path="uid" id="uid" class="form-control" placeholder="Please enter the ID" />
						</div> 
					</div> 
					
					<div class="form-group row"> 
						<label for="name" class="col-md-3 col-form-label text-md-right">Name</label>
						<div class="col-md-5"> 
							<form:input path="name" id="name" class="form-control" placeholder="Please enter your name" /> 
						</div> 
					</div> 
					
					<div class="form-group row"> 
						<label for="pwd" class="col-md-3 col-form-label text-md-right">Password</label> 
						<div class="col-md-5"> 
							<form:password path="pwd" id="pwd" class="form-control" placeholder="Please enter the password" /> 
						</div> 
					</div> 
					
					<div class="form-group row"> 
						<label for="re_pwd" class="col-md-3 col-form-label text-md-right">Password Check</label> 
						<div class="col-md-5"> 
							<form:password path="re_pwd" id="re_pwd" class="form-control" placeholder="Please enter the password" /> 
						</div> 
					</div> 
					
					<div class="form-group row"> 
						<label for="email" class="col-md-3 col-form-label text-md-right">E-mail</label> 
						<div class="input-group col-md-7"> 
							<div class="input-group-prepend"> 
								<span class="input-group-text">@</span> 
							</div> 
							<form:input path="email" id="email" class="form-control" placeholder="Please enter your e-mail" /> 
						</div> 
					</div> 
				</form:form> 
			</div> 
		</div> 
		
		<div style="margin-top:10px"> 
			<button type="button" class="btn btn-sm btn-primary" id="btnSignup">Signup</button>
			<button type="button" class="btn btn-sm btn-primary" id="btnCancel">Cancel</button> 
		</div> 
	</div> 
</article>
