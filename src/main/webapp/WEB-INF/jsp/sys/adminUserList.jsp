<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<jsp:include page="../common/head.jsp" />
<style>
/* 	.content {
    	width:70%;
    	display:flex;
	}
	.main_list {
    	width:55%;
	}
	.sp_div {
    	width:5%;
	}
	.detail_area {
    	width:40%;
    	padding-top: 40px;
	}

	#detail_grid {
		width:100%;
	}
	#detail_grid tr th {
    	padding: 10px;
	    border-top: 1px solid rgba(0, 0, 0, 0.15);
	    border-bottom: 1px solid rgba(0, 0, 0, 0.15);
	    border-right: 1px solid rgba(0, 0, 0, 0.3);
	    font-size: 14px;
	    background: #EBEBEB;
	    width: 30%;
	}
	#detail_grid tr td {
	    border-top: 1px solid rgba(0, 0, 0, 0.15);
	    border-bottom: 1px solid rgba(0, 0, 0, 0.15);
	    border-left: 1px solid rgba(0, 0, 0, 0.3);
	    font-size: 14px;
	    width: 70%;
	}
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
	
	input[readonly], input[readonly]:focus {
		border: 0px none;
		cursor: auto;
	} */

</style>
<body class="fixed-header desktop">  
	<jsp:include page="../common/navigation.jsp" />
	<!-- 상단 메뉴 -->
	<div class="page-container">
		<div class="page-content-wrapper">
			<div class="container-fluid">
				<div class="content">
					<div class="main_list">
						<div class="row">
						    <div class="col-md-12">
								<span class="span_title fl">관리자관리 &nbsp;</span>
								<button type="button" class="btn_admin mt-1" onclick="addNewRow()">
									<i class="fa-solid fa-plus"></i> 추가
								</button>
							</div>
							<!-- <div>
								<div class="row mt-3" id="reportTable">
									<div class="col-7">									
									</div>
								</div>
							</div> -->
							
							<!-- 내용 -->
							<div class="col-12">
								<div class="col-7">		
									<table id="grid" class="table">
										<thead>
											<tr>
												<th>아이디</th>
												<th>이름</th>
												<th>권한</th>
												<th>권한명</th>
												<th>사용여부</th>
												<th>생성일시</th>
											</tr>
										</thead>												
									</table>
								</div>
							</div>
						
						<!-- <div class="sp_div" style="width:40px"></div> -->
						<div class="detail_area border py-3 px-4 mt-3 col-7" style="display:none;">
							<div class="card-title mb-4" style="width:100%;">
								<div>
									<span class="span_title" id="detailTitle">사용자 추가</span>						
								</div>
							</div>
							<!-- 내용 -->
							<div>					
								<form id="detailForm" method="post">							
								<table id="detail_grid">
									<tr>
										<th class="pb-3">아이디</th>
										<td><input type="text" class="detail_form" name="userId" readonly/></td>
									</tr>				
									<tr>
										<th class="py-3">비밀번호/변경</th>
										<td><input type="password" class="detail_form" name="userPw"/></td>
									</tr>				
									<tr>
										<th class="py-3">이름</th>
										<td><input type="text" class="detail_form" name="userNm"/></td>
									</tr>
									<tr>
										<th class="py-3">권한</th>
										<td>
											<select class="detail_form" name="userAuth">
											<option value="">선택하세요</option>
											<c:forEach items="${cdList}" var="code">
												<option value="${code.cdCode}">${code.cdTitle1}</option>
											</c:forEach>
											</select>
										</td>
									</tr>
									<tr>
										<th class="py-3">사용여부</th>
										<td>
											<div class="radio">
												<input type="radio" name="useYn" id="useY" value="Y" checked> 
												<label for="useY"> 사용</label>
												<input type="radio" name="useYn" id="useN" value="N" >  
												<label for="useN"> 미사용</label>
											</div>								
										</td>
									</tr>
									<tr id="createDt" style="display:none">
										<th>생성일시</th>
										<td>
											<input type="text" name="inputDatetime" readonly/>
											<input type="text" class="detail_form" name="addYn" value="N" style="display:none;"/>
										</td>
									</tr>
								</table>
								</form>			
							</div>
							
							<div class="pt-3">								
								<button type="button" class="btn_admin" onclick="saveUser()" style="float:right;">
									저장
								</button>
								<button type="button" class="btn_admin bg-secondary" onclick="deleteUser()" style="float:right;">
									삭제
								</button>
							</div>
						</div>						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<jsp:include page="../common/script.jsp" />
