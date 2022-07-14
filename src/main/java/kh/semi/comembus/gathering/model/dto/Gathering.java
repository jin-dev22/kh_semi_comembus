package kh.semi.comembus.gathering.model.dto;

import java.sql.Date;

public class Gathering {
	private int psNo;
	private String writer;
	private GatheringType psType;
	private String title;
	private Date regDate;
	private String content;
	private int viewcount;
	private int bookmark;
	private String topic;
	private String local;	
	private int people;
	private Status status;
	
	public Gathering() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Gathering(int psNo, String writer, GatheringType psType, String title, Date regDate, String content, int viewcount,
			int bookmark, String topic, String local, int people, Status status) {
		super();
		this.psNo = psNo;
		this.writer = writer;
		this.psType = psType;
		this.title = title;
		this.regDate = regDate;
		this.content = content;
		this.viewcount = viewcount;
		this.bookmark = bookmark;
		this.topic = topic;
		this.local = local;
		this.people = people;
		this.status = status;
	}

	public int getPsNo() {
		return psNo;
	}

	public void setPsNo(int psNo) {
		this.psNo = psNo;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public GatheringType getPsType() {
		return psType;
	}

	public void setPsType(GatheringType psType) {
		this.psType = psType;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getViewcount() {
		return viewcount;
	}

	public void setViewcount(int viewcount) {
		this.viewcount = viewcount;
	}

	public int getBookmark() {
		return bookmark;
	}

	public void setBookmark(int bookmark) {
		this.bookmark = bookmark;
	}

	public String getTopic() {
		return topic;
	}

	public void setTopic(String topic) {
		this.topic = topic;
	}

	public String getLocal() {
		return local;
	}

	public void setLocal(String local) {
		this.local = local;
	}

	public int getPeople() {
		return people;
	}

	public void setPeople(int people) {
		this.people = people;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Gathering [psNo=" + psNo + ", writer=" + writer + ", psType=" + psType + ", title=" + title
				+ ", regDate=" + regDate + ", content=" + content + ", viewcount=" + viewcount + ", bookmark="
				+ bookmark + ", topic=" + topic + ", local=" + local + ", people=" + people + ", status=" + status
				+ "]";
	}
	
}
