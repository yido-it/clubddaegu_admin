<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<jsp:include page="../common/head.jsp" />
<style>
	body, table, .form-control, .btn { 
		font-size: 13px; 
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
	    width: 100px;
	} 
	.radio_type2 input {
	    position: absolute;
	    width: 15px;
	    height: 15px;
		accent-color: #e15501;
  		top: 4px;
	}
	.radio_type2 label {
	    display: inline-block;
	    font-weight: 400;
	    padding-left: 21px;
	    color: #333;
	    position: relative;
	    cursor: pointer;
	    margin-left: 4px;
	}
	.radio_type2 {
	    right: 0;
	    z-index: 9;
	}
	.radio_type2 > span:first-child {
	    margin-left: 0;
	}	
	.radio_type2 > span {
	    margin-left: 10px;
	}
	.col-2 {
		max-width: 11% !important;
	}
	.condition-text {
		font-size: 10px;
	}
</style>
<body class="fixed-header desktop">   
	<jsp:include page="../common/navigation.jsp" />
	<div class="page-container">
		<div class="page-content-wrapper">
			<div class="container-fluid">
				<div class="content">
			 
					<div> 
						<div class="row mt-5" style="display:flex;">
							<div class="col-12">
								<h5>회원 수신 관리</h5>  
							</div>
						</div>
						
						<form id="frmSms">
										
							<div class="row mt-3">		
								<!-- <div class="col-2">
									<div class="form-group row"> 
										<label class="col-3 col-form-label">기준</label>
										<div class="col-9 radio_type2" style="display:flex;">
											<span>
												<input type="radio" name="target" id="member" value="M" onclick="" checked> 
												<label for="member"> 회원</label>
											</span>
											<span>
												<input type="radio" name="target" id="customer" value="C" onclick="">  
												<label for="customer"> 내장객</label>
											</span>
										</div>
										
									</div>
								</div> -->							
								<div class="col-2">
									<div class="form-group row"> 
										<label class="col-3 col-form-label">시도</label>
										<select class="slt_type col-8" name="msArea1" id="msArea1" onchange="setConditionText(this)">
				                        	<option value="">전체</option>
											<c:forEach items="${msArea1List}" var="item" varStatus="status">
					                        	<option value="${item.cdCode}">${item.cdTitle1}</option>
							                </c:forEach>
										</select>
									</div>
								</div>	
								
								<div class="col-2">
									<div class="form-group row"> 
										<label class="col-3 col-form-label">시군구</label>									
										<select class="slt_type col-8 fr" name="msArea2" id="msArea2" onChange="setConditionText(this)">	
											<option value="">전체</option>			                   											
										</select>				
									</div>
								</div>	
								
								<div class="col-4" style="max-width:30% !important;">
									<div class="form-group row">
										<label class="col-2 col-form-label">연령대</label>
										<div class="chk_type">
											<input type="checkbox" class="searchChk ageChk" id="ageAll">
											<label style="padding-left:0" for="ageAll">전체</label>
										</div>	                        	
										<div class="chk_type">
											<input type="checkbox" class="searchChk ageChk" id="age10" name="age10" value="age10" onChange="setConditionText(this)">
											<label style="padding-left:0" for="age10">10대 이하</label>
										</div>	                        	
										<div class="chk_type">
											<input type="checkbox" class="searchChk ageChk" id="age20" name="age20" value="age20" onChange="setConditionText(this)">
											<label style="padding-left:0" for="age20">20대</label>
										</div>	                        	
										<div class="chk_type">
											<input type="checkbox" class="searchChk ageChk" id="age30" name="age30" value="age30" onChange="setConditionText(this)">
											<label style="padding-left:0" for="age30">30대</label>
										</div>	                        	
										<div class="chk_type">
											<input type="checkbox" class="searchChk ageChk" id="age40" name="age40" value="age40" onChange="setConditionText(this)">
											<label style="padding-left:0" for="age40">40대</label>
										</div>	                        	
										<div class="chk_type">
											<input type="checkbox" class="searchChk ageChk" id="age50" name="age50" value="age50" onChange="setConditionText(this)">
											<label style="padding-left:0" for="age50">50대</label>
										</div>	                        	
										<div class="chk_type">
											<input type="checkbox" class="searchChk ageChk" id="age60" name="age60" value="age60" onChange="setConditionText(this)">
											<label style="padding-left:0" for="age60">60대 이상</label>
										</div>	                        	
									</div>
								</div>	
								
								<div class="" style="max-width:14% !important;">
									<div class="form-group row">
										<label class="col-2 col-form-label">성별</label>
										<div class="chk_type">
											<input type="checkbox" class="searchChk sexChk" id="sexAll" value="">
											<label style="padding-left:0" for="sexAll">전체</label>
										</div>
										<div class="chk_type">
											<input type="checkbox" class="searchChk sexChk" id="sexW" value="W" onChange="setConditionText(this)">
											<label style="padding-left:0" for="sexW">여자</label>
										</div>
										<div class="chk_type">
											<input type="checkbox" class="searchChk sexChk" id="sexM" value="M" onChange="setConditionText(this)">
											<label style="padding-left:0" for="sexM">남자</label>
										</div>
										<input type="hidden" id="sex" name="sex"/>
									</div>
								</div>
														
								<div class="" style="max-width:14% !important;">
									<div class="form-group row">
										<label class="col-form-label">마케팅수신여부</label>
										<div class="chk_type">
											<input type="checkbox" class="searchChk marketingChk" id="marketingAll" value="">
											<label style="padding-left:0" for="marketingAll">전체</label>
										</div>
										<div class="chk_type">
											<input type="checkbox" class="searchChk marketingChk" id="marketingY" onChange="setConditionText(this)" value="Y">
											<label style="padding-left:0" for="marketingY">Y</label>
										</div>
										<div class="chk_type">
											<input type="checkbox" class="searchChk marketingChk" id="marketingN" onChange="setConditionText(this)" value="N">
											<label style="padding-left:0" for="marketingN">N</label>
										</div>
										<input type="hidden" id="marketing" name="marketing"/>
									</div>
								</div>								
								
								<div class="form-group row ml-3" style="display:flex;">
									<label class="col-2 col-form-label">이름</label>
									<input type="text" id="mbName" name="mbName" style="width:50%" >
									<button type="button" class="btn btn-primary ml-3" onClick="getMemberSmsList()">조회</button> 		
								</div>
							</div>							
							<hr>							
						
						<div class="row mt-3">
							<div class="col-8">		
								<div style="text-align:right;" class="mr-3">총 <span id="numRows">0</span> 행</div>
								<div class="col-12"> 
									<table id='memGrid' class="" style="width:100%">
										<thead>
											<tr id='tkTr'> 
									         	<th><!-- <input type="checkbox" id="checkAll" onclick="checkAll(this)"> --></th>  
									         	<th>회원명</th>  
									         	<th>시도</th>
									         	<th>시군구</th>   
									         	<th>연령대</th> 
									         	<th>성별</th> 
									         	<th>마케팅수신여부</th>								         	
									         	<th>연락처</th>    
											</tr>
								     	</thead>
									</table>
								</div>
							</div>
							<div class="col-4">
								<div class="mb-4" style="display:flex;">
									<div class="" id="c_msArea" style="width:18%">			
										<span style="display:block;"><b>시도</b></span>
										<span class="condition-text" id="l_msArea1">&nbsp;</span>		
										<span class="condition-text" id="l_msArea2">&nbsp;</span>		
									</div>
									<div class="ml-2" id="c_age" style="width:40%">
										<span style="display:block;"><b>연령대</b></span>
										<span class="condition-text" id="l_age10" style="display:none;">&nbsp;10대 이하</span>			
										<span class="condition-text" id="l_age20" style="display:none;">&nbsp;20대</span>				
										<span class="condition-text" id="l_age30" style="display:none;">&nbsp;30대</span>				
										<span class="condition-text" id="l_age40" style="display:none;">&nbsp;40대</span>				
										<span class="condition-text" id="l_age50" style="display:none;">&nbsp;50대</span>				
										<span class="condition-text" id="l_age60" style="display:none;">&nbsp;60대 이상</span>				
									</div>
									<div class="ml-2" id="c_sex" style="width:16%">
										<span style="display:block;"><b>성별</b></span>							
										<span class="condition-text" id="l_sexW" style="display:none;">&nbsp;여자</span>								
										<span class="condition-text" id="l_sexM" style="display:none;">&nbsp;남자</span>								
									</div>
									<div class="ml-2" id="c_marketing"  style="width:16%">
										<span style="display:block;"><b>마케팅 수신</b></span>							
										<span class="condition-text" id="l_marketingY" style="display:none;">&nbsp;동의</span>								
										<span class="condition-text" id="l_marketingN" style="display:none;">&nbsp;비동의</span>							
									</div>
									<div class="ml-2">
										<button type="button" class="btn btn-info ml-2" style="width:100%" id="btnSendAll">일괄 전송</button>
									</div>							
								</div>
								<textarea id='smsText' name='smsText' style='width:100%;height:400px' maxlength='300'>[오아시스 SMS 테스트]</textarea>		
								<div class='mt-2 col-12'>
									<button type="button" class="btn btn-info fr ml-2" id="btnSend">선택한 대상에게 전송</button>			
								</div>
							</div>
						</div>
						</form>
											
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
	});
	
	const smsForm = document.getElementById("frmSms");
	smsForm.addEventListener("submit", function(e) {
		e.preventDefault();
	});
	
	function setConditionText(el) {
		let target = el.id.match(/(msArea|sex|age|marketing)/)[0];
		if(target != 'msArea') {
			if (!$(el).is(':checked')) {
				$('#l_' + el.id).hide();
			} else {
				$('#l_' + el.id).show();
			}
		} else {
			$('#l_' + el.id).text($(el).find(':selected').text());
		}
	}
	
	$('#msArea1').on('change', function() {
		getMsArea2List();
	})
	
	function getMsArea2List() {
		if($('#msArea1').val() != null && $('#msArea1').val() != "") {
			var params = {
				  coDiv : '001'
				, cdDivision : '221'	
				, cdCode : $('#msArea1').val()
			}
			
			$('#l_msArea1').text($('#msArea1 :selected').text());
			
			$.ajax({
		        url: "<c:out value='/common/getCommonCodeDetailList'/>"
		        , type: "post"
		        , dataType: 'json'
		        , data: params
		        , contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
		        , success: function(data) {
		            if(data.result){		          
		            	$('#msArea2').empty();			            	
		            	var list = data.detailList;
		            	var option = '<option value="">전체</option>';			     
						for(var i = 0; i < list.length; i++) {
							option += "<option value='" + list[i].cdCode + "' class='cd_detail_list'>" + list[i].cdTitle1 + "</option>";
						}
						$('#msArea2').append(option);
		            } else {
		                alert(data.message);                    
		            }                
		        }
		        , error: function(data) {
		        	 alert('[error] 코드 호출 중 오류 발생했습니다.');
		        }
		    });
		} else {
			$('#msArea2').remove();
		}
	}
	
	$('.searchChk').on('click', function(e) {
		
		let obj = e.target;
		let chkYn = $(obj).prop('checked');
		let checkboxes = $('.searchChk');
		let target = obj.id.match(/(sex|age|marketing)/)[0];
		
		if(obj.id.includes('All')) {		
			let spans = $('.condition-text');
			checkboxes.each(function() {
		        if (this.id.includes(target)) {
		            $(this).prop('checked', chkYn);
		        }
		    });
			spans.each(function() {
				if (this.id.includes(target)) {
					chkYn ? $(this).show() : $(this).hide();
		        }
			})
		} else {
			let allChk = true;
			checkboxes.each(function() {
		        if ((!(this.id.includes('All'))) && this.id.includes(target)) {
		        	if(!$(this).is(':checked')) {
		        		allChk = false;
		        	}
		        }
		    });
			$('#' + target + 'All').prop('checked', allChk);
		}
	})
	
	function getMemberSmsList() {		
				
		if(!checkChkboxGrp('.ageChk', '연령대를 한개 이상 체크해주세요.')) {
			return;
		}
		if(!checkChkboxGrp('.sexChk', '성별을 한개 이상 체크해주세요.')) {
			return;
		}
		if(!checkChkboxGrp('.marketingChk', '마케팅 수신여부를 한개 이상 체크해주세요.')) {
			return;
		}
		
		$('.loading').css('display', 'inline');
		
		if($('#sexW').is(':checked') && !$('#sexM').is(':checked')) {
			$('#sex').val('W');
		} else if(!$('#sexW').is(':checked') && $('#sexM').is(':checked')) {
			$('#sex').val('M');
		} else {
			$('#sex').val('');			
		}
		
		if($('#marketingY').is(':checked') && !$('#marketingN').is(':checked')) {
			$('#marketing').val('Y');
		} else if(!$('#marketingY').is(':checked') && $('#marketingN').is(':checked')) {
			$('#marketing').val('N');
		} else {
			$('#marketing').val('');			
		}
		
		
		$.ajax({
			url: "/sys/getMemberSmsList" 
			, type: "post"
			, dataType: 'json'
			, data :  $('#frmSms').serialize()
			, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
			, success: function(data) {
				$('.loading').css('display', 'none');
				 if(data.result){	            	
		            setMemberSmsList(data.memberList);
	            } else {
	            	alert(data.message);
	            }         
			}
			, error: function(data) {
                alert(data);
                location.reload();
            }
		});	
		
	}
	
	function checkChkboxGrp(selector, msg) {
		var result = false;
		$(selector).each(function() {
			if($(this).is(':checked')) {
				result = true;
			}
		})			
		if(!result) {
			alert(msg);
		}			
		return result;
	}

	function setMemberSmsList(memberList) {
		$('.loading').css('display', 'inline');
		table = $("#memGrid").DataTable({
		  	  paging: false		
		  	/* , lengthMenu: [50, 100, 200, 500] */
			, scrollCollapse: true
			, autoWidth: false
			, ordering: true
			, searching: false
			, select: true
			, destroy: true
			, bInfo: false  
			, data: memberList
			, processing: true
			, language: {
				processing : "<div id='dt_preloader'><span>Loading...</span></div>",
				sEmptyTable : "데이터가 없습니다."
			}		
			, columns: [  
				{ data : "mbNo" , width: 40, render: function(data, type, row, meta) { 
					return '<input type="checkbox" class="chkbox" value="' + data + '|' + row.mbName + "|" + row.hpNo + '"/>'; }
				},
				{ data : "mbName" },
				{ data : "msArea1" },
				{ data : "msArea2" },
				{ data : "ageRange" },
				{ data : "sex" },
				{ data : "msSmsYN" },
				{ data : "hpNo" , render:setHpNo },
			]
			, columnDefs: [
				{ targets : 0, className:"select-checkbox", defaultContent:''},
				{ targets : [0, 5, 6], orderable: false}	
			]			
			, select: {
				items: 'row' ,
		      	style: "multi",
				selector: "td:first-child"
		    }
		    , initComplete: function(settings, json) {
		    	$('.loading').css('display', 'none');
				var api = this.api();
				var numRows = api.rows( ).count();
				$('#numRows').text(numRows);
		    }
		});
	}
	
	// 전화번호
	var setHpNo = function(data, type, row, meta) {
		if (data) {
			if(data.length >= 10) {
		        return data.replace(/(\d{3})(\d{4})(\d{4})/, '$1-****-$3');
			} else {
		        return data.replace(/(\d{3})(\d{4})(\d{4})/, '$1-***-$3');				
			}
	    } else {
	        return ''; // 또는 원하는 기본값으로 변경 가능
	    }
	}
	
	$(document).on('click', '#memGrid tbody tr', function(e) {
		if (e.target.className != 'chkbox') {			
	        var checkbox = $(this).closest('tr').find('input[type="checkbox"]');
	        checkbox.prop('checked', !checkbox.prop('checked'));
		}
	})
	
	function checkAll(el) {
		if($(el).prop("checked")){
            table.rows().select();
            $('.chkbox').prop("checked", true);
        }
        else {
            table.rows().deselect();
            $('.chkbox').prop("checked", false);
        }
	}	

	// 선택 전송
	$('#btnSend').on('click', function() {
		
		const checkedIds = new Array();
		$('.select-checkbox .chkbox:checked').each(function() {
			checkedIds.push($(this).val());
		});
		
		if(checkedIds.length < 1) {
			alert('문자를 전송할 대상을 선택해주세요.');
			return;
		}
		
		if(confirm('선택한 대상에게 문자를 전송하시겠습니까?')) {

			$('.loading').css('display', 'inline');
			
			
			$.ajax({
				  url: "<c:url value='/sys/sendMemberSms'/>"
				, type: "post"
				, contentType: 'application/json'
				, data: JSON.stringify({
					mbNoArr: checkedIds,
					smsText: $('#smsText').val()
				})
				, success: function(data) {
					$('.loading').css('display', 'none');
					if(data.result) {							
		          		alert('문자전송을 완료했습니다.');
					} else {
						alert(data.message);
					}
				}
				, error: function(data) {
					alert('[error] 오류가 발생했습니다.');
					$('.loading').css('display', 'none');
				}
			});
		}
	})
	
	// 전체 전송
	$('#btnSendAll').on('click', function() {		
				
		if(!checkChkboxGrp('.ageChk', '연령대를 한개 이상 체크해주세요.')) {
			return;
		}
		if(!checkChkboxGrp('.sexChk', '성별을 한개 이상 체크해주세요.')) {
			return;
		}
		if(!checkChkboxGrp('.marketingChk', '마케팅 수신여부를 한개 이상 체크해주세요.')) {
			return;
		}
		
		if(confirm('일괄로 문자를 전송하시겠습니까?')) {
				
			$('.loading').css('display', 'inline');
			
			if($('#sexW').is(':checked') && !$('#sexM').is(':checked')) {
				$('#sex').val('W');
			} else if(!$('#sexW').is(':checked') && $('#sexM').is(':checked')) {
				$('#sex').val('M');
			} else {
				$('#sex').val('');			
			}
			
			if($('#marketingY').is(':checked') && !$('#marketingN').is(':checked')) {
				$('#marketing').val('Y');
			} else if(!$('#marketingY').is(':checked') && $('#marketingN').is(':checked')) {
				$('#marketing').val('N');
			} else {
				$('#marketing').val('');			
			}
			$('#mbName').val('');	
			
			$.ajax({
				  url: "<c:url value='/sys/sendMemberSmsAll'/>"
				, type: "post"
				, contentType: 'application/x-www-form-urlencoded; charset=UTF-8'
				, data: $('#frmSms').serialize()
				, success: function(data) {
					$('.loading').css('display', 'none');
					 if(data.result){	            	
		            	alert('문자 전송이 완료되었습니다.');
		            } else {
		            	alert(data.message);
		            }        
				}
				, error: function(data) {
					alert('[error] 오류가 발생했습니다.');
					$('.loading').css('display', 'none');
				}
			});	
			
		}	
	})

</script>
</html>

	