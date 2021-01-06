<c:url var="getMenuListURL" value="/restMenu/getMenuList"></c:url>

<script type="text/javascript">

	$(function(){
		fn_CateList();
	});
	
	function fn_CateList(){
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
						var htmls = '<li><a class="dropdown-item" href="#" onClick="fn_goToCate(\'all\')">All Posts</a></li>';
						result.menuList.forEach(function(e) {
							htmls += '<li><a class="dropdown-item" href="#" onClick="fn_goToCate('+'\''+e.code+'\''+')">'+e.code+'</a></li>';
							
						});
						htmls += '<li><hr class="dropdown-divider"></li>';
						htmls += '<li><a class="dropdown-item" href="#">Visitor\'s book</a></li>'
					}
				} else {
					console.log("fail to get information");
				}
				
				$('#cateList').html(htmls);
			}
		});
	}
	
	function fn_goToCate(category){
		var url = "${pageContext.request.contextPath}/board/getBoardList/?category="+category;
		location.href = url;
	}
	
	function fn_goToSuffix(suffix){
		var url = "${pageContext.request.contextPath}/"+suffix;
		location.href = url;
	}

</script>

<style>
.bd-navbar {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  z-index: 10000;
  min-height: 4rem;
  box-shadow: 0 0.5rem 1rem rgba(0,0,0,.05), inset 0 -1px 0 rgba(0,0,0,.1);
}

.btn-outline-success{
	color: #9DC3C1;
	border-color: #9DC3C1;
}

.btn-outline-success:hover{
	color: #fff;
	background-color:#9DC3C1; 
	border-color: #9DC3C1;

}
</style>

<!--NAVBAR-->

<nav class="navbar bd-navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#" onClick="fn_goToSuffix('home')">JINY.COM</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav mr-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#" onClick="fn_goToSuffix('home')">Home</a>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            Category
          </a>
          <ul class="dropdown-menu" id="cateList" aria-labelledby="navbarDropdown">
            
          </ul>
        </li>
       
      </ul>
      <form class="d-flex">
        <input class="form-control mr-2" type="search" placeholder="Search" aria-label="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
      
       <ul class="navbar-nav ml-2 mb-1 mb-lg-0">
       		<!-- show when user is without login -->
	       <li class="nav-item">
	          <a class="nav-link" aria-current="page" href="#" onClick="fn_goToSuffix('login/login')">Login</a>
	        </li>
	        
	        <li class="nav-item">
	          <a class="nav-link" aria-current="page" href="#" onClick="fn_goToSuffix('login/signupForm')">SignUp</a>
	        </li>
	        
	        <!-- show the user's name to logged-in user -->
	        
	        <!-- show Admin tab to administrator-->
	        <li class="nav-item dropdown">
		          <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
		            Admin
		          </a>
		          <ul class="dropdown-menu" id="cateList" aria-labelledby="navbarDropdown">
		            <li><a class="dropdown-item" href="#" onClick="fn_goToSuffix('menu/getMenu')">Categories</a></li>
		             <li><a class="dropdown-item" href="#" onClick="fn_goToSuffix('user/getUserList')">Users</a></li>
		          </ul>
        	</li>
        </ul>
       
    </div>
  </div>
</nav>
