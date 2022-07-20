package kh.semi.comembus.ws.endpoint;

import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.EndpointConfig;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.gson.Gson;

import kh.semi.comembus.ws.config.WebSocketConfigurator;

@ServerEndpoint(value = "/comembus", configurator = WebSocketConfigurator.class)
public class WebSocket {
	private static Map<String, Session> clientMap = Collections.synchronizedMap(new HashMap<>());

	@OnOpen
	public void onOpen(EndpointConfig config, Session session) {
		Map<String, Object> userProperties = config.getUserProperties();
		String memberId = (String) userProperties.get("memberId");
		
		//@OnClose용 
		Map<String, Object> sessionUserProperties = session.getUserProperties();
		sessionUserProperties.put("memberId", memberId);
		
		addToClientMap(memberId, session);

	}
	
	@OnMessage
	public void onMessage(String msg, Session session){
		Map<String, Object> msgMap = new Gson().fromJson(msg, Map.class);
		MessageType messageType = MessageType.valueOf((String) msgMap.get("messageType"));
		
		switch(messageType) {
		case NEW_COMMENT:
		case NEW_APPLICANT:
		case APPLY_RESULT:
			Map<String, Object> data = (Map<String, Object>) msgMap.get("data");
			
		}
	}
	private static void addToClientMap(String memberId, Session session) {
		clientMap.put(memberId, session);
	}
	
	private static void removeFromClientMap(String memberId) {
		clientMap.remove(memberId);
	}
	
	public static boolean isConnected(String receiver) {
		return clientMap.containsKey(receiver);
	}
	
	public static void sendMessage(MessageType messageType, Map<String, Object>data) {
		String receiver = (String) data.get("receiver");
		Session session = clientMap.get(receiver);
		if(session != null) {
			Basic basic = session.getBasicRemote();
			try {
				basic.sendText(msgToJson(messageType, data));
			}catch(IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	private static String msgToJson(MessageType messageType, Map<String, Object>data) {
		Map<String, Object> map = new HashMap<>();
		map.put("messageType", messageType);
		map.put("data", data);
		map.put("time", System.currentTimeMillis());
		return new Gson().toJson(map);
	}
}
