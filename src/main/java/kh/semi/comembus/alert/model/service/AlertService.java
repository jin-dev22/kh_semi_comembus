package kh.semi.comembus.alert.model.service;

import java.util.HashMap;
import java.util.Map;

import kh.semi.comembus.community.model.dto.Community;
import kh.semi.comembus.ws.endpoint.MessageType;
import kh.semi.comembus.ws.endpoint.WebSocket;

public class AlertService {
	public int notifyNewComment(Community community) {
		System.out.println("@알림서비스:새댓글");
		int result = 0;
		// db insert
		
		//user alert
		if(WebSocket.isConnected(community.getCoWriter())) {
			System.out.println(">새댓글 알림. 수신자 접속중..");
			Map<String, Object> data = new HashMap<>();
			data.put("receiver", community.getCoWriter());
			data.put("msg", "["+community.getCoTitle()+"] 게시글에 새 댓글이 달렸습니다.");
			
			WebSocket.sendMessage(MessageType.NEW_COMMENT, data);
		}
		return result;
	}
}
