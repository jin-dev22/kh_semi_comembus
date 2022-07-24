package kh.semi.comembus.member.model.dto;

public class MemberApplicationStatus {
	private String memberId;
	private int psNo;
	private String result;
	
	public MemberApplicationStatus() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public MemberApplicationStatus(String memberId, int psNo, String result) {
		super();
		this.memberId = memberId;
		this.psNo = psNo;
		this.result = result;
	}
	
	public String getMemberId() {
		return memberId;
	}
	
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	
	public int getPsNo() {
		return psNo;
	}
	
	public void setPsNo(int psNo) {
		this.psNo = psNo;
	}
	
	public String getResult() {
		return result;
	}
	
	public void setResult(String result) {
		this.result = result;
	}
	
	@Override
	public String toString() {
		return "MemberApplicationStatus [memberId=" + memberId + ", psNo=" + psNo + ", result=" + result + "]";
	}
	
	
}
