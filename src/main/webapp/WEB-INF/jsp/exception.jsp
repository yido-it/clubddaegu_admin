<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%--
  Created by IntelliJ IDEA.
  User: KIMKT
  Date: 2017-05-10
  Time: 오전 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<jsp:include page="./common/head.jsp"/>
<body>
<div class="wrapper">
    <div class="main-panel">
   		<div class="content">
			<div class="container-fluid">
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript">
	var message = "${message}";
	
	if (message == ""){
	    	alert("알수 없는 오류가 발생했습니다.");
	} else{
	    alert("${message}");
	    back("${message}");
	}

    function back(data){
    	console.log(data);
    	if(data){
    		window.history.back();
    	}
    }
</script>
</html>
