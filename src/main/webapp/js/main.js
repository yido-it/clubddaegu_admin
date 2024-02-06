/**
* Template Name: EstateAgency - v2.1.0
* Template URL: https://bootstrapmade.com/real-estate-agency-bootstrap-template/
* Author: BootstrapMade.com
* License: https://bootstrapmade.com/license/
*/
(function($) {
  "use strict";

  // Preloader
  $(window).on('load', function() {
    if ($('#preloader').length) {
      $('#preloader').delay(500).fadeOut('slow', function() {
        	$(this).hide();
       	});
    }
  });

  // Back to top button
  $(window).scroll(function() {
    if ($(this).scrollTop() > 100) {
      $('.back-to-top').fadeIn('slow');
    } else {
      $('.back-to-top').fadeOut('slow');
    }
  });
  $('.back-to-top').click(function() {
    $('html, body').animate({
      scrollTop: 0
    }, 500, 'easeInOutExpo');
    return false;
  });

  var nav = $('nav');
  var navHeight = nav.outerHeight();

  /*--/ Carousel owl 메인슬라이드 슬라이드 옵션/--*/
  $('#carousel').owlCarousel({
    loop: true,
    margin: -1,
    items: 1,
    nav: true,  
    navText: ['<i class="fa-solid fa-arrow-left" aria-hidden="true"></i>', '<i class="fa-solid fa-arrow-right" aria-hidden="true"></i>'],
    autoplay: true,
    autoplayTimeout: 5000,
    autoplayHoverPause: false,
    animateOut: 'fadeOut'
  });

  /*--/ Animate Carousel /--*/
  $('.intro-carousel').on('translate.owl.carousel', function() {
    $('.intro-content .intro-title').removeClass('animate__fadeInUp animate__animated').hide();
    $('.intro-content .intro-price').removeClass('animate__fadeInUp animate__animated delay-2s').hide();
    $('.intro-content .intro-title-top, .intro-content .spacial').removeClass('animate__fadeIn animate__animated').hide();
  });

  $('.intro-carousel').on('translated.owl.carousel', function() {
    $('.intro-content .intro-title').addClass('animate__fadeInUp animate__animated').show();
    $('.intro-content .intro-price').addClass('animate__fadeInUp animate__animated').show();
    $('.intro-content .intro-title-top, .intro-content .spacial').addClass('animate__fadeIn animate__animated').show();
  });

  /*--/ Navbar Collapse /--*/
  $('.navbar-toggle-box-collapse').on('click', function() {
    $('body').removeClass('box-collapse-closed').addClass('box-collapse-open');
  });
  $('.close-box-collapse, .click-closed').on('click', function() {
    $('body').removeClass('box-collapse-open').addClass('box-collapse-closed');
    $('.menu-list ul').slideUp(700);
  });

  /*--/ Navbar Menu Reduce /--*/
  $(window).trigger('scroll');
  $(window).bind('scroll', function() {
    var pixels = 50;
    var top = 1200;
    if ($(window).scrollTop() > pixels) {
      $('.navbar-default').addClass('navbar-reduce');
      $('.navbar-default').removeClass('navbar-trans');
    } else {
      $('.navbar-default').addClass('navbar-trans');
      $('.navbar-default').removeClass('navbar-reduce');
    }
    if ($(window).scrollTop() > top) {
      $('.scrolltop-mf').fadeIn(1000, "easeInOutExpo");
    } else {
      $('.scrolltop-mf').fadeOut(1000, "easeInOutExpo");
    }
  });

  /*--/ Property owl /--*/
  $('#property-carousel').owlCarousel({
    loop: true,
    margin: 30,
    responsive: {
      0: {
        items: 1,
      },
      769: {
        items: 2,
      },
      992: {
        items: 3,
      }
    }
  });

  /*--/ Property owl owl /--*/
  $('#property-single-carousel').owlCarousel({
    loop: true,
    margin: 0,
    nav: true,
    navText: ['<i class="fa-solid fa-arrow-left" aria-hidden="true"></i>', '<i class="fa-solid fa-arrow-right" aria-hidden="true"></i>'],
    responsive: {
      0: {
        items: 1,
      }
    }
  });

  /*--/ News owl /--*/
  $('#new-carousel').owlCarousel({
    loop: true,
    margin: 30,
    responsive: {
      0: {
        items: 1,
      },
      769: {
        items: 2,
      },
      992: {
        items: 3,
      }
    }
  });

  /*--/ Testimonials owl /--*/
  $('#testimonial-carousel').owlCarousel({
    margin: 0,
    autoplay: true,
    nav: true,
    animateOut: 'fadeOut',
    animateIn: 'fadeInUp',
    navText: ['<i class="fa-solid fa-arrow-left" aria-hidden="true"></i>', '<i class="fa-solid fa-arrow-right" aria-hidden="true"></i>'],
    autoplayTimeout: 4000,
    autoplayHoverPause: true,
    responsive: {
      0: {
        items: 1,
      }
    }
  });
  
})(jQuery);

