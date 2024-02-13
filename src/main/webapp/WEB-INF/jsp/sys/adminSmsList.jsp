<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<jsp:include page="../common/head.jsp" />
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
								<span class="span_title fl">관리자 수신 관리 &nbsp;</span>
								<button type="button" class="btn_admin mt-1" onclick="addNewRow()">
									<i class="fa-solid fa-plus"></i> 추가
								</button>
							</div>
						</div>
						<!-- <div>
							<div class="row mt-3" id="reportTable">
								<div class="col-7">
									
								</div>
							</div>
						</div> -->
						
						<!-- 테이블 -->
						<div>
							<div class="row mt-3">
								<div class="col-7">						
									<table id='grid' style='width:100%;height:'>
										<thead>
											<tr>    
									         	<th>순번</th>      	
									         	<th>이름</th>      	
									         	<th>전화번호</th>
									         	<th>사용여부</th>
									         	<th></th>
									         	<th></th>
											</tr>
								     	</thead>
									</table>
								</div>
								<!-- hidden area -->
								<input type="hidden" id="seq"/>
								<input type="hidden" id="preName"/>
								<input type="hidden" id="prePhoneNum"/>
								<input type="hidden" id="preUseyn"/>
							</div>
						</div>
					</div>
					
					
					<div class="detail_area" style="display:none;">
						<div class="card-title" style="width:100%;height:35px;">
							<div>
								<span class="span_title" id="detailTitle" style="float:left;">사용자 추가</span>						
							</div>
						</div>
						<!-- 내용 -->
						<%-- <div>					
							<form id="detailForm" method="post">							
							<table id="detail_grid" >			
								<tr>
									<th>이름</th>
									<td><input type="text" class="detail_form" name="userNm"/></td>
								</tr>
								<tr>
									<th>전화번호</th>
									<td><input type="text" class="detail_form" name="phone"/></td>
								</tr>
								<tr>
									<th>권한</th>
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
									<th>사용여부</th>
									<td>
										<div class="radio" style="display:flex;">
											<input type="radio" name="useYn" id="useY" value="Y" checked> 
											<label for="useY"> 사용</label>
											<input type="radio" name="useYn" id="useN" value="N" >  
											<label for="useN"> 미사용</label>
										</div>								
									</td>
								</tr>								
							</table>
							</form>			
						</div>
						
						<div class="pt-3">
							<button type="button" class="btn_admin" onclick="deleteUser()" style="float:right;width:120px">
								삭제
							</button>
							<button type="button" class="btn_admin" onclick="saveUser()" style="float:right;width:120px">
								저장
							</button>
						</div> --%>
						
					</div>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="../common/script.jsp" />
