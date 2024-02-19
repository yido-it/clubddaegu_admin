<!-- 모달 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!-- 처리중입니다 -->
<div class="modal fade" id="loadingModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" style="width: 20%;">
		<div class="modal-content">
			<div class="modal-body text-center pt-5">				
				<div class="spinner-border color-highlight" style="border: 6px solid #f2f2f2;border-top: 6px solid #ff7600;" role="status"></div>
   				 <span class="fs18" style="display: block;"> 처리중입니다. <BR/> 잠시만 기다려주세요. </span>
			</div>
		</div>
	</div>
</div>
          
<script>

function openModal(modalName) {
	$('#'+modalName).addClass('menu-active show bgDarkly');
	$('#'+modalName).css('display', 'block');
}

function closeModal(modalName) {
	$('#'+modalName).removeClass('menu-active show bgDarkly');
	$('#'+modalName).css('display', 'none');
}

</script>
<style>
.bgDarkly {
	background-color: rgba( 0, 0, 0, 0.5 );
}
</style>