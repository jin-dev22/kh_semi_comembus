
const ws = new WebSocket(`ws://${location.host}/comembus/ComembusWebSocket`); 

ws.addEventListener('open', (e) => console.log('open : ', e));
ws.addEventListener('error', (e) => console.log('error : ', e));
ws.addEventListener('close', (e) => console.log('close : ', e));
ws.addEventListener('message', (e) => {
	console.log('message : ', e);
	const {messageType, data : {msg}, time} = JSON.parse(e.data);
	switch(messageType){
		case 'NEW_COMMENT' :
		case 'NEW_APPLICANT' :
		case 'APPLY_RESULT' :
		case 'APPLY_CANCELED':
/*			const wrapper = document.querySelector("#notification");
			const blackBell = wrapper.querySelector("#blackBell");
			const i = document.createElement('i');
			blackBell.style.display = 'none';
			i.style.color = 'red';
			i.classList.add('fa-solid', 'fa-bell', 'bell');
			i.addEventListener('click', () => {
				alert(msg);
				i.remove();
				blackBell.style.display = 'inline-block';
			});
			wrapper.append(i);
*/
			break;
	}
	
		
});