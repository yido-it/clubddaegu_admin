<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<jsp:include page="common/head.jsp" />
<script src="https://cdn.amcharts.com/lib/4/core.js"></script>
<script src="https://cdn.amcharts.com/lib/4/charts.js"></script>
<script src="https://cdn.amcharts.com/lib/4/themes/animated.js"></script>
<body class="fixed-header desktop">  
	<jsp:include page="common/navigation.jsp" />	
	<jsp:include page="common/script.jsp" /> 
</body>
<script>
	var el = $('.sidebar-menu > .menu-items li:first');
	var url;
	
	if(el.find('.sub-menu').length > 0) {
		el = el.find('.sub-menu li:first > a');
	} else {
		el = el.find('a');
	}
	
	url = el.attr('href');
	location.href = url;
</script>
</html>