<script>
	var table;
	var mode = "S"; //조회
	
	table = $('#grid').DataTable({
		  paging: false		
		, scrollCollapse: true
		, autoWidth: true
		, ordering: false
		, select: true
		, searching: false
		, destroy: true
		, bInfo: false  
		, ajax: {
			url: '/sys/getSmsAdminList',
			dataSrc: function(res) {
          	return res.adminList;
          }
		}
		, processing: true
    	, language: {
			processing : '<div id="dt_preloader"><span>Loading...</span></div>',
			sEmptyTable : '마감 데이터가 없습니다.'
		}   
		, columns: [			
	  		{ data : "cdCode" },	        	
	  		{ data : "cdTitle2", width: 120 },	        	
			{ data : "cdTitle3" , render: function(data) { return data.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`) } },
			{ data : "cdUseyn" },
			{ data : null , width: 120 },
			{ data : null , width: 120 , render: function(){ 
				return '<button type="button" class="btn_admin btn_gray" onclick="deleteUser()" style="width:100px;height:30px;">삭제</button>'; 
				} 
			},
		]
		, order: []
		, columnDefs: [ 
			{ orderable: false, targets: 0 },
			{ targets: 4 , createdCell: function(td, cData, rData, row, col) {
				var html = '';
				if(rData.cdCode != '') {					
					html += '<button type="button" class="btn_admin bg-secondary" onclick="modifyUser(' + row+ ')">';
					html += '	수정';
				} else {					
					html += '<button type="button" class="btn_admin btn_green" onclick="saveUser()">';
					html += '	저장';
				}
				html += '</button>';				
				$(td).html(html);
			}},
			{ targets: 5 , createdCell: function(td, cData, rData, row, col) {
				var html = '';		
				if(rData.cdCode != '') {
					html += '<button type="button" class="btn_admin bg-danger" onclick="deleteUser(' + rData.cdCode + ')">';
				} else {
					html += '<button type="button" class="btn_admin bg-danger" onclick="deleteUser()">';					
				}
					html += '	삭제';
					html += '</button>';				
				$(td).html(html);
			}},
		]			
		, drawCallback: function() {
			$('#grid').DataTable().columns.adjust();
    	}
	});
	
	table
	    .on("select", function (e, dt, type, indexes) {
	    	/* var cdCode = table.rows({selected:true}).data()[0].cdCode;
	    	$('#cdCode').val(cdCode); */
	    })
	    .on("deselect", function (e, dt, type, indexes) {
	    	//$('#cdCode').val('');

	    });
	
	function addNewRow() {		
		if(mode == 'S') {
			mode = 'I';	// Insert
			table.rows({selected:true}).deselect();
			var emptyData = {
				'cdCode': "", 
				'cdTitle2': "<input class='cell_input' type='text' id='rName'/>",  
				'cdTitle3': "<input class='cell_input' type='text' id='rPhoneNum' onkeyup='replacePhoneNum(this)' />", 
				'cdUseyn': "<select class='cell_input'id='cdUseyn'><option value='Y'>Y</option><option value='N'>N</option></select>", 
			}			
			table.row.add(emptyData).select().draw(false);
			
			/* $("input[name='userId']").prop("readonly", false);
			$("#detailTitle").text("사용자 추가");
			$(".detail_area").show(); */
		}
	}
	
	function saveUser() {	
			if($('#rName').val() == '' || $('#rPhoneNum').val() == '') {
				alert('필드를 모두 입력해주세요.');
				return;
			}
			var data = {
					cdCode : $('#seq').val(),
					cdTitle2 : $('#rName').val(),
					cdTitle3 : $('#rPhoneNum').val(),
					cdUseyn : $('#cdUseyn').val(),
			}
			console.log(data);
			var url = "/sys/saveSmsAdminList";
			$.post(url, data, function(data, status) {
				if(data.result) {
					alert('저장되었습니다.');
					mode = 'S';
					table.ajax.reload();
				}
			})
	}
	function deleteUser(seq) {
		if(seq == undefined) {
			table.row(':last', { order: 'current' }).remove().draw(false);
			mode = "S";
		} else {
			var data = {
					cdCode : seq
			}
			if(confirm('정말 삭제하시겠습니까?')) {
				var url = "/sys/deleteSmsAdmin";
				$.post(url, data, function(data, status) {
					if(data.result) {
						alert('삭제되었습니다.');
						table.ajax.reload();
						mode = "S";
					}
				})
			}
			
		}
	}
	
	function modifyUser(rIdx) {
		if(mode != "I" && mode != "U") {			
			mode = "U";
			table.rows({selected:true}).deselect();
			
			var seq = table.cell(rIdx, 0).data();
			var preName = table.cell(rIdx, 1).data();
			var prePhoneNum = table.cell(rIdx, 2).data();
			var preUseyn = table.cell(rIdx, 3).data();
			
			$('#seq').val(seq);
			$('#preName').val(preName);
			$('#prePhoneNum').val(prePhoneNum);
			$('#preUseyn').val(preUseyn);
			
			table.row(rIdx).select();
			table.cell(rIdx, 1).data('<input class="cell_input" type="text" id="rName" value="' + preName + '"/>');
			table.cell(rIdx, 2).data('<input class="cell_input" type="text" id="rPhoneNum" value="' + prePhoneNum.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`) + '"  onkeyup="replacePhoneNum(this)"/>');
			table.cell(rIdx, 3).data('<select class="cell_input" id="cdUseyn"><option value="Y">Y</option><option value="N">N</option></select>');
			$('#cdUseyn').val(preUseyn);
			
			var html1 = '';				
				html1 += '<button type="button" class="btn_admin btn_green" onclick="saveUser()" style="width:100px;height:30px;">';
				html1 += '	저장';
				html1 += '</button>';
			var html2 = '';				
				html2 += '<button type="button" class="btn_admin btn_gray" onclick="cancelModify(' + rIdx + ')" style="width:100px;height:30px;">';
				html2 += '	취소';
				html2 += '</button>';
				
			$(table.cell(rIdx, 4).node()).html(html1);
			$(table.cell(rIdx, 5).node()).html(html2);
		}
	}
	
	function cancelModify(rIdx) {
		clearModifyMode(rIdx);		
		mode = "S";
		$('#seq').val('');
	}

	$('#grid tbody').on('click', 'tr', function(){
		// 버튼 클릭 시 selected 되도록
		// $(this).addClass("selected");
    });
	
	function clearModifyMode(rIdx) {
		var preName = $('#preName').val();
		var prePhoneNum = $('#prePhoneNum').val();
		var preUseyn = $('#preUseyn').val();
		
		table.cell(rIdx, 1).data(preName);
		table.cell(rIdx, 2).data(prePhoneNum);
		table.cell(rIdx, 3).data(preUseyn);
		
		var html1 = '';
			html1 += '<button type="button" class="btn_admin" onclick="modifyUser(' + rIdx + ')" style="width:100px;height:30px;">';
			html1 += '수정';
			html1 += '</button>';
		var html2 = '';
			html2 += '<button type="button" class="btn_admin btn_gray" onclick="deleteUser(this)" style="width:100px;height:30px;">';
			html2 += '삭제';
			html2 += '</button>';
			
		$(table.cell(rIdx, 4).node()).html(html1);
		$(table.cell(rIdx, 5).node()).html(html2);
	}
	
	function replacePhoneNum(el) {
		var inputVal = el.value;
		$(el).val(inputVal.replace(/[^0-9]/g, "").replace(/(^02|^0505|^1[0-9]{3}|^0[0-9]{2})([0-9]+)?([0-9]{4})$/,"$1-$2-$3").replace("--", "-"));
	}

</script> 
</body>
</html>