// 요일 반환 
function getDate(sDate){ 
    var week = ['일', '월', '화', '수', '목', '금', '토'];
    var dayOfWeek = week[new Date(sDate).getDay()];
    return dayOfWeek;
}

// 오늘 날짜 반환 
function getToDay(separator){
	var today = new Date();   

	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate();  // 날짜
	var day = today.getDay();  // 요일
	
	var realMonth;
	if (month < 10) {
		realMonth = "0" + month;
	} else {
		realMonth = month;
	}
	var realDate;
	if (date < 10) {
		realDate = "0" + date;
	} else {
		realDate = date;
	}
	
	return year + separator + realMonth + separator + realDate;
}


// 현재시간 반환 
function getNowTime(separator){
	var today = new Date();   

	let hours = today.getHours(); // 시
	let minutes = today.getMinutes();  // 분
	let seconds = today.getSeconds();  // 초
	
	var realHours;
	if (hours < 10) {
		realHours = "0" + hours;
	} else {
		realHours = hours;
	}
	
	var realMinutes;
	if (minutes < 10) {
		realMinutes = "0" + minutes;
	} else {
		realMinutes = minutes;
	}
	
	var realSeconds;
	if (seconds < 10) {
		realSeconds = "0" + seconds;
	} else {
		realSeconds = seconds;
	}
	
	
	return realHours + separator + realMinutes + separator + realSeconds;
}


//내일 날짜 반환 
function getToTomorrow(separator){
	var today = new Date();   

	var year = today.getFullYear(); // 년도
	var month = today.getMonth() + 1;  // 월
	var date = today.getDate() + 1;  // 날짜
	var day = today.getDay();  // 요일
	
	var realMonth;
	if (month < 10) {
		realMonth = "0" + month;
	} else {
		realMonth = month;
	}
	var realDate;
	if (date < 10) {
		realDate = "0" + date;
	} else {
		realDate = date;
	}
	
	return year + separator + realMonth + separator + realDate;
}

function searchDate(value) {
	var endDt = new Date(getToDay("-"));
	var strtDt = new Date(getToDay("-"));
	
	switch(value) {
		case '1' : 
			// 1개월전
			strtDt.setMonth(strtDt.getMonth() - 1);
			strtDt = dateFormatter(strtDt, endDt);
			break;
		case '3' :
			// 3개월 전 
			strtDt.setMonth(strtDt.getMonth() - 3);
			strtDt = dateFormatter(strtDt, endDt);
			break;
		case '6' : 
			// 6개월 전
			strtDt.setMonth(strtDt.getMonth() - 6);
			strtDt = dateFormatter(strtDt, endDt);
			break;
	}
	
	return strtDt;
} 

function dateFormatter(newDay, today) {
	var year = newDay.getFullYear();
	var month = newDay.getMonth() + 1;
	var date = newDay.getDate();
	
	if (today) {
		var todayDate = today.getDate();
		if (date != todayDate) {
			if (month == 0) year -=1;
			month = (month + 11) % 12;
			date = new Date(year, month, 0).getDate();
		}
	}
	month = ("0"+month).slice(-2);
	date = ("0"+date).slice(-2);
	
	return year + "-" + month + "-" + date;
}

