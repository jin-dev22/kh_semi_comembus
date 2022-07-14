package kh.semi.comembus.member.model.dto;

import java.sql.Date;

public class MemberExt extends Member{
	private int getheringCnt;

	public MemberExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberExt(String memberId, JobCode jobCode, String nickName, String memberName, String password,
			String phone, String introduction, MemberRole memberRole, Date enrollDate, Date quitDate, QuitYN quitYN) {
		super(memberId, jobCode, nickName, memberName, password, phone, introduction, memberRole, enrollDate, quitDate, quitYN);
		// TODO Auto-generated constructor stub
	}

	public int getGetheringCnt() {
		return getheringCnt;
	}

	public void setGetheringCnt(int getheringCnt) {
		this.getheringCnt = getheringCnt;
	}

	@Override
	public String toString() {
		return "MemberExt [getheringCnt=" + getheringCnt + ", toString()=" + super.toString() + "]";
	}
	
}
