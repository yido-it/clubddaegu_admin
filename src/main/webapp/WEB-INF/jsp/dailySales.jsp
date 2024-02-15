<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<jsp:include page="common/head.jsp" />
<style>
.reportContent input {text-align:right}
</style>

<body class="fixed-header desktop">  
	<jsp:include page="common/navigation.jsp" />
	<!-- 상단 메뉴 -->
	<div class="page-container">
	<div class="page-content-wrapper">
		<div class="container-fluid">
			<div class="content">
				<div class="main_list">
					<div class="row">
					    <div class="col-md-12">
							<span class="span_title fl">일별마감 &nbsp;</span>
							<input class="form-control fl text-center m-0" type="date" id="searchDt" style="width: 200px;">
						</div>
					</div>
						
					<div>
						<div class="row mt-3" id="reportTable">
							<div class="col-7">
								<div class="row reportRow" style="border-top : 1px solid #80808085;">
									<div class="col-3 reportTitle"><p>마감일자</p></div>
									<div class="col-3 reportContent text-center"><p id="closeDate"></p></div>
									
									<div class="col-3 reportTitle"><p>일 판매객실수</p></div>
									<div class="col-3 reportContent"><input type="text" id="dailyRoomSalesCnt" onkeyup="setAddComma(this)"></div>
									
								</div>
								<div class="row reportRow">
									<div class="col-3 reportTitle"><p>당일 매출액 목표</p></div>
									<div class="col-3 reportContent"><input type="text" id="dailySalesTarget" onkeyup="setAddComma(this)"></div>
									
									<div class="col-3 reportTitle"><p>당일 매출액 실적</p></div>
									<div class="col-3 reportContent"><input type="text" id="dailySalesActual" onkeyup="setAddComma(this)"></div>
								</div>
								<div class="row reportRow">
									<div class="col-3 reportTitle"><p>객실매출</p></div>
									<div class="col-3 reportContent"><input type="text" id="roomSales" onkeyup="setAddComma(this)"></div>
									
									<div class="col-3 reportTitle"><p>식음매출</p></div>
									<div class="col-3 reportContent"><input type="text" id="restaurantSales" onkeyup="setAddComma(this)"></div>
								</div>
								<div class="row reportRow">
									<div class="col-3 reportTitle"><p>기타매출</p></div>
									<div class="col-3 reportContent"><input type="text" id="etcSales" onkeyup="setAddComma(this)"></div>
									
									<div class="col-3 reportTitle none-data"></div>
									<div class="col-3 reportContent none-data"></div>
								</div>	
								
								<div class="row reportRow">
									<div class="col-3 reportTitle"><p>비고</p></div>
									<div class="col-9 reportContent">
										<textarea rows="5" class="form-control" id="remark"></textarea>
									</div>
								</div>	
								<div class="row reportRow">
									<div class="col-3 reportTitle"><p>이미지ㄴㄴ</p></div>
									<div class="col-9 reportContent">
										<textarea rows="5" class="form-control" id="remark"></textarea>
									</div>
								</div>	
							</div>
						</div>	
						
						<div class="row mt-3">
							<!-- <div class="col-md-7"></div> -->
							<div class="col-7 btn-box">
								<button type="button" class="btn_admin btn_send" id="btnCloseSms" data-toggle="modal" data-target="#closeSmsModal" data-whatever="@mdo" style="float:right;">
									마감문자
								</button>
								<button type="button" class="btn_admin" id="btnCancel" onclick="cancelCloseDailySales()" style="float:right;">
									마감취소
								</button>
								<button type="button" class="btn_admin" id="btnClose" onclick="insertDailyReport()" style="float:right;">
									마감
								</button>
								
							</div>
						</div>
					</div>	
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="common/script.jsp" />
<jsp:include page="./closeSmsPop.jsp" />

</body>
<script>
let table;


/* 마감문자 전송용 변수 */
var smsTable;

let mCloseDate;						// 마감일자
let mDailyRoomSalesCnt = 0;    		// 일 판매 객실수 		
let mDailySalesTarget = 0;       	// 당일 목표
let mDailySalesActual = 0;  		// 당일 실적	
let mRoomSales = 0;  				// 객실매출
let mRoomPrice = 0;  				// 객실단가
let mRestaurantSales = 0;  			// 식음매출
let mEtcSales = 0;  				// 기타매출

let mMonthSales = 0;  	// 월 실적
let mRoomRevenue = 0;	// 월 객실 목표
let mTotalFood = 0;		// 월 식음 목표
let mTotalOther = 0;	// 월 기타 목표 
let mMonthPlan = 0; 	// 월 목표 

let yRoomRevenue = 0;	// 연 객실 목표
let yTotalFood = 0;		// 연 식음 목표
let yTotalOther = 0;	// 연 기타 목표 
let mYearPlan = 0; 		// 연 목표 
	
let mYearSales = 0;	// 연누계


$(document).ready(function() {
	initTables();
});