// 날짜 문자열로 반환 
function getStringDt(date, separator){
	
	var returnValue = "";
	
	var strtYear 	= date.getFullYear(); // 년도
	var strtMonth 	= date.getMonth() + 1;  // 월
	var strtDate 	= date.getDate();  // 날짜
	
	var realMonth;
	if (strtMonth < 10) {
		realMonth = "0" + strtMonth;
	} else {
		realMonth = strtMonth;
	}
	var realDate;
	if (strtDate < 10) {
		realDate = "0" + strtDate;
	} else {
		realDate = strtDate;
	}
	
	if (separator != null && separator != '') {
		returnValue = strtYear + separator + realMonth + separator + realDate;
	} else {
		returnValue = strtYear + realMonth + realDate;
	}
	
	return returnValue;
}

function getTimeFormat(data){
	// 3자리로 넘어오면 앞에 0 붙여주기 ( ex : 930 -> 0930)
	
	var sTime = data.toString();
	var returnValue = sTime;
	
	if (sTime.length == 3) {
		returnValue = "0" + sTime;
	} 

	return returnValue;
}

function randomNum(){
    const randomNum = Math.floor(Math.random() * 899 + 100);

    return randomNum;
}

// 모바일 기기 여부 확인
function mobileYn() {
		return /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
}

// input 입력 여부 체크
function chkInputVal (id) {
	// 라벨 텍스트
	var str = $('label[for="' + id + '"]').text();
	
	const charCode = str.charCodeAt(str.length - 1);
    const consonantCode = (charCode - 44032) % 28;
    var msg = '';
    
    if($('#' + id).val() == "" || $('#' + id).val() == null) {
    	if(consonantCode === 0){
	        msg = str + '를 입력해주세요.';
	    } else {	
	        msg = str + '을 입력해주세요.';
	    }
	    
		$('#msg_' + id).hide();
		$('#no_' + id).text(msg).show();
	    scrollToInput(id);
	    return false;
	}
	$('#no_' + id).hide();
	return true;
}

function scrollToInput(id) {
	const el = document.getElementById(id);
	if(el) {
		// 요소의 Y 위치를 가져와서 스크롤 할 위치로 사용
    	const inputPos = el.getBoundingClientRect().top + window.pageYOffset;

    	// 스크롤 애니메이션
    	window.scrollTo({
      		top: inputPos - 150,
      		behavior: "smooth"
    	});
	}
}


// 쿠키 저장하기 
function setCookie(cName, cValue, cDay){
	var expire = new Date();
	expire.setDate(expire.getDate() + cDay);
  
	var cookies = cName + '=' + escape(cValue) + '; path=/ ';
	if(typeof cDay != 'undefined') {
		cookies += ';expires=' + expire.toGMTString() + ';';
	}
	document.cookie = cookies;
}
 
// 쿠키 가져오기
function getCookie(cName) {
	cName = cName + '=';
	var cData = document.cookie;
	var start = cData.indexOf(cName);
	var cValue = '';
	if (start != -1) { // 쿠키가 존재하면
		start += cName.length;
		var end = cValue.indexOf(';', start);
		if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
			end = cValue.length;
            console.log("end위치  : " + end);
		cValue = cValue.substring(start, end);
	}
	return unescape(cValue);
}

// 티켓조회에서 사용하는 함수
function getBookState(sData) {
	var bkState = "";
	
	switch(sData) {
		case '정상' :
			bkState = "결제완료";
			break;
		case '종료' :
			bkState = "취소완료";
			break;
		case '부분취소' :
			bkState = "부분취소";
			break;
		default : 
			bkState = "";
	}
	
	return bkState;
}

// 상태 
function getOnState(onState) {
	var txtState = "";
	
	switch(onState) {
		case 1 :
			txtState = "예약완료";
			break;
		case 2 :
			txtState = "구매취소";
			break;
		case 3 :
			txtState = "사용완료";
			break;
		case 4 :
			txtState = "사용취소";
			break;
		default : 
			txtState = "";
	}
	
	return txtState;
}


