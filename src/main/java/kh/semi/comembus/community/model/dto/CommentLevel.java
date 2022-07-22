package kh.semi.comembus.community.model.dto;

/**
 * 댓글 COMMENT
 * 답글 REPLY
 * 
 * */
public enum CommentLevel {
	COMMENT(1), REPLY(2);
	
	private int value;
	
	//생성자(enum의 생성자는 접근제한자 X) 호출코드 
	CommentLevel(int value){
		this.value = value;
	}
	
	public int getValue() {
		return this.value;
	}
	
	public static CommentLevel valueOf(int value) {
		switch(value) {
		case 1: return COMMENT;
		case 2: return REPLY;
		default : throw new AssertionError("Unknown CommentLevel : "+value);
		}
	}
}
