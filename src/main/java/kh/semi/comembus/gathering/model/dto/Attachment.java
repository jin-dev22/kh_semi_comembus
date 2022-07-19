package kh.semi.comembus.gathering.model.dto;

import java.sql.Timestamp;

public class Attachment {
	private int no;
	private int psNo;
	private String originalFilename;
	private String renamedFilename;
	private Timestamp regDate;
	
	public Attachment() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Attachment(int no, int psNo, String originalFilename, String renamedFilename, Timestamp regDate) {
		super();
		this.no = no;
		this.psNo = psNo;
		this.originalFilename = originalFilename;
		this.renamedFilename = renamedFilename;
		this.regDate = regDate;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getpsNo() {
		return psNo;
	}

	public void setpsNo(int psNo) {
		this.psNo = psNo;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public String getRenamedFilename() {
		return renamedFilename;
	}

	public void setRenamedFilename(String renamedFilename) {
		this.renamedFilename = renamedFilename;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	@Override
	public String toString() {
		return "Attachment [no=" + no + ", psNo=" + psNo + ", originalFilename=" + originalFilename
				+ ", renamedFilename=" + renamedFilename + ", regDate=" + regDate + "]";
	}
	
	
	
	
}
