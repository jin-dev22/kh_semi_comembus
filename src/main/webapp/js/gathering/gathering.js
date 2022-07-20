console.log("js연결확인");
const swiper = new Swiper('.swiper', {
	slidesPerView: 1,
	spaceBetween: 10,
	centeredSlides: true,
	loop: true,
	autoplay: {
		delay: 3000,
		disableOnInteraction: false
	},
	pagination: {
	    el: '.swiper-pagination',
	    clickable: true
  	},	
	navigation: {
		nextEl: '.swiper-button-next',
		prevEl: '.swiper-button-prev'
	}
});
