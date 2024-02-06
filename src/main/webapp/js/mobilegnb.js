(function () {
	
	'use strict';

	// iPad and iPod detection	
	var isiPad = function(){
	  return (navigator.platform.indexOf("iPad") != -1);
	}

	var isiPhone = function(){
    return (
      (navigator.platform.indexOf("iPhone") != -1) || 
      (navigator.platform.indexOf("iPod") != -1)
    );
	}

	
	
	$( window ).resize(function() {
		mobileMenu();
	});
	 
	// Mobile Menu Clone ( Mobiles/Tablets )
	var mobileMenu = function() {
		
		
		
		if ( $(window).width() < 769 ) {
			
			
			
			var en = "";
			$('html,body').addClass('fh5co-overflow');
			
			if($("body").hasClass("en")){
				en = "/en";
			}
			
			if ( $('#fh5co-mobile-menu').length < 1 ) {
				
				var clone = $('#fh5co-primary-menu').clone().attr({
					id: 'fh5co-mobile-menu-ul',
					class: ''
				});
				var cloneLogo = $('#fh5co-logo').clone().attr({
					id : 'fh5co-logo-mobile',
					class : ''
				});

			    var link =  document.location.pathname;
				if (link == '/tw' || link.indexOf('/tw/') > 0) {
                    // tw 상단바
                    $('<div id="fh5co-logo-mobile-wrap">').append(cloneLogo).insertBefore('#fh5co-header-section');
                    $('#fh5co-logo-mobile-wrap').append('<a href="#" id="fh5co-mobile-menu-btn"><i class="fa-solid fa-bars"></i></a>'
                            + '<a href="/tw" ><h1 id="fh5co-logo-mobile-logo" class="pull-left"> </h1></a>'
                            + '<a href="/hBook/bookMain/19110001" ></a>'
                    )
                    $('<div id="fh5co-mobile-menu"  style="background:url(/img/main/date_bg9_3.jpg) no-repeat 50% 0;background-size:cover">').append(clone).insertBefore('#fh5co-header-section');
                } else if (link == '/cn' || link.indexOf('/cn/') > 0) {
                    // cn 상단바
                    $('<div id="fh5co-logo-mobile-wrap">').append(cloneLogo).insertBefore('#fh5co-header-section');
                    $('#fh5co-logo-mobile-wrap').append('<a href="#" id="fh5co-mobile-menu-btn"><i class="fa-solid fa-bars"></i></a>'
                            + '<a href="/cn" ><h1 id="fh5co-logo-mobile-logo" class="pull-left"> </h1></a>'
                            + '<a href="/hBook/bookMain/19110001" ></a>'
                    )
                    $('<div id="fh5co-mobile-menu"  style="background:url(/img/main/date_bg9_3.jpg) no-repeat 50% 0;background-size:cover">').append(clone).insertBefore('#fh5co-header-section');

                } else if (link == '/en' || link.indexOf('/en/') > 0) {
                    // en 상단바
                    $('<div id="fh5co-logo-mobile-wrap">').append(cloneLogo).insertBefore('#fh5co-header-section');
                    $('#fh5co-logo-mobile-wrap').append('<a href="#" id="fh5co-mobile-menu-btn"><i class="fa-solid fa-bars"></i></a>'
                            + '<a href="/en" ><h1 id="fh5co-logo-mobile-logo" class="pull-left"> </h1></a>'
                            + '<a href="/hBook/bookMain/19110001" ></a>'
                    )
                    $('<div id="fh5co-mobile-menu"  style="background:url(/img/main/date_bg9_3.jpg) no-repeat 50% 0;background-size:cover">').append(clone).insertBefore('#fh5co-header-section');

                } else if (link == '/jp' || link.indexOf('/jp/') > 0) {
                    // jp 상단바
                    $('<div id="fh5co-logo-mobile-wrap">').append(cloneLogo).insertBefore('#fh5co-header-section');
                    $('#fh5co-logo-mobile-wrap').append('<a href="#" id="fh5co-mobile-menu-btn"><i class="fa-solid fa-bars"></i></a>'
                            + '<a href="/jp" ><h1 id="fh5co-logo-mobile-logo" class="pull-left"> </h1></a>'
                            + '<a href="/hBook/bookMain/19110001" ></a>'
                    )
                    $('<div id="fh5co-mobile-menu"  style="background:url(/img/main/date_bg9_3.jpg) no-repeat 50% 0;background-size:cover">').append(clone).insertBefore('#fh5co-header-section');
                } else {
                    // 일반 홈페이지에서 표출되는 상단바
                    $('<div id="fh5co-logo-mobile-wrap">').append(cloneLogo).insertBefore('#fh5co-header-section');
                    $('#fh5co-logo-mobile-wrap').append('<a href="#" id="fh5co-mobile-menu-btn"><i class="fa-solid fa-bars"></i></a>'
                            + '<a href="/'+en+'" ><h1 id="fh5co-logo-mobile-logo" class="pull-left"> </h1></a>'
                            + '<a href="/hBook/bookMain/19110001" ><h1 class="fr"><i style="margin: 12px;color: #5d2b00;" class="fa-solid fa-calendar-days"></i> </h1></a>'
                    )
                    $('<div id="fh5co-mobile-menu"  style="background:url(/img/main/date_bg9_3.jpg) no-repeat 50% 0;background-size:cover">').append(clone).insertBefore('#fh5co-header-section');
                }

				$('#fh5co-header-section').hide();
				$('#fh5co-logo-mobile-wrap').show();
			} else {
				$('#fh5co-header-section').hide();
				$('#fh5co-logo-mobile-wrap').show();
			}

		} else {

			$('#fh5co-logo-mobile-wrap').hide();
			$('#fh5co-header-section').show();
			$('html,body').removeClass('fh5co-overflow');
			if ( $('body').hasClass('fh5co-mobile-menu-visible')) {
				$('body').removeClass('fh5co-mobile-menu-visible');
			}
		}
	};


	// Parallax
  // var scrollBanner = function () {
  //   var scrollPos = $(this).scrollTop();
  //   console.log(scrollPos);
  //   $('.fh5co-hero-intro').css({
  //     'opacity' : 1-(scrollPos/300)
  //   });
  // }


	// Click outside of the Mobile Menu
	var mobileMenuOutsideClick = function() {
		$(document).click(function (e) {
	    var container = $("#fh5co-mobile-menu, #fh5co-mobile-menu-btn");
	    if (!container.is(e.target) && container.has(e.target).length === 0) {
	      $('body').removeClass('fh5co-mobile-menu-visible');
	    }
		});
	};


	// Mobile Button Click
	var mobileBtnClick = function() {
		// $('#fh5co-mobile-menu-btn').on('click', function(e){
		$(document).on('click', '#fh5co-mobile-menu-btn', function(e){
			e.preventDefault();
			if ( $('body').hasClass('fh5co-mobile-menu-visible') ) {
				$('body').removeClass('fh5co-mobile-menu-visible');	
			} else {
				$('body').addClass('fh5co-mobile-menu-visible');
			}
			
		});
	};


	// Main Menu Superfish
var mainMenu = function() {

		/*$('#fh5co-primary-menu').superfish({
			delay: 0,
			animation: {
				opacity: 'show'
			},
			speed: 'fast',
			cssArrows: true,
			disableHI: true
		});
*/
	};

	// Superfish Sub Menu Click ( Mobiles/Tablets )
	var mobileClickSubMenus = function() {

		$('body').on('click', '.fh5co-sub-ddown', function(event) {
			event.preventDefault();
			var $this = $(this),
				li = $this.closest('li');
			li.find('> .fh5co-sub-menu').slideToggle(200);
		});

	};

	// Window Resize
	var windowResize = function() {
		$(window).resize(function(){
			mobileMenu();
		});

	};

	// Window Scroll 70  ŭ   ũ ѳ        class  ߰ . 70            removeclass
	var windowScroll = function() {
		$(window).scroll(function() {

			var scrollPos = $(this).scrollTop();
			if ( $('body').hasClass('fh5co-mobile-menu-visible') ) {
				$('body').removeClass('fh5co-mobile-menu-visible');
			}

			if ( $(window).scrollTop() > 70 ) {
				$('#fh5co-header-section').addClass('fh5co-scrolled');
			} else {
				$('#fh5co-header-section').removeClass('fh5co-scrolled');
			}


			// Parallax
			$('.fh5co-hero-intro').css({
	      'opacity' : 1-(scrollPos/300)
	    });

		});
	};

	// Fast Click for ( Mobiles/Tablets )
	var mobileFastClick = function() {
		if ( isiPad() && isiPhone()) {
			FastClick.attach(document.body);
		}
	};

	// Easy Repsonsive Tabs
	/*var responsiveTabs = function(){
		
		$('#fh5co-tab-feature').easyResponsiveTabs({
      type: 'default',
      width: 'auto', 
      fit: true, 
      inactive_bg: '',
      active_border_color: '',
      active_content_border_color: '',
      closed: 'accordion',
      tabidentify: 'hor_1'
            
    });
    $('#fh5co-tab-feature-center').easyResponsiveTabs({
      type: 'default',
      width: 'auto',
      fit: true, 
      inactive_bg: '',
      active_border_color: '',
      active_content_border_color: '',
      closed: 'accordion', 
      tabidentify: 'hor_1' 
      
    });
    $('#fh5co-tab-feature-vertical').easyResponsiveTabs({
      type: 'vertical',
      width: 'auto',
      fit: true,
      inactive_bg: '',
      active_border_color: '',
      active_content_border_color: '',
      closed: 'accordion',
      tabidentify: 'hor_1'
    });
	};*/

	// Owl Carousel
	var owlCrouselFeatureSlide = function() {
		
		var owl2 = $('.owl-carousel-2');
		owl2.owlCarousel({
				items: 1,
		    loop: true,
		    margin: 0,
		    lazyLoad: true,
		    responsiveClass: true,
		    nav: true,
		    dots: true,
		    smartSpeed: 500,
		    navText: [
		      "<i class='ti-arrow-left owl-direction'></i>",
		      "<i class='ti-arrow-right owl-direction'></i>"
	     	],
		    responsive: {
		        0: {
		          items: 1,
		          nav: true
		        },
		        600: {
		          items: 1,
		          nav: true,
		        },
		        1000: {
		          items: 1,
		          nav: true,
		        }
	    	}
		});
	};

	// MagnificPopup
	var magnifPopup = function() {
		$('.image-popup').magnificPopup({
			type: 'image',
		  gallery:{
		    enabled:true
		  }
		});
	};

	$(function(){

		mobileFastClick();
	/*	responsiveTabs();*/
		mobileMenu();
		mainMenu();
		/*magnifPopup();*/
		mobileBtnClick();
		mobileClickSubMenus();
		mobileMenuOutsideClick();
	/*	owlCrouselFeatureSlide();*/
		windowResize();
		windowScroll();


	});


}());


 