function initTables() {
	$('.loading').css('display', 'inline');
	
	$.ajax({
        url: "/report/getDailySales",
        type: "post",
        dataType: 'json',
        data: {
        	searchDt : $('#searchDt').val().replaceAll("-", "")
        	, searchDt2 : $('#searchDt').val()
        },
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
        	endDtPreloader();

            initDailyReportTable(data.dailyReport, data.yearReport, data.salesPlanMonth, data.salesPlanYear);

            $('.loading').css('display', 'none');
        },
        error: function(data) {
            alert(data);
            location.reload();
        }
    });
}

function initDailyReportTable(reportData, yearReport, mPlanData, yPlanData) {
	
	console.log('initDailyReportTable > reportData :', reportData);
	console.log('initDailyReportTable > yearReport :', yearReport);
	console.log('initDailyReportTable > mPlanData :', mPlanData);
	console.log('initDailyReportTable > yPlanData :', yPlanData);
	
	if (reportData != null) {
		// 데이터 있을때

		$('#closeDate').text(setDateCell(reportData.closeDate));
		$('#dailyRoomSalesCnt').val(setCountCell(reportData.dailyRoomSalesCnt));
		$('#dailySalesTarget').val(setCountCell(reportData.dailySalesTarget));
		$('#dailySalesActual').val(setCountCell(reportData.dailySalesActual));
		$('#roomSales').val(setCountCell(reportData.roomSales));
		$('#restaurantSales').val(setCountCell(reportData.restaurantSales));
		$('#etcSales').val(setCountCell(reportData.etcSales));
		$('#remark').val(reportData.remark);
	
		if (reportData.closeYn == 'Y') {

	   		$('#btnClose').hide();
	   		$('#btnCancel').show();
	   		$('#btnSms').show();
	   		$('#btnCloseSms').show();
	   		
	   		// 마감문자 포맷에 사용되는 값 세팅 
	   		mCloseDate = setDateCell(reportData.closeDate);
	   		mDailyRoomSalesCnt = reportData.dailyRoomSalesCnt;  // 일 판매 객실수 		
	   		mDailySalesTarget = reportData.dailySalesTarget;    // 당일 목표
	   		mDailySalesActual = reportData.dailySalesActual;  	// 당일 실적	
	   		mRoomSales = reportData.roomSales;  				// 객실매출
	   		mRoomPrice = reportData.roomPrice;  				// 객실단가
	   		mRestaurantSales = reportData.restaurantSales;  	// 식음매출
	   		mEtcSales = reportData.etcSales;  					// 기타매출
	   		mMonthSales = reportData.monthSales;  				// 월 실적
	   
	   		mRoomRevenue = mPlanData.roomRevenue == null ? 0 : mPlanData.roomRevenue;	// 월 객실 목표
	   		mTotalFood = mPlanData.totalFood == null ? 0 : mPlanData.totalFood;			// 월 식음 목표
	   		mTotalOther = mPlanData.totalOther == null ? 0 : mPlanData.totalOther;		// 월 기타 목표

	   		mMonthPlan = mRoomRevenue + mTotalFood + mTotalOther; // 월 목표
	   		
	   		mYearSales = yearReport.yearlySalesActual;	// 연 실적
	   		yRoomRevenue = yPlanData.roomRevenue == null ? 0 : yPlanData.roomRevenue;	// 연 객실 목표
	   		yTotalFood = yPlanData.totalFood == null ? 0 : yPlanData.totalFood;			// 연 식음 목표
	   		yTotalOther = yPlanData.totalOther == null ? 0 : yPlanData.totalOther;		// 연 기타 목표
	   		
	   		mYearPlan = yRoomRevenue + yTotalFood + yTotalOther;	// 연 목표
	   		// end.
	   		
		} else {

	   		$('#btnClose').show();
	   		$('#btnCancel').hide();
	   		$('#btnSms').hide();
	   		$('#btnCloseSms').hide();
		}
		
   		$('#btnReadExcel').css('display', 'none');
   		$('#excelUpForm').css('display', 'none');
	
	} else {
		// 데이터 없을때
		
		$('#closeDate').text($('#searchDt').val());
		$('#dailyRoomSalesCnt').val("");
		$('#dailySalesTarget').val("");
		$('#dailySalesActual').val("");
		$('#roomSales').val("");
		$('#restaurantSales').val("");
		$('#etcSales').val("");
		$('#remark').val("");
		
   		$('#btnClose').show();
   		$('#btnCancel').hide();
   		$('#btnSms').hide();
   		$('#btnCloseSms').hide();
   		
   		$('#btnReadExcel').css('display', '');
   		$('#excelUpForm').css('display', '');

   		// 마감문자 포맷에 사용되는 값 초기화
   		mCloseDate = '';
   		mDailyRoomSalesCnt = 0;	// 일 판매 객실수 		
   		mDailySalesTarget = 0;	// 당일 매출액 목표
   		mDailySalesActual = 0;  // 당일 매출액 실적	
   		mRoomSales = 0;  		// 객실매출
   		mRoomPrice = 0;  		// 객실단가
   		mRestaurantSales = 0;  	// 식음매출
   		mEtcSales = 0;  		// 기타매출
   		mMonthSales = 0;  		// 당월실적
   		
   		mRoomRevenue = 0;	// 월 객실 목표
   		mTotalFood = 0;		// 월 식음 목표
   		mTotalOther = 0;	// 월 기타 목표
   		mMonthPlan = 0; // 월 목표 
   		
   		mYearSales = 0; // 연실적
   		yRoomRevenue = 0;	// 연 객실 목표
   		yTotalFood = 0;		// 연 식음 목표
   		yTotalOther = 0;	// 연 기타 목표
   		mYearPlan = 0;	// 연 목표
   		// end.
	}
}

function setAmountCell(data) {
	return Number(data).toLocaleString("ko-KR")+"원";
}

function setCountCell(data) {
	return Number(data).toLocaleString("ko-KR");
}

function setDateCell(data) {
	return closeDate = data.substring(0, 4) + "-" + data.substring(4, 6) + "-" + data.substring(6, 8); 
}

function setReplaceAll(data) {
	return data.trim().replaceAll(",", "");
}

function setAddComma(input) {
	// 입력된 값에서 숫자와 콤마를 제외한 모든 문자 제거
    var value = input.value.replace(/[^\d,]/g, '');
    // 콤마로 분리된 각 부분의 배열 생성
    var parts = value.split(',');
    // 각 부분을 다시 합쳐서 숫자로 변환
    var numberValue = parts.join('');
    // 숫자 형식으로 변환
    var formattedValue = Number(numberValue).toLocaleString('en');
    // 입력란에 포맷된 값 적용
    input.value = formattedValue;
}

// 마감
function insertDailyReport() {
	
	var closeDate = $('#searchDt').val().replaceAll("-", "");
	
	var dailyRoomSalesCnt = setReplaceAll($('#dailyRoomSalesCnt').val());
	console.log('dailyRoomSalesCnt:', dailyRoomSalesCnt);
	
	var dailySalesTarget = setReplaceAll($('#dailySalesTarget').val());
	var dailySalesActual = setReplaceAll($('#dailySalesActual').val());
	var roomSales = setReplaceAll($('#roomSales').val());
	var restaurantSales = setReplaceAll($('#restaurantSales').val());
	var etcSales = setReplaceAll($('#etcSales').val());
	var remark = $('#remark').val();
	
	if (closeDate == "" || dailyRoomSalesCnt == "" || dailySalesTarget == "" || dailySalesActual == "" 
			|| roomSales == "" || restaurantSales == "" || etcSales == "") {
		alert('비고를 제외한 모든 항목을 다 입력해 주세요.');
		return false;
	}
	
	if(confirm('입력한 정보로 마감자료를 등록하시겠습니까?')) {
			
	    $.ajax({
	        url: '/report/insertDailyReport',
	        type: "post",
	        dataType: 'json',
	        data: {
	        	closeDate : closeDate
	        	, dailyRoomSalesCnt : dailyRoomSalesCnt
	        	, dailySalesTarget : dailySalesTarget
	        	, dailySalesActual : dailySalesActual
	        	, roomSales : roomSales
	        	, restaurantSales : restaurantSales
	        	, etcSales : etcSales
	        	, remark : remark
	        },
	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        success: function(data) {
	        	
	            if(data.code == "0000") {
	            	alert('마감되었습니다.');
	            	
	    	   		$('#btnClose').hide();
	    	   		$('#btnCancel').show();
	    	   		$('#btnSms').show();
	    	   		$('#btnCloseSms').show();
	    	   		
	    	   		$('#attachFileName2').val('');
	    	   		
	    	   		initTables();
	    	   		
	            } else if(data.code == "9999") {
	            	alert(data.message);
	            } 
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error);
	        }
	    });
	}
}

// 마감취소 
function cancelCloseDailySales() {

	if(confirm($('#searchDt').val() + ' 마감을 취소하시겠습니까?')) {
		$.ajax({
	        url: "/report/deleteDailySales",
	        type: "post",
	        dataType: 'json',
	        data: {
	        	closeDate : $('#searchDt').val().replaceAll("-", "")
	        },
	        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
	        success: function(data) {
	        	if (data.code == "0000") {

		        	alert('마감이 취소되었습니다.');
		        	initTables();
	        	} else if (data.code == "9999"){
	        		alert(data.message);
	        	}
	        },
	        error: function(data) {
	            alert(data);
	            location.reload();
	        }
	    });

	}
}
$("#searchDt").flatpickr({
	  defaultDate: "today"
	, maxDate: "today"
	, locale: 'ko'
	, disableMobile: true
	, onChange: function() {
		initTables();
	}
})

</script>
</html>

