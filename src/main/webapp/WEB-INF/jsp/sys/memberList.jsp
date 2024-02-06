<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<jsp:include page="../common/head.jsp" />
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
 
<body class="fixed-header desktop">   
	<jsp:include page="../common/navigation.jsp" />
	<div class="page-container">
		<div class="page-content-wrapper">
			<div class="container-fluid">
				<div class="content">
			 
					<div> 
						<div class="row mt-5" style="display:flex;">
							<div class="col-12">
								<h5>회원관리</h5>  
							</div>
						</div>
											 
						<div class="row mt-3">		
							<div class="col-2">
								<div class="form-group row"> 
									<label class="col-2 col-form-label">아이디</label>
									<div class="col-9">
										<input type="text" class="form-control form-control-sm" id="mbId" onkeyup="enterkey()"/>
									</div>
									
								</div>
							</div>	
							
							<div class="col-2">
								<div class="form-group row">
									<label class="col-2 col-form-label">이름</label>
									<div class="col-9">
										<input type="text" class="form-control form-control-sm" id="mbName" onkeyup="enterkey()"/>
									</div>
								</div>
							</div>	
							
							<div class="col-2">
								<div class="form-group row">
									<label class="col-3 col-form-label">핸드폰번호</label>
									<div class="col-9">
										<input type="text" class="form-control form-control-sm" id="hpNo" onkeyup="enterkey()"/>
									</div>
								</div>
							</div>	
							
							<!-- <div class="col-2">
								<div class="form-group row">
									<label class="col-3 col-form-label">상태</label>
									<div class="col-9">
									<select class="form-select form-control" id="status">
										<option value="A" selected>전체</option>
										<option value="B">유지</option>
										<option value="C">탈퇴</option>
									</select> 
									</div>
								</div>
							</div> -->	
							<div class="col-2">
								<div class="row">
									<div class="col-6">
										<button type="button" class="btn btn-primary" style="width:100%" onClick="getTicketList()">검색</button>  			
									</div>
								</div>
							</div>	
						</div>
			
						<div class="row mt-3">		
							<div class="col-12"> 
								<table id='memGrid' class="" style="width:100%">
									<thead>
										<tr id='tkTr'> 
								         	<th>아이디</th>  
								         	<th>생년월일</th>  
								         	<th>이름</th>
								         	<th>핸드폰번호</th>   
								         	<th>가입날짜</th>    
								         	<th>가입경로</th>
								         	<th>회원탈퇴</th>								         	
										</tr>
							     	</thead>
								</table>
							</div>
						</div>
						
						<br/><br/>
					</div> 
				</div> 
			</div>
		</div>

	</div>
</body>
<jsp:include page="../common/script.jsp" />
<jsp:include page="../common/modal.jsp" />
<script>

var table;
var cols = [];

$(document).ready(function() {
	$('#mbName').val('0');
	getTicketList();
	$('#mbName').val('');
});


/* $("#strtDt, #endDt").flatpickr({
	defaultDate: "today" 
	, locale: 'ko'
}); */


/* function doSearch() {
	let strtDt	= $('#strtDt').val();
	let endDt 	= $('#endDt').val();
	
	if (strtDt == '' || endDt == '') {
		alert('검색일자를 선택해주세요.');
		return false;
	}
	
	if (endDt < strtDt) {
		alert('종료일이 시작일보다 작을 수 없습니다.');
		return false;
	}
	
	let stDate = new Date(strtDt.substr(0, 4), strtDt.substr(5, 2), strtDt.substr(8, 2));
	let endDate = new Date(endDt.substr(0, 4), endDt.substr(5, 2), endDt.substr(8, 2));
	
	var btMs = endDate.getTime() - stDate.getTime();
	var btDay = btMs / (1000*60*60*24);
	
	if (btDay > 31) {
		alert('조회기간은 최대 1달입니다.');
		return false;
	}
	
	table.ajax.reload();
	table.columns.adjust().draw();
} */



//회원탈퇴버튼



var setDelete = function(data, type, row, meta) {
	return '<button class="btn btn-primary" onClick="deleteMember(\''+row.mbNo+'\',\''+row.msLoginCd+'\')">회원탈퇴</button>';
}

// 전화번호
var setHpNo = function(data, type, row, meta) {
	if (data) {
        return data.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`);
    } else {
        return ''; // 또는 원하는 기본값으로 변경 가능
    }
}

//kakao,naver 로그인시 아이디 -> 이메일로 변경
function customDataRenderer(data, type, row) {
    if (row.msLoginCd === 'NAVER' || row.msLoginCd === 'KAKAO') {
        // msLoginCd 값이 'NAVER' 또는 'KAKAO'인 경우 이메일 주소 반환
        return row.msEmail;
    } else {
        // 그 외의 경우 mbId 값을 반환
        return data;
    }
}


function enterkey() {
	if (window.event.keyCode == 13) getTicketList();
}

function getTicketList() {
	
	if($('#mbName').val()=='' && $('#hpNo').val()=='' &&$('#mbId').val()==''){
		alert('검색 정보 입력해주세요');
		return;
	}
	
	
	var	table = $("#memGrid").DataTable({
		  	paging: false		
			, scrollCollapse: true
			, autoWidth: false
			, ordering: true
			, searching: false
			, select: true
			, destroy: true
			, bInfo: false  
		, ajax: {
			url: "/sys/getMemberList",
			data: function(data) {
				data.mbName = $('#mbName').val(); 
				data.hpNo = $('#hpNo').val().replaceAll('-', ''); 
				data.mbId = $('#mbId').val(); 
			},
			dataSrc: function(res) {
	    	return res;
	    }
		}
		, processing: true
		, language: {
			processing : "<div id='dt_preloader'><span>Loading...</span></div>",
			sEmptyTable : "데이터가 없습니다."
		}		
		, columns: [  
			{ data : "mbId" ,render: customDataRenderer},
			{ data : "birthDate"},
			{ data : "mbName" },
			{ data : "hpNo" ,render:setHpNo},
			{ data : "regiDate" },
			{ data : "msLoginCd" },
			{ data : "" ,render:setDelete},
		]
		

	});	
	
}



/*회원 탈퇴 */

var kakao_key = "${Globals.KakaoKey}";



Kakao.init(kakao_key);

function deleteMember(mbNo,msLoginCd){
	getMyTicketList(mbNo,msLoginCd);
}
 

//탈퇴시 예약내역 확인
function getMyTicketList(mbNo,msLoginCd) {
		$.ajax({
			url: "/sys/selectTicketList" 
			, type: "post"
			, dataType: 'json'
			, data :  {
				mbNo: mbNo,
				msLoginCd:msLoginCd,
				}
			, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
			, success: function(data) {
				 if(data.result){
		            /* if(data.rowCnt > 0)	{		            	
		            	alert('완료되지 않은 예약내역이 있습니다.');
		            	return;
		            } else { */
		            	confirmDeleteMember(mbNo,msLoginCd);
		            /* } */
	            } else {
	            	alert(data.message);
	            }         
			}
		});
	}

 
function confirmDeleteMember(mbNo,msLoginCd) {
	if(confirm('회원을 탈퇴하시겠습니까?')) {	
		removeMember(mbNo,msLoginCd);
	}
}

//회원탈퇴
function removeMember(mbNo,msLoginCd) {		
	/* if(msLoginCd == "KAKAO") {
		alert('KAKAO는 탈퇴를 진행할수 없습니다.');
		return;
	} else if (msLoginCd == "NAVER") {
		alert('NAVER는 탈퇴를 진행할수 없습니다.');
		return;
	} */
	
    $.ajax({
          url: "/sys/removeMember"
        , type: "post"
        , dataType: 'json'
        , data: {mbNo: mbNo}
        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
        , success: function(data) {
            if(data.result){

	            alert('탈퇴가 완료되었습니다.');

            } else {
            	alert(data.message);                    
            }                
        }
        , error: function(data) {
        	alert('[error] 오류가 발생했습니다.');
        }
    });		
}





</script>

<style>

body, table, .form-control, .btn { 
	font-size: 13px; 
}

.dataTables_filter > label { 
	font-size: 13px !important; 
}

.dataTables_wrapper .dataTables_paginate>a, .dataTables_wrapper .dataTables_paginate>span>a { 
	font-size: 13px !important; 
}

.dataTables_wrapper .dataTables_scroll div.dataTables_scrollHead .dataTables_scrollHeadInner>table>thead>tr>th  {
	font-size: 11px !important;
	width:200px;
}
.dataTables_wrapper .dataTables_scroll div.dataTables_scrollBody>table>tbody>tr>td  {
	font-size: 11px !important;
	width:200px;
}

tr#tkTr th:last-child {
    width: 120px !important;
    text-align: center;
 
} 

 tr#tkTr th:first-child {
    width: 350px;
} 
</style>
</html>

	