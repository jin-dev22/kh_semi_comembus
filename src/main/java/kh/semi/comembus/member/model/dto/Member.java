package kh.semi.comembus.member.model.dto;

import java.sql.Date;

public class Member {
	private String memberId;
	private JobCode jobCode;
	private String nickName;
	private String memberName;
	private String password;
	private String phone;
	private String introduction;
	private MemberRole memberRole;
	private Date enrollDate;
	private Date quitDate;
	private QuitYN quitYN;
	
	public Member() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Member(String memberId, JobCode jobCode, String nickName, String memberName, String password, String phone,
			String introduction, MemberRole memberRole, Date enrollDate, Date quitDate, QuitYN quitYN) {
		super();
		this.memberId = memberId;
		this.jobCode = jobCode;
		this.nickName = nickName;
		this.memberName = memberName;
		this.password = password;
		this.phone = phone;
		this.introduction = introduction;
		this.memberRole = memberRole;
		this.enrollDate = enrollDate;
		this.quitDate = quitDate;
		this.quitYN = quitYN;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public JobCode getJobCode() {
		return jobCode;
	}

	public void setJobCode(JobCode jobCode) {
		this.jobCode = jobCode;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getIntroduction() {
		return introduction;
	}

	public void setIntroduction(String introduction) {
		this.introduction = introduction;
	}

	public MemberRole getMemberRole() {
		return memberRole;
	}

	public void setMemberRole(MemberRole memberRole) {
		this.memberRole = memberRole;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public Date getQuitDate() {
		return quitDate;
	}

	public void setQuitDate(Date quitDate) {
		this.quitDate = quitDate;
	}

	public QuitYN getQuitYN() {
		return quitYN;
	}

	public void setQuitYN(QuitYN quitYN) {
		this.quitYN = quitYN;
	}

	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", jobCode=" + jobCode + ", nickName=" + nickName + ", memberName="
				+ memberName + ", password=" + password + ", phone=" + phone + ", introduction=" + introduction
				+ ", memberRole=" + memberRole + ", enrollDate=" + enrollDate + ", quitDate=" + quitDate + ", quitYN="
				+ quitYN + "]";
	}
	
	
}
