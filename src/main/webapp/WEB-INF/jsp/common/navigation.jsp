<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<style>
	input, select {
		font-family: "Noto Sans KR", "Noto Sans Korean", Malgun Gothic, "맑은고딕", arial, sans-serif;
		font-weight: normal;
		font-size: 14px;
		margin-left: 5px;
		width: 80%;
		padding: 2px 10px;
		height: 30px;
		border: 1px solid rgba(0, 0, 0, 0.3);
		border-radius: 5px;
	}
	
	.loading{
	    width: 100%;
	    height: 100%;
	    border: 1px solid #bababa;
	    border-radius: 10px;
	    padding: 0;
	    z-index: 99999;
	    position: fixed;
	    margin: 0;
	    top: 0;
	    background-color: #0000007d;
	    left: 0;
	    text-align: center;
	}
</style>
<script src="/js/jquery.min.js"></script>
<script>
$(document).ready(function(){
	// 크기로 구분 
	if(window.innerWidth <= 768) {
	    //
	} else {
		
	    // body 에 'menu-pin' class 추가 
	    $('body').addClass('menu-pin');
	    
	    // 'nav-menu' class close -> open 변경 
	    $('#nav-menu').removeClass('close').addClass('open');
	    // transform 변경 
	    $('#nav-menu').css('transform', 'translate3d(210px, 0px, 0px)');
	    
	    
	}
});
</script>
<div class="header"> 
	<div class=""> 
		<div class="inline" style="width:230px;">
            <div class="nav-link side_open fl close" id="nav-menu" style="cursor:pointer;margin-left:20px;margin-top:5px;" >
            	 <i class="fas fa-stream"></i>
           	</div> 
		</div>
	</div> 
	<div class="d-flex align-items-center"> 
	    <div class="main_brandlogo">  
<!-- 	    	<img src="/img/toplogo1.png" style="max-width:111px;max-height:46px;" onerror="this.style='display:none;'" alt="logo"/> -->
		</div>
	</div>
	<div>
		<a href="/logout">
			<i class="fa-solid fa-power-off"></i>
		</a>
	</div>
</div>
<nav class="page-sidebar" data-pages="sidebar">
	<div class="sidebar-overlay-slide from-top" id="appMenu">
	
		<div class="row">
			<div class="col-xs-6 no-padding"></div>
			<div class="col-xs-6 no-padding"></div>
		</div>
		<div class="row">
			<div class="col-xs-6 m-t-20 no-padding"></div>
			<div class="col-xs-6 m-t-20 no-padding"></div>
		</div>
	</div>
	<div class="sidebar-header" style="text-align: center;"><p>클럽디 대구 메리어트</div>
	<div class="sidebar-menu">
		<div class="user-panel">
			<div class="pull-left image">
			</div>
		</div>
		<ul class="menu-items" style="margin-top:30px;">
			
			<c:if test="${sessionScope.session.userAuth == 'ATH100' || sessionScope.session.userAuth == 'ATH200' || sessionScope.session.userAuth == 'ATH300' || sessionScope.session.userAuth == 'ATH400' || sessionScope.session.userAuth == 'ATH600'}">	 
			<li>
	        	<a href="/report/dailySales">
	            	<span class="title">일 매출 리포트</span>
	            </a>
	        </li>
	        </c:if>
	        
			
            <c:if test="${sessionScope.session.userAuth == 'ATH100' || sessionScope.session.userAuth == 'ATH200' }">
            <li>
                <a href="#">
                    <span class="title">시스템 관리</span>
                    <span class="arrow"></span>
                </a>
                <ul class="sub-menu">
                	<c:if test="${sessionScope.session.userAuth == 'ATH100'}">
                    <li class="nav-item" id="">
                        <a href="/sys/adminUser">- 관리자 관리</a>
                    </li>
                    </c:if>
                    <li class="nav-item" id="">
                        <a href="/sys/adminSms">- 관리자 수신 관리</a>
                    </li>
           
                </ul>
            </li>
            </c:if>
   
		</ul>	
	</div>	
</nav>

