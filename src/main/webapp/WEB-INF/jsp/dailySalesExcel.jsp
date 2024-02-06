<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<jsp:include page="common/head.jsp" />
<style>
 
input[type="file"] {overflow: hidden;position: absolute;width: 1px;height: 1px;margin: -1px;font-size: initial;clip: rect(0 0 0 0);}
input[type="file"]:focus-visible ~ .file_btn, .file_cus:hover .file_btn {background: #8ab4f8 }
 
label {margin-bottom:0}

.file_cus label {display: block;width:450px;font-size: 0;cursor: pointer;}
.file_name {overflow: hidden;display: inline-block;vertical-align: middle;width: calc(100% - 150px);height: 40px;padding:0 12px;border: 1px solid #ddd;border-radius:4px;font-size: 14px;line-height: 38px;color: #111;white-space: nowrap; text-overflow: ellipsis;}
.file_btn {vertical-align: middle;width: 100px;height: 40px;margin-left: 8px;background: #3478db;border-radius:4px;font-size: 14px;font-weight: 500;line-height: 40px;color: #fff;text-align: center;}
.btnExcelUpload {padding:10px 20px;vertical-align: middle;width: 100px;height: 40px;margin-left: 8px;background: #48cd78;border-radius:4px;font-size: 14px;font-weight: 500;line-height: 40px;color: #fff;text-align: center;}
.btnExcelUpload:hover {background: #8dd9a8;}

/* 파일명 input box*/
.fileName {display:inline-block;width:400px;height:40px;padding-left:10px;margin-right:5px;line-height:35px;border:1px solid #e1e1e1;background-color:#fff;vertical-align:middle;}

/* 데이터 조회 결과 */
.reportTable {width: 60%;display: inline-flex;}

.reportTitle {background-color:#80808026;padding-top:5px;border-bottom:1px solid #80808085}
.reportContent {padding-top:5px;border-bottom:1px solid #80808085}
.reportRow {height: 40px;}
</style>
<body class="fixed-header desktop">  

<jsp:include page="common/navigation.jsp" />
<!-- 상단 메뉴 -->
<div class="page-container ">
	<div class="page-content-wrapper">
		<div class="container-fluid">
			<div class="content">
			
				<div class="card-title" style="display:block;text-align:left;">
					<div class="row">
						<div class="col-md-2">
						</div>
						
					    <div class="col-md-3 mb-3">
							<span class="span_title  fl">일매출리포트 &nbsp;</span>
							<input class="form-control fl" type="date" id="searchDt" style="width:200px;">
						</div>
						<div class="col-md-5">
							<button type="button" class="btn_admin btn_send" id="btnCloseSms" data-toggle="modal" data-target="#closeSmsModal" data-whatever="@mdo" style="float:right;width:120px">
								마감문자
							</button>
							<button type="button" class="btn_admin" id="btnCancel" onclick="cancelCloseDailySales()" style="float:right;">
								마감취소
							</button>
							<button type="button" class="btn_admin" id="btnClose" onclick="fnExcelUpload()" style="float:right;">
								마감
							</button>
							
							<div style="width:100px;float:right" id="btnReadExcel">
								<span class="btnExcelUpload" onclick="readDailyReportExcel()">불러오기</span>
							</div>
							
							<form name="excelUpForm" id="excelUpForm" enctype="multipart/form-data" method="POST" >
								<div style="float:right">
								  	<span class="orangeRed">&nbsp;&nbsp;&nbsp;</span><span class="title"></span>
									<input type="text" class="fileName" id="attachFileName2" style="font-size: 15px" readonly="readonly">
									<label for="uploadbtn" class="file_btn">파일선택</label>
									<input type="file" id="uploadbtn" name="excelFile" class="uploadBtn">
								</div>
							</form>
							
							<!-- 
							<div style="width:100px;float:right" id="btnReadExcel">
								<span class="btnExcelUpload" onclick="readDailyReportExcel()">불러오기</span>
							</div>
							
							<form name="excelUpForm" id="excelUpForm" enctype="multipart/form-data" method="POST" >
								<div class="file_cus" style="width:400px;float:right">
									<label>
									<input type="file" id="excelFile" name="excelFile">
									<span class="file_name">파일을 선택해주세요.</span>
									<span class="file_btn">파일선택</span>
									</label>
								</div>
							</form>  -->
						</div>
						
						
						<div class="col-md-2">
						</div>
					</div>
				</div>			
			
				<div  style="width: 100%;text-align: center;">
					 
					<div class="row mt-3 reportTable" id="reportTable">
						<div class="col-12">
							<div class="row reportRow" style="border-top : 1px solid #80808085;">
								<div class="col-3 reportTitle">마감일자</div>
								<div class="col-3 reportContent"><span id="closeDate"></span></div>
								
								<div class="col-3 reportTitle">일 판매객실수</div>
								<div class="col-3 reportContent"><span id="dailyRoomSalesCnt"></span></div>
								
							</div>
							<div class="row reportRow">
								<div class="col-3 reportTitle">당일 매출액 목표</div>
								<div class="col-3 reportContent"><span id="dailySalesTarget"></span></div>
								
								<div class="col-3 reportTitle">당일 매출액 실적</div>
								<div class="col-3 reportContent"><span id="dailySalesActual"></span></div>
							</div>
							<div class="row reportRow">
								<div class="col-3 reportTitle">객실매출</div>
								<div class="col-3 reportContent"><span id="roomSales"></span></div>
								
								<div class="col-3 reportTitle">객실단가</div>
								<div class="col-3 reportContent"><span id="roomPrice"></span></div>
							</div>
							<div class="row reportRow">
								<div class="col-3 reportTitle">식음매출</div>
								<div class="col-3 reportContent"><span id="restaurantSales"></span></div>
								
								<div class="col-3 reportTitle">기타매출</div>
								<div class="col-3 reportContent"><span id="etcSales"></span></div>
								
							</div>	
							<div class="row reportRow">
								<div class="col-3 reportTitle">당월실적</div>
								<div class="col-3 reportContent"><span id="monthSales"></span></div>
								<!-- 
								<div class="col-3 reportTitle">연간실적</div>
								<div class="col-3 reportContent"><span id="yearlyTotalPerformance"></span></div>
								 -->		
								<div class="col-3 reportTitle"></div>
								<div class="col-3 reportContent"><span id=""></span></div>
							</div>	
						</div>
					</div>	
							
					<div class="reportNoData" id="reportNoData" style="text-align: center;width: 100%">
						마감 데이터가 없습니다.
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
let smsTable;

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

	$('#uploadbtn').change(function () {
		var fileValue = $("#uploadbtn").val().split("\\");
		var fileName = fileValue[fileValue.length-1];

		$("#attachFileName2").val(fileName);
	});
	
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
		$('#dailyRoomSalesCnt').text(setCountCell(reportData.dailyRoomSalesCnt));
		$('#dailySalesTarget').text(setAmountCell(reportData.dailySalesTarget));
		$('#dailySalesActual').text(setAmountCell(reportData.dailySalesActual));
		$('#roomSales').text(setAmountCell(reportData.roomSales));
		$('#roomPrice').text(setAmountCell(reportData.roomPrice));
		$('#restaurantSales').text(setAmountCell(reportData.restaurantSales));
		$('#etcSales').text(setAmountCell(reportData.etcSales));
		$('#monthSales').text(setAmountCell(reportData.monthSales));
		//$('#yearlyTotalPerformance').text(setAmountCell(reportData.yearlyTotalPerformance));
		
		if (reportData.closeYn == 'Y') {

	   		$('#btnClose').hide();
	   		$('#btnCancel').show();
	   		$('#btnSms').show();
	   		$('#btnCloseSms').show();
	   		
	   		// 마감문자 포맷에 사용되는 값 세팅 
	   		mCloseDate = reportData.closeDate;
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
		
   		$('#reportNoData').css('display', 'none');
   		$('#reportTable').css('display', '');

   		$('#btnReadExcel').css('display', 'none');
   		$('#excelUpForm').css('display', 'none');
	
	} else {
		// 데이터 없을때
		
		$('#closeDate').text("");
		$('#dailyRoomSalesCnt').text("");
		$('#dailySalesTarget').text("");
		$('#dailySalesActual').text("");
		$('#roomSales').text("");
		$('#roomPrice').text("");
		$('#restaurantSales').text("");
		$('#etcSales').text("");
		$('#monthSales').text("");
		//$('#yearlyTotalPerformance').text("");
		
   		$('#btnClose').hide();
   		$('#btnCancel').hide();
   		$('#btnSms').hide();
   		$('#btnCloseSms').hide();
   		
   		$('#reportNoData').css('display', '');
   		$('#reportTable').css('display', 'none');
   		
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
	let closeDate = data.substring(0, 4) + "-" + data.substring(4, 6) + "-" + data.substring(6, 8); 
	return closeDate;
}

// 엑셀데이터 읽어오기
function readDailyReportExcel() {

	var searchDate = $('#searchDt').val().replaceAll("-", "");

    var formData = new FormData($('#excelUpForm')[0]);

    $.ajax({
        url: '/report/readDailyReportExcel',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function(data) {
        	
            if(data.code == "0000") {
				let rData = data.data;
            	
            	if (searchDate != rData.closeDate) {
            		alert("마감날짜와 매출리포트날짜가 상이합니다. 확인해 주세요.");
            		return;
            	}

           		$('#btnClose').show();
            	initDailyReportTable(rData);
            	
            } else if(data.code == "9999") {
            	alert(data.message);
            } 
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });
    
}


// 마감(엑셀업로드)
function fnExcelUpload() {
	
    var formData = new FormData($('#excelUpForm')[0]);

    $.ajax({
        url: '/report/uploadDailyReport',
        type: 'POST',
        data: formData,
        contentType: false,
        processData: false,
        success: function(data) {
        	
            if(data.code == "0000") {
            	alert('마감되었습니다.');
            	
    	   		$('#btnClose').hide();
    	   		$('#btnCancel').show();
    	   		$('#btnSms').show();
    	   		$('#btnCloseSms').show();
    	   		
    	   		$('#attachFileName2').val('');
    	   		
            } else if(data.code == "9999") {
            	alert(data.message);
            } 
        },
        error: function(xhr, status, error) {
            console.error('Error:', error);
        }
    });

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

