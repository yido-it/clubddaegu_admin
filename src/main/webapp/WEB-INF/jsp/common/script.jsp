<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<%@ page import="java.util.Date" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<spring:eval expression="@GlobalProperties.getProperty('Globals.Root.Path')" var="rootPath"/>
<div class="sidebar-overlay" id="sidebar-overlay"></div>
<div id="preloader"></div>

<script src="/js/jquery.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script src="/js/bootstrap.bundle.min.js"></script><!--부트스트랩-->
<script src="/js/jquery.easing.min.js"></script><!--움직임-->
<script src="/js/jquery.scrollbar.min.js"></script>

<script src="/js/owl.carousel.js"></script><!--슬라이드-->
<script src="/js/aos.js"></script><!--스크롤-->
<script src="/js/mobilegnb.js?now=<%=new Date()%>"></script><!--모바일-->
<script src="/js/swiper.js"></script>

<!-- 날짜 관련 라이브러리 -->
<script type="text/javascript" src="/js/moment.min.js"></script>
<script type="text/javascript" src="/js/modernizr.custom.js" ></script>
<script type="text/javascript" src="/js/pages.min.js"></script>
<script type="text/javascript" src="/js/dropzone.min.js"></script>

<!-- date picker -->
<script src="/js/flatpickr/flatpickr.min.js"></script>
<script src="/js/flatpickr/ko.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr@latest/dist/plugins/monthSelect/index.js"></script>

<script src="/js/main.js?now=<%=new Date()%>"></script>
<script src="/js/tools.js?now=<%=new Date()%>"></script>

<script src="/datatables/datatables.min.js"></script>
<script src="https://cdn.datatables.net/select/1.3.3/js/dataTables.select.min.js"></script>
<script src="/tabulator/tabulator.min.js"></script>
<script src="https://cdn.datatables.net/rowgroup/1.4.0/js/dataTables.rowGroup.min.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/dataTables.buttons.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.10.1/jszip.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
<script src="https://cdn.datatables.net/buttons/2.4.1/js/buttons.html5.min.js"></script>

<script src="/js/sweetalert2.min.js"></script>

<script> 
</script>

<!--스크립트 스크롤 색상변경 -->
<script>
	
	function preloadImage(img) {
	  const src = img.getAttribute('data-src');
	  if (!src) { return; }
	  img.src = src;
	}
	
	$(".side_open").click( function() {
// 		$(".page-sidebar").css( 'transform', 'translate3d(210px, 0px, 0px)' );
		if($(this).hasClass("open")){
	   		$("body").removeClass("menu-pin");
	   		$(this).removeClass("open").addClass("close");
	   		$(this).css('transform', 'translate3d(0px, 0px, 0px)' );
	   		$(".page-sidebar").css( 'transform', 'translate3d(0px, 0px, 0px)' );
       	}else{
	   		$("body").addClass("menu-pin");
			$(this).removeClass("close").addClass("open");
	   		$(this).css('transform', 'translate3d(210px, 0px, 0px)' );
	   		$(".page-sidebar").css( 'transform', 'translate3d(210px, 0px, 0px)' );
       	}
    });

	function checkLogout() {
		if(confirm('로그아웃 하시겠습니까?')){
			location.href="/succ-logout"	
		}
	}
	$(".sidebar-overlay").on("click", function(){
	    $(".nav-link").trigger("click");
	})
	
</script>


 
 
 