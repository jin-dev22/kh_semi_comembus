package kh.semi.comembus.alert.model.dto;

/**
 * 커뮤니티 댓글 알림시 커뮤니티 게시글 번호를 저장하기 위해서 작성
 *
 */
public class AlertExt extends Alert{
	private int coNo;
	private String coType;
	private String psType;
		
	
	public String getPsType() {
		return psType;
	}

	public void setPsType(String psType) {
		this.psType = psType;
	}

	public AlertExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AlertExt(int alertNo, String receiverId, int psNo, int replNo, MessageType messageType, String content,
			IsRead isRead) {
		super(alertNo, receiverId, psNo, replNo, messageType, content, isRead);
		// TODO Auto-generated constructor stub
	}

	public int getCoNo() {
		return coNo;
	}

	public void setCoNo(int coNo) {
		this.coNo = coNo;
	}

	@Override
	public String toString() {
		return "AlertExt [coNo=" + coNo + ", coType=" + coType +super.toString() + "]";
	}

	public String getCoType() {
		return coType;
	}

	public void setCoType(String coType) {
		this.coType = coType;
	}

	
	
}