//할인금액계산 
//spAmt : 상품금액, dcType : 할인타입, dcAmt : 할인율 또는 할인금액  
function calc(spAmt, dcType, dcAmt) {
	var dcData = new Object();		
	
	switch(dcType) {
		case '0' : 
			// 고정금액	
			break;
			
		case '1' : 
			// 금액할인
			console.log('금액할인 > 상품금액:', spAmt, ', 할인금액  :', dcAmt);
			break;
			
		case '2' : 
			// 퍼센트할인
			console.log('퍼센트할인 > 상품금액:', spAmt, ', 할인율  :', dcAmt);
			
			var savePrice = spAmt * (dcAmt / 100);	// 할인금액
			var resultPrice = spAmt - savePrice;	// 최종금액
			
			dcData.savePrice = savePrice;
			dcData.resultPrice = resultPrice;
			
			console.log('할인처리결과 > dcData:', dcData);
			
			break;
	}
	
	return dcData;
}

// 할인 정책 정보 표출 
// dcType : 할인타입, dcAmt : 할인율 또는 할인금액  
function getDcInfoTxt(dcType, dcAmt) {
	var sDcInfo = ""; 
	
	switch(dcType) {
		case '0' : 
			// 고정금액	
			break;
			
		case '1' : 
			// 금액할인
			sDcInfo = dcAmt + "원 할인";
			break;
			
		case '2' : 
			// 퍼센트할인
			sDcInfo = dcAmt + "% 할인";
			
			break;
	}
	
	return sDcInfo;
}

function toLocaleString(amt, str) {
	if (str == "") {
		return Number(amt).toLocaleString("ko-KR") + "원";
	} else {
		return Number(amt).toLocaleString("ko-KR") + str;
	}
}

/* datatables preloader
$('#grid')
	.on( 'processing.dt', function ( e, settings, processing ) {
		if(processing) {
			$('#searchDt').css('display', 'none');
			$('button').css('display', 'none');				
		} else {
			$('#searchDt').css('display', 'block');
			$('button').css('display', 'block');				
		}
	})
	.on( 'draw.dt', function ( e, settings ) {
		endDtPreloader();
	})*/
	
function startDtPreloader(){
	if ($('page-container > .dataTables_processing').length) {
		$('page-container > .dataTables_processing').show();
	} else {		
		$('.page-container').prepend('<div class="dataTables_processing"><span>Loading...</span></div>');
	}
}

function endDtPreloader(){	
	if ($('.dataTables_processing').length) {
		$('.dataTables_processing').delay(100).fadeOut('slow', function() {
	        $(this).hide();
		});
	}
}

// 소수점 0번째 자리까지 표시
function customRenderCnt(data) {
	var formattedNumber = formatNumberVal(data, 'cnt')
	return formattedNumber;
}

// 천원단위 표시, 소수점 0번째 자리까지 표시
function customRenderAmt(data, type, row) {
	if(type === 'export') return data;
	else {
		var formattedNumber = formatNumberVal(data, 'amt')
		return formattedNumber;
	}
}

/* 천원 단위로 표시, 콤마 표시 */
function formatNumberVal(data, str) {
	if(data != undefined) {
		data = Number(data);
		if(str == 'cnt') {
			return (data/1).toLocaleString('ko-KR');
		} else if(str == 'sms') {
			return data.toLocaleString('ko-KR', { minimumFractionDigits: 0, maximumFractionDigits: 0 });
		} else if(str == 'sms2') {
			return (data / 1000).toLocaleString('ko-KR', { minimumFractionDigits: 0, maximumFractionDigits: 0 });
		} else {   		
	    	return (data / 1000).toLocaleString('ko-KR', { minimumFractionDigits: 1, maximumFractionDigits: 1 })
		}
	} else {
		return '';
	}
}

$(".search_tb").keyup(function () {
	var searchWord = this.value.trim();
	if(searchWord == '') {
		table.clearFilter();
	} else {    		
		table.setFilter(matchAny, {value: searchWord});
	}
 });
 
/* custom filter function */
function matchAny(data, filterParams){
    //data - the data for the row being filtered
    //filterParams - params object passed to the filter
    var result = false;
		
    for(var key in data){
    	var value = data[key] != null? data[key].trim() : null;
    	if(value != null) {
    		if(value.indexOf(filterParams.value) > -1) {	    			
 	    		result = true;	    			
    		}
    	}
    }
    
	return result;
}