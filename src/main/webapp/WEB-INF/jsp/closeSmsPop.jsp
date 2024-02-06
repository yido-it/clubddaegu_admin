<!-- 모달 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 예약상세리스트 팝업창 -->
<div class="modal fade" id="closeSmsModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content" style="margin: 0 auto;">
		
			<div class="modal-header"> 
				<p class="colorwhite">마감문자 전송</p>								
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true" id="list_close">&times; <span style='font-weight:normal'>닫기</span></span>
				</button>
			</div> 
			 
			<div class="modal-body" style="padding:10px;display:flex;">  		
				
				<div class="col-6">
					<textarea id='smsArea' style='width:100%;height:600px'></textarea>				
				</div>
				
				<!-- 수신대상 목록 -->
				<div class="col-6">
					<span class="span_title mt-1" style="font-size:20px">마감문자 수신 대상</span>
					<c:if test="${sessionScope.session.userAuth == 'ATH100' || sessionScope.session.userAuth == 'ATH200' }">
					<button class="btn_admin" onclick="javascript:location.href='/sys/adminSms'" style="width:100px;float:right;">관리</button>			
					</c:if>
					<div class='mt-2 pt-2' style="height:500px;overflow:auto">
						<table id='smsGrid' style='width:100%;table-layout:fixed;'>
							<thead>
								<tr>   
						         	<th>선택</th>   
						         	<th>이름</th>      	
						         	<th>전화번호</th>
								</tr>
					     	</thead>
						</table>
					</div>
					<div class='mt-2 col-12' style='position:absolute;bottom:0px;'>
						<button class="btn btn-info" id="btnSend" onclick="" style="width:200px;float:right;">전송</button>			
					</div>
				</div>
			
			</div>
		</div>
	</div>
</div>

<script>
	
$('#btnCloseSms').on('click', function() {		
	closeDate = $('#searchDt').val();		
	setSmsText();		
})

function setSmsText() {
	
	let template = '';
	let totAmt = 0;
	
	template = '[클럽디 대구 메리어트 일마감보고] \r\n'
		+ '-마감일자 : {0} \r\n'
		+ '■ 일 판매객실수 : {1} 명\r\n'
		+ '■ 당일 매출액 \r\n'
		+ ' -목표 : {2}원 \r\n'
		+ ' -실적 : {3}원({4}%) \r\n'

		+ '■ 구분별 매출 \r\n'
		+ ' -객실매출 : {5} 원 (객실단가 {6}원) \r\n'
		+ ' -식음매출 : {7} 원 \r\n'
		+ ' -기타매출 : {8} 원 \r\n'

		+ '■  {9}월 매출\r\n'
		+ ' -목표 : {10} 원\r\n'
		+ ' -실적 : {11} 원({12}%)\r\n'
		+ ' -매출차액 : {13} 원\r\n' 
		
		+ '■  연간실적\r\n'
           + ' -목표 : {14} 원\r\n'
           + ' -연누계 : {15} 원({16}%)\r\n'
           + ' -연목표대비 : {17} 원\r\n'
           + '이상입니다. \r\n'

		+ '--------------------------------------\r\n' 
		+ '자세한 내용은\r\n'
		+ 'http://49.50.163.152/\r\n'
		+ '에서 확인하실 수 있습니다.\r\n'
		+ '---------------------------------------';
				
	
       // totAmt = ticketAmt + fnbAmt + rentalAmt + etcAmt;		
	template = String.format(template
			               , mCloseDate                                  //0 마감일자
			               , formatNumberVal(mDailyRoomSalesCnt, 'cnt')            //1 일 판매 객실수
			               , formatNumberVal(mDailySalesTarget, 'sms')            //2 당일 목표
			               , formatNumberVal(mDailySalesActual, 'sms')             //3 당일 실적	
			               , formatNumberVal(mDailySalesActual/mDailySalesTarget*100, 'sms') //4 일매출 달성율
			               
			               , formatNumberVal(mRoomSales, 'sms') //5 객실매출
			               , formatNumberVal(mRoomPrice, 'sms')          //6 객실단가
			               , formatNumberVal(mRestaurantSales, 'sms')             //7 식음매출
			               , formatNumberVal(mEtcSales, 'sms')          //8 기타매출
			               
			               , mCloseDate.split('-')[1]                    //9 당월
			               , formatNumberVal(mMonthPlan, 'sms')          //10 월목표
			               , formatNumberVal(mMonthSales, 'sms')           //11 월매출
			               , formatNumberVal(mMonthSales/mMonthPlan*100, 'sms') //12 월매출 달성율
			               , formatNumberVal(mMonthSales-mMonthPlan, 'sms') //13 월매출 목표달성차
			               
			               , formatNumberVal(mYearPlan, 'sms')          //14 연목표
                              , formatNumberVal(mYearSales, 'sms')           //15 연매출
                              , formatNumberVal(mYearSales/mYearPlan*100, 'sms')  //16 연매출 달성율
                              , formatNumberVal(mYearSales-mYearPlan, 'sms')  //17 연월매출 목표달성차
                        );
	$('#smsArea').text(template);	
}

smsTable = $('#smsGrid').DataTable({
		  paging: false		
		, autoWidth: true
		, ordering: true
		, searching: false
		, destroy: true
		, bInfo: false  
		, ajax: {
			url: '/sys/getSmsAdminList',
			data: function(data) {
                   data.cdUseyn = 'Y';
               },
			dataSrc: function(res) {
            	return res.adminList;
            }
		}
		, processing: true
      	, language: {
			processing : '<div id="dt_preloader"><span>Loading...</span></div>',
			sEmptyTable : '수신 대상이 없습니다.'
		}   
		, columns: [
			{ data : '' , width: 40, className:'select-checkbox', render: function(data, type, full, meta) { return '<input type="checkbox" class="chkbox" id="' + meta.row + '"/>'; }},
    		{ data : "cdTitle2" , width: 100, },	        	
			{ data : "cdTitle3" , render: function(data) { return data.replace(/^(\d{2,3})(\d{3,4})(\d{4})$/, `$1-$2-$3`) }},
    		{ data : "cdCode" , visible: false, },	        	
		]
		, order: []
		, columnDefs: [ 
			{ orderable: false, targets: 0 },
			{ className: 'dt-body-left', targets: [1, 2] },
		]			
		, select: {
			items: 'row' ,
			style: 'multi' ,
			/* selector: 'td:first-child', */
	    }
});

$(document).on('click', '#smsGrid tbody tr', function(e) {

	if (e.target.className != 'chkbox') {			
        var checkbox = $(this).closest('tr').find('input[type="checkbox"]');
        checkbox.prop('checked', !checkbox.prop('checked'));
	}
});

$('#btnSend').on('click', function() {
	if(confirm('마감 문자를 전송하시겠습니까?')) {
		var selectedRows = smsTable.rows({ selected: true }).data().toArray();
	
		$.ajax({
			  url: "<c:url value='/report/dailySales/sendCloseSms'/>"
			, type: "post"
			, contentType: 'application/json'
			, data: JSON.stringify({
				smsList: selectedRows,
				smsText: $('#smsArea').val()
			})
			, success: function(data) {
				if(data.result) {							
	          		alert('문자전송을 완료했습니다.');
				} else {
					alert(data.message);
				}
			}
			, error: function(data) {
				alert('[error] 오류가 발생했습니다.');
			}
		});
	}
})

</script>