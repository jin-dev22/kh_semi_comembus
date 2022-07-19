package kh.semi.comembus.gathering.model.dto;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class GatheringExt extends Gathering{
	private int attachCount;
	private List<Attachment> attachments = new ArrayList<>();
	private int commentCount;
	
	public GatheringExt() {
		super();
	}

	public GatheringExt(int psNo, String writer, GatheringType psType, String title, Date regDate, String content,
			int viewcount, int bookmark, String topic, String local, int people, Status status, Date startDate, Date endDate) {
		super(psNo, writer, psType, title, regDate, content, viewcount, bookmark, topic, local, people, status,startDate,endDate);
		// TODO Auto-generated constructor stub
	}

	public int getAttachCount() {
		return attachCount;
	}

	public void setAttachCount(int attachCount) {
		this.attachCount = attachCount;
	}

	public List<Attachment> getAttachments() {
		return attachments;
	}

	public void setAttachments(List<Attachment> attachments) {
		this.attachments = attachments;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	@Override
	public String toString() {
		return "GatheringExt [attachCount=" + attachCount + ", attachments=" + attachments + ", toString()="+super.toString() + "]";
	}

	public void addAttachment(Attachment attach) {
		this.attachments.add(attach);
	}
	
//	
}
