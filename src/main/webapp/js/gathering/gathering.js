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

/*const bookmarks = document.querySelectorAll(".ps__bookmark");
[...bookmarks].forEach((bookmark) => {
	bookmark.addEventListener('click', (e) => {
		let mark = e.target;
		if(mark.classList.contains("bookmark-front")){
			mark.style.display = 'none';
			mark.nextElementSibling.style.display = "block";
			// console.log(mark.nextElementSibling);
		} else {
			mark.style.display = 'none';
			mark.previousElementSibling.style.display = "block";
			// console.log(mark.previousElementSibling);
		}
		
	});
	
});*/
