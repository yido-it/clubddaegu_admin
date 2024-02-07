<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<jsp:include page="./common/head.jsp" />
<body>
<div class="login-wrapper">
	<div class="bg-pic">
		<img src="/img/login_marriott.jpg">
	</div>
	<div class="login-container bg-white">
		<div class="login_form">
            <div class="logo">
                <h4 class="txt_title fl" style="">marriott 관리자</h4>
            </div>

			<form id="form-login" action="/checkLogin" method="post" novalidate="novalidate" >              
                <div class="form-group form-group-default" style="padding:10px 20px 5px 20px;">
					<label class="mt-1">I&nbsp;D&nbsp;</label>
					<input type="text" name="userId" id="userId" placeholder="" class="form-control" required="" aria-required="true" value="${userId}">
				</div>
				<div class="form-group form-group-default"  style="padding:10px 20px 5px 20px;">
					<label class="mt-1">PW</label>
					<input type="password" class="form-control" name="password" id="password" placeholder="" required="" aria-required="true" value="${userPw}">
				</div>
				<div class="form-check icon-check mt-3 pl-1">
                       <input class="" type="checkbox" name="rememberMe" id="rememberMe">
                       <label class="" for="rememberMe" style="font-size:18px;">자동로그인</label>
                   </div>
				<div class="row">
					<div class="col-12">
						<div type="button" class="mt-3 btn btn-wine colorwhite btn-lg btn-block btn-next" id="loginSubmit">확인</div>
					</div>
				</div>
			</form>


		</div>
	</div>

</div>
	<jsp:include page="./common/script.jsp" />
</body>
<style>

@media (max-width: 768px){ 
	.m-col{display:block;}
	.col-left{ 
		display:none; 
	} 

	.form-group{
		flex-direction: unset;
		-moz-flex-direction: unset;
		-webkit-flex-direction: unset;
		-o-flex-direction: unset;
		-ms-flex-direction: unset;
	}
	.col-right{margin-top:-100px!important;}
} 

@media (min-width: 768px){ 
	.m-col{display:none;}
}

.login_wrap{
	width: 496px;
	display: block;
	position: relative;
	float: right;
}

.login_form{
	margin:50px;
}

.txt_title{
	color:#a31111;font-size:26px ;font-weight:bold;margin-top:10px;letter-spacing: -1px; 
}

.container{
	height: 100%;
	align-content: center;
}

</style>
<script>
	if('${sessionScope.session}' != '') {
		location.href = '/'
	}
	$("#loginSubmit").on("click", function(){
	    var flag = true;
	    $("#form-login input").each(function(){
			if(this.id != 'rememberMe' && $(this).val() == "") {
				console.log(this.id);
				alert("아이디 / 비밀번호를 입력해 주세요.");
				flag = false;
				return false;
			}
	    })
	    if(flag) $("#form-login").submit();
	})
	
	var error = "${errorMessage}";
	console.log(error);
	// alert(error);
	
	$('#password').on('keyup', function(e){
		if(e.keyCode == 13) $('#loginSubmit').trigger('click');
	});
</script>	
</html>