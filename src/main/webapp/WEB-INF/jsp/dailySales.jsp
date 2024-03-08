<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.clubddaegu_admin.common.utils.Globals" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<jsp:include page="common/head.jsp" />
<style>
.reportContent input {text-align:right}
.bg-highlight {
  background-color: #cd6c5b !important;
  color: #FFF !important;
}

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
						<div class="col-md-12 mb-3">
							<span class="span_title fl">일별마감 &nbsp;</span>
						</div>
					</div>
					
					<div class="row width100">
					    <div class="col-7">
							<input class="form-control fl text-center m-0" type="date" id="searchDt" style="width: 200px;">
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
						
					<div class="row">
						<div class="col-7">
						
							<form id="frmReport" method="post">
						
							<input type="hidden" id="imgUrl" name="imgUrl" value=""/>
							<div class="row mt-3 writeBox" id="reportTable">
								<div class="col-12">
									<div class="row reportRow" style="border-top : 1px solid #80808085;">
										<div class="col-3 reportTitle"><p>마감일자</p></div>
										<div class="col-3 reportContent text-center">
											<p id="viewCloseDate"></p>
											<input type="hidden" name="closeDate" id="closeDate">
										</div>
										
										<div class="col-3 reportTitle"><p>일 판매객실수</p></div>
										<div class="col-3 reportContent">
											<input type="text" id="dailyRoomSalesCnt" name="dailyRoomSalesCnt" onkeyup="setAddComma(this)" />
										</div>
										
									</div>
									<div class="row reportRow">
										<div class="col-3 reportTitle"><p>당일 매출액 목표</p></div>
										<div class="col-3 reportContent">
											<input type="text" id="dailySalesTarget" name="dailySalesTarget" onkeyup="setAddComma(this)" />
										</div>
										
										<div class="col-3 reportTitle"><p>당일 매출액 실적</p></div>
										<div class="col-3 reportContent">
											<input type="text" id="dailySalesActual" name="dailySalesActual" onkeyup="setAddComma(this)" />
										</div>
									</div>
									<div class="row reportRow">
										<div class="col-3 reportTitle"><p>객실매출</p></div>
										<div class="col-3 reportContent">
											<input type="text" id="roomSales" name="roomSales" onkeyup="setAddComma(this)" />
										</div>
										
										<div class="col-3 reportTitle"><p>식음매출</p></div>
										<div class="col-3 reportContent">
											<input type="text" id="restaurantSales" name="restaurantSales" onkeyup="setAddComma(this)" />
										</div>
									</div>
									<div class="row reportRow">
										<div class="col-3 reportTitle"><p>기타매출</p></div>
										<div class="col-3 reportContent">
											<input type="text" id="etcSales" name="etcSales" onkeyup="setAddComma(this)" />
										</div>
										
										<div class="col-3 reportTitle none-data"></div>
										<div class="col-3 reportContent none-data"></div>
									</div>	
									
									<div class="row reportRow">
										<div class="col-3 reportTitle"><p>비고</p></div>
										<div class="col-9 reportContent">
											<textarea rows="2" class="form-control border-0" id="remark" name="remark"></textarea>
										</div>
	
									</div>		
								
									<div class="row" id="selectImage">
										<div class="col-3 reportTitle"><p>이미지</p></div>
										<div class="col-9 reportContent dropzone">
											<button type="button" id="profileUpload" class="btn bg-highlight color-white font-15 dz-message" style="width:100%;">
							                <i class="fa fa-camera"></i> 사진 찾기</button>
										</div>
									</div>
									
									<div class="row" >
										<div class="col" id="reportImage">
										</div>
									</div>	
								</div>
							</div>	
							</form>
						</div>						
					</div>	
				</div>
			</div>
		</div>
	</div>
</div>

<jsp:include page="common/script.jsp" />
<jsp:include page="common/modal.jsp" />
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

Dropzone.autoDiscover = false;
var imgDropzone = new Dropzone('div.dropzone', {
	  autoProcessQueue : true
	, url : '/report/uploadReportImg'
	, method : 'post'
	, maxFiles : 1
	, maxFilesize : 10
	, resizeQueality : 1
	, resizeWidth : 960
	, dictFileTooBig : '{{maxFilesize}}MB 이하로 업로드 해주세요.'
	, paramName : 'file'
	, addRemoveLinks : true
	, acceptedFiles : "image/*"
	, uploadMultiple : false
	, previewTemplate : '<div class="dz-preview px-0 col-6 mb-3 dz-processing dz-image-preview" style="display:none;"></div>'
	, init : function() {
		// 파일 개수 초과
		this.on("maxfilesexceeded", function (file) {
			this.removeAllFiles();
			this.addFile(file);
		});
		// 에러 발생 (ex 파일 용량 초과)
   		this.on("error", function(file, message) { 
   			alert(message);
            this.removeFile(file); 
		});
		// 파일 dropzone area에 올라간 후 (총 업로드 개수 제한)
   		this.on("addedfile", function (file) {
   			if($(".img-area").length >= 1) {
   				this.removeAllFiles();
   				alert('등록된 사진을 먼저 삭제해주세요!');
	   			 /* var params = {
	   				  msImgName : $('.img-area').find('a').data('filename')	
	   				, msImgPath : $('.img-area').find('a').data('filepath')
	   				, msNum : $('#msNum').val()
	   			}
   				deleteProfileImg(params);  */
   			}
   			
   		});
		// 파일 업로드 중
		this.on('sending', function(file, xhr, formData){				
			openModal('loadingModal');
   			formData.append('closeDate', $('#searchDt').val().replaceAll("-", ""));
   		});	
		// 파일 업로드 성공 후
		this.on("success", function(file, res){
			closeModal('loadingModal');
        	if(res.result) {	            	
        		$('#imgUrl').val(res.imgName);
        		$('#reportImage').html("<img src='"+res.imgName+"' style='width:100%'>");
        		this.removeAllFiles();
        		alert('업로드 완료');
        		
        		//initImage();              
			} else {
				alert(res.message);
			}
        });
	}
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

            initDailyReportTable(data);

            $('.loading').css('display', 'none');
        },
        error: function(data) {
            alert(data);
            location.reload();
        }
    });
}
/*
function initImage() {

	$.ajax({
        url: "/report/getDailySalesImage",
        type: "post",
        dataType: 'json',
        data: {
        	closeDate : $('#searchDt').val().replaceAll("-", "")
        	, closeYn : 'N'
        },
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', 
        success: function(data) {
       		
       		if (data.reportImage != null) {
       			console.log('==>',reportImage.imgName);
       			
       			let imgDiv = "";
       			imgDiv += '<div class="img-area px-0 col-6 mb-3" id="reportImage">';
       			imgDiv += '<div class="">';
       			imgDiv += '<div class="dz-image my-2" style="text-align: center">';
       			imgDiv += '<img alt='+reportImage.imgName+'" src='+reportImage.fileURL+' data-dz-thumbnail>';
       			imgDiv += '</div>';
       			imgDiv += '<div class="d-flex mt-1">';
       			imgDiv += '<div class="ml-auto pl-3 text-right">';
       			imgDiv += '	<a class="dz-remove color-red-dark font-14 btn" href="javascript:undefined;" ';
       			imgDiv += '	id='+reportImage.closeDate+' data-filepath='+reportImage.ImgPath+' data-filename='+reportImage.imgName+' data-dz-remove>';
       			imgDiv += '	<i class="fa-regular fa-rectangle-xmark"></i> 삭제';
       			imgDiv += '	</a>';
       			imgDiv += '	</div>';	
       			imgDiv += '</div>';
       			imgDiv += '</div>';
       			
       			$('#reportImage').html(imgDiv);
       		} else {

       			$('#reportImage').html("");
       		}
        },
        error: function(data) {
            alert(data);
        }
    });
}*/
function initDailyReportTable(pData) {
	
	let reportData = pData.dailyReport;
	let monthReport = pData.monthReport;
	let yearReport = pData.yearReport;
	let mPlanData = pData.salesPlanMonth;
	let yPlanData = pData.salesPlanYear;
	let reportImage = pData.reportImage;
	
	console.log('initDailyReportTable > reportData :', reportData);
	console.log('initDailyReportTable > monthReport :', monthReport);
	console.log('initDailyReportTable > yearReport :', yearReport);
	console.log('initDailyReportTable > mPlanData :', mPlanData);
	console.log('initDailyReportTable > yPlanData :', yPlanData);
	console.log('initDailyReportTable > reportImage :', reportImage);
	
	if (reportData != null) {
		// 데이터 있을때

		$('#viewCloseDate').text(setDateCell(reportData.closeDate));
		$('#closeDate').val(reportData.closeDate);
		$('#dailyRoomSalesCnt').val(setCountCell(reportData.dailyRoomSalesCnt));
		$('#dailySalesTarget').val(setCountCell(reportData.dailySalesTarget));
		$('#dailySalesActual').val(setCountCell(reportData.dailySalesActual));
		$('#roomSales').val(setCountCell(reportData.roomSales));
		$('#restaurantSales').val(setCountCell(reportData.restaurantSales));
		$('#etcSales').val(setCountCell(reportData.etcSales));
		$('#remark').val(reportData.remark);
		
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
   		mMonthSales = monthReport.monthSum;  				// 월 실적
   	 
   		console.log('당일 매출액 실적 : ' , mDailySalesActual);
   		mRoomRevenue = mPlanData.roomRevenue == null ? 0 : mPlanData.roomRevenue;	// 월 객실 목표
   		mTotalFood = mPlanData.totalFood == null ? 0 : mPlanData.totalFood;			// 월 식음 목표
   		mTotalOther = mPlanData.totalOther == null ? 0 : mPlanData.totalOther;		// 월 기타 목표

   		mMonthPlan = mRoomRevenue + mTotalFood + mTotalOther; // 월 목표
   		
   		mYearSales = yearReport.yearlySalesActual;	// 연 실적
   		console.log('당월 실적  : ' , mMonthSales);
   		yRoomRevenue = yPlanData.roomRevenue == null ? 0 : yPlanData.roomRevenue;	// 연 객실 목표
   		yTotalFood = yPlanData.totalFood == null ? 0 : yPlanData.totalFood;			// 연 식음 목표
   		yTotalOther = yPlanData.totalOther == null ? 0 : yPlanData.totalOther;		// 연 기타 목표
   		
   		mYearPlan = yRoomRevenue + yTotalFood + yTotalOther;	// 연 목표
   		// end.
   		
   
   		// ┌───────────── 일별마감 이미지 ─────────────┐
   		if (reportImage != null) {
   			$('#reportImage').html('<img alt='+reportImage.imgName+'" src='+reportImage.fileURL+' style="width:100%">');
   			$('#selectImage').css('display', 'none');
   		} else {
   			$('#reportImage').html("");
   			$('#selectImage').css('display', '');
   			
   		}
   		// └───────────── 일별마감 이미지 ─────────────┘
   		 
	
	} else {
		// 데이터 없을때
		
		$('#viewCloseDate').text($('#searchDt').val());
		$('#closeDate').val($('#searchDt').val().replaceAll("-", ""));
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
		
   		$('#reportImage').html("");				// 일별마감 이미지
   		$('#selectImage').css('display', '');
   		$('#imgUrl').val("");

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
	
	if ($('#imgUrl').val() == "") {
		alert('이미지 업로드 먼저 해주세요.');

		return false;
	}
	
    var formData = new FormData($("#frmReport")[0]);
   
	if ($('#dailyRoomSalesCnt').val() == "" || $('#dailySalesTarget').val() == "" || $('#dailySalesActual').val() == "" 
			|| $('#roomSales').val() == "" || $('#restaurantSales').val() == "" || $('#etcSales').val() == "") {
		alert('비고를 제외한 모든 항목을 다 입력해 주세요.');
		return false;
	}
	

	if(confirm('입력한 정보로 마감자료를 등록하시겠습니까?')) {

	    $.ajax({
	        url: '/report/insertDailyReport',
	        type: "post",
	        data:  formData ,
            processData : false,
            contentType : false,
	        success: function(data) {
	        	
	            if(data.code == "0000") {
	            	alert('마감되었습니다.');
	            	
	    	   		$('#btnClose').hide();
	    	   		$('#btnCancel').show();
	    	   		$('#btnSms').show();
	    	   		$('#btnCloseSms').show();
	    	   		
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
});


</script>
</html>

