package kh.semi.comembus.community.model.dto;

import java.sql.Timestamp;

public class Community {
	private int coNo;
	private String coTitle;
	private String coWriter;
	private String coContent;
	private int coReadcount;
	private Timestamp coRegdate; 
	private int coLike;
	private String coType;
	public Community() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Community(int coNo, String coTitle, String coWriter, String coContent, int coReadcount, Timestamp coRegdate,
			int coLike, String coType) {
		super();
		this.coNo = coNo;
		this.coTitle = coTitle;
		this.coWriter = coWriter;
		this.coContent = coContent;
		this.coReadcount = coReadcount;
		this.coRegdate = coRegdate;
		this.coLike = coLike;
		this.coType = coType;
	}
	public int getCoNo() {
		return coNo;
	}
	public void setCoNo(int coNo) {
		this.coNo = coNo;
	}
	public String getCoTitle() {
		return coTitle;
	}
	public void setCoTitle(String coTitle) {
		this.coTitle = coTitle;
	}
	public String getCoWriter() {
		return coWriter;
	}
	public void setCoWriter(String coWriter) {
		this.coWriter = coWriter;
	}
	public String getCoContent() {
		return coContent;
	}
	public void setCoContent(String coContent) {
		this.coContent = coContent;
	}
	public int getCoReadcount() {
		return coReadcount;
	}
	public void setCoReadcount(int coReadcount) {
		this.coReadcount = coReadcount;
	}
	public Timestamp getCoRegdate() {
		return coRegdate;
	}
	public void setCoRegdate(Timestamp coRegdate) {
		this.coRegdate = coRegdate;
	}
	public int getCoLike() {
		return coLike;
	}
	public void setCoLike(int coLike) {
		this.coLike = coLike;
	}
	public String getCoType() {
		return coType;
	}
	public void setCoType(String coType) {
		this.coType = coType;
	}
	@Override
	public String toString() {
		return "Community [coNo=" + coNo + ", coTitle=" + coTitle + ", coWriter=" + coWriter + ", coContent="
				+ coContent + ", coReadcount=" + coReadcount + ", coRegdate=" + coRegdate + ", coLike=" + coLike
				+ ", coType=" + coType + "]";
	}

	

}

