package kh.semi.comembus.community.model.dto;

import java.sql.Timestamp;

public class CommunityRepl {
	private int replNo;
	private String replWriter;
	private int coNo;
	private Timestamp regDate;
	private String content;
	private CommentLevel replLevel;
	private int refReplNo;
	public CommunityRepl() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CommunityRepl(int replNo, String replWriter, int coNo, Timestamp regDate, String content,
			CommentLevel replLevel, int refReplNo) {
		super();
		this.replNo = replNo;
		this.replWriter = replWriter;
		this.coNo = coNo;
		this.regDate = regDate;
		this.content = content;
		this.replLevel = replLevel;
		this.refReplNo = refReplNo;
	}
	public int getReplNo() {
		return replNo;
	}
	public void setReplNo(int replNo) {
		this.replNo = replNo;
	}
	public String getReplWriter() {
		return replWriter;
	}
	public void setReplWriter(String replWriter) {
		this.replWriter = replWriter;
	}
	public int getCoNo() {
		return coNo;
	}
	public void setCoNo(int coNo) {
		this.coNo = coNo;
	}
	public Timestamp getRegDate() {
		return regDate;
	}
	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public CommentLevel getReplLevel() {
		return replLevel;
	}
	public void setReplLevel(CommentLevel replLevel) {
		this.replLevel = replLevel;
	}
	public int getRefReplNo() {
		return refReplNo;
	}
	public void setRefReplNo(int refReplNo) {
		this.refReplNo = refReplNo;
	}
	@Override
	public String toString() {
		return "CommunityRepl [replNo=" + replNo + ", replWriter=" + replWriter + ", coNo=" + coNo + ", regDate="
				+ regDate + ", content=" + content + ", replLevel=" + replLevel + ", refReplNo=" + refReplNo + "]";
	}
	
	
}