<script>
	var table;
	
	table = $("#grid").DataTable({
		  	  paging: false		
			, scrollCollapse: true
			, autoWidth: true
			, ordering: true
			, searching: true
			, select: true
			, destroy: true
			, bInfo: false  
			, ajax: {
				url: "/sys/getUserList",

				dataSrc: function(res) {
	          	return res;
	          }
			}
			, processing: true
	    	, language: {
				processing : "<div id='dt_preloader'><span>Loading...</span></div>",
				sEmptyTable : "데이터가 없습니다."
			}		
			, columns : [
				{ data: "userId"		},
				{ data: "userNm"		},
				{ data: "userAuth"	, visible: true},
				{ data: "userAuthNm"	},
				{ data: "useYn"		, width:"100px", render:function(data){if(data) {return "Y";} else { return "N"; }} },
				{ data: "inputDatetime"	, width:"160px"},
			]
			, columnDefs: [ 
				{ className: "dt-body-left", targets: [0, 1] },
			]

	});
	
	table
	    .on("select", function (e, dt, type, indexes) {
	        var rData = table.rows(indexes).data().toArray()[0];
	        $("input[name='userId']").val(rData.userId);
	        $("input[name='userNm']").val(rData.userNm);
	        $("input[name='userPw']").val("");
	        $("select[name='userAuth']").val(rData.userAuth).prop("selected", true);
	        
	        var useYn = (rData.useYn)? "Y" : "N";
	        $("input[name='useYn'][value='" + useYn + "']").prop("checked", true);
	        $("input[name='inputDatetime']").val(rData.inputDatetime);
	        
	        if(rData.userId != '') {	        	
		        $("input[name='userId']").prop("readonly", true);
		        $("#detailTitle").text("사용자 수정");
		        $("input[name='addYn']").val("N"); 
		        $('#createDt').css('display', '');
	        } else {
		        $("input[name='userId']").prop("readonly", false);
		        $("#detailTitle").text("사용자 추가");	        	
		        $("input[name='addYn']").val("Y"); 
		        $('#createDt').css('display', 'none');
	        }
	        
	        $(".detail_area").show();
	    })
	    .on("deselect", function (e, dt, type, indexes) {
	        var rData = table.rows(indexes).data().toArray()[0];
	        $(".detail_area").hide();
	    });
	
	function addNewRow() {
		if($("input[name='addYn']").val() != "Y") {
			table.rows({selected:true}).deselect();
			var emptyData = {
				'userId': "", 
				'userNm': "", 
				'userAuth': "", 
				'userAuthNm': "", 
				'useYn': true, 
				'inputDatetime': ""
			}			
			table.row.add(emptyData).select().draw(false);
			
			$("input[name='userId']").prop("readonly", false);
			$("#detailTitle").text("사용자 추가");
			$(".detail_area").show();
			
			$("input[name='addYn']").val("Y"); 
		}
	}
	
	function saveUser() {
	   	var regExp = /^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()\-+=<>?/[\]{},.:;]{6,20}$/;

		if(confirm('저장하시겠습니까?')) {			
			var addYn = $("input[name='addYn']").val();
	
			if($('input[name=userId]').val() == '' || $('input[name=userId]').val() == undefined) {
				alert('아이디를 입력해주세요.');
				return;
			}
			if(addYn == "Y" && ($('input[name=userPw]').val() == '' || $('input[name=userPw]').val() == undefined)) {
				alert('비밀번호를 입력해주세요.');
				return;
			}
		   	if($('input[name=userPw]').val() != '' && !(regExp.test($('input[name=userPw]').val()))) {
		   		alert('비밀번호는 영문, 숫자를 포함한 6자리이상 20자리 이하입니다.');
		   		return;
		   	}
			if($('input[name=userNm]').val() == '' || $('input[name=userNm]').val() == undefined) {
				alert('이름을 입력해주세요.');
				return;
			}
			if($('select[name=userAuth]').val() == '' || $('select[name=userAuth]').val() == undefined) {
				alert('권한을 선택해주세요.');
				return;
			}
			
			var url = "/sys/saveUser";
			$.post(url, $("#detailForm").serialize(), function(data, status) {
				if(data.result) {
					alert('저장되었습니다.');
					table.ajax.reload();
					$(".detail_area").hide();
				}
			})
		} else {
			table.ajax.reload();
			$(".detail_area").hide();
		}
	}
	function deleteUser() {
		if(confirm('정말 삭제하시겠습니까?')) {
			var url = "/sys/deleteUser";
			$.post(url, $("#detailForm").serialize(), function(data, status) {
				if(data.result) {
					alert('삭제되었습니다.');
					table.ajax.reload();
					$(".detail_area").hide();
				}
			})
		}
	}
	
</script> 
</body>
</html>

