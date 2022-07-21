package kh.semi.comembus.alert.model.dto;

import kh.semi.comembus.ws.endpoint.MessageType;

public class Alert {
	private int alertNo;
	private String receiverId;
	private int psNo;
	private int replNo;
	private MessageType messageType;
	private String content;
	private IsRead isRead;
	
	public Alert() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * 모임게시글 관련 알림시 replNo = null, 댓글알림시 psNo = null
	 */
	public Alert(int alertNo, String receiverId, int psNo, int replNo, MessageType messageType, String content,
			IsRead isRead) {
		super();
		this.alertNo = alertNo;
		this.receiverId = receiverId;
		this.psNo = psNo;
		this.replNo = replNo;
		this.messageType = messageType;
		this.content = content;
		this.isRead = isRead;
	}

	public int getAlertNo() {
		return alertNo;
	}

	public void setAlertNo(int alertNo) {
		this.alertNo = alertNo;
	}

	public String getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	public int getPsNo() {
		return psNo;
	}

	public void setPsNo(int psNo) {
		this.psNo = psNo;
	}

	public int getReplNo() {
		return replNo;
	}

	public void setReplNo(int replNo) {
		this.replNo = replNo;
	}

	public MessageType getMessageType() {
		return messageType;
	}

	public void setMessageType(MessageType messageType) {
		this.messageType = messageType;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public IsRead getIsRead() {
		return isRead;
	}

	public void setIsRead(IsRead isRead) {
		this.isRead = isRead;
	}

	@Override
	public String toString() {
		return "Alert [alertNo=" + alertNo + ", receiverId=" + receiverId + ", psNo=" + psNo + ", replNo=" + replNo
				+ ", messageType=" + messageType + ", content=" + content + ", isRead=" + isRead + "]";
	}

	
}
