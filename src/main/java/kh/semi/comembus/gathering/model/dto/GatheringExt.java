package kh.semi.comembus.gathering.model.dto;

import java.sql.Date;

public class GatheringExt extends Gathering{
	
	private String planning;
	private String design;
	private String frontend;
	private String backend;
	private int planning_cnt;
	private int design_cnt;
	private int frontend_cnt;
	private int backend_cnt;

	public GatheringExt(int psNo, String writer, GatheringType psType, String title, Date regDate, String content,
			int viewcount, int bookmark, String topic, String local, int people, Status status, Date startDate,
			Date endDate, String planning, String design, String frontend, String backend, int planning_cnt,
			int design_cnt, int frontend_cnt, int backend_cnt) {
		super(psNo, writer, psType, title, regDate, content, viewcount, bookmark, topic, local, people, status,
				startDate, endDate);
		this.planning = planning;
		this.design = design;
		this.frontend = frontend;
		this.backend = backend;
		this.planning_cnt = planning_cnt;
		this.design_cnt = design_cnt;
		this.frontend_cnt = frontend_cnt;
		this.backend_cnt = backend_cnt;
	}

	public GatheringExt(int psNo, String writer, GatheringType psType, String title, Date regDate, String content,
			int viewcount, int bookmark, String topic, String local, int people, Status status, Date startDate,
			Date endDate) {
		super(psNo,writer,psType,title,regDate,content,viewcount,bookmark,topic,local,people,status,startDate,endDate);
	}

	public String getPlanning() {
		return planning;
	}

	public void setPlanning(String planning) {
		this.planning = planning;
	}

	public String getDesign() {
		return design;
	}

	public void setDesign(String design) {
		this.design = design;
	}

	public String getFrontend() {
		return frontend;
	}

	public void setFrontend(String frontend) {
		this.frontend = frontend;
	}

	public String getBackend() {
		return backend;
	}

	public void setBackend(String backend) {
		this.backend = backend;
	}

	public int getPlanning_cnt() {
		return planning_cnt;
	}

	public void setPlanning_cnt(int planning_cnt) {
		this.planning_cnt = planning_cnt;
	}

	public int getDesign_cnt() {
		return design_cnt;
	}

	public void setDesign_cnt(int design_cnt) {
		this.design_cnt = design_cnt;
	}

	public int getFrontend_cnt() {
		return frontend_cnt;
	}

	public void setFrontend_cnt(int frontend_cnt) {
		this.frontend_cnt = frontend_cnt;
	}

	public int getBackend_cnt() {
		return backend_cnt;
	}

	public void setBackend_cnt(int backend_cnt) {
		this.backend_cnt = backend_cnt;
	}
	
	// 선아 현재 모집된 인원 추가 시작
	private int recruited_cnt;
	
	public int getRecruited_cnt() {
		return recruited_cnt;
	}

	public void setRecruited_cnt(int recruited_cnt) {
		this.recruited_cnt = recruited_cnt;
	}

	public GatheringExt(int psNo, String writer, GatheringType psType, String title, Date regDate, String content,
			int viewcount, int bookmark, String topic, String local, int people, Status status, Date startDate,
			Date endDate, String planning, String design, String frontend, String backend, int planning_cnt,
			int design_cnt, int frontend_cnt, int backend_cnt, int recruited_cnt) {
		super(psNo,writer,psType,title,regDate,content,viewcount,bookmark,topic,local,people,status,startDate,endDate);
		this.planning = planning;
		this.design = design;
		this.frontend = frontend;
		this.backend = backend;
		this.planning_cnt = planning_cnt;
		this.design_cnt = design_cnt;
		this.frontend_cnt = frontend_cnt;
		this.backend_cnt = backend_cnt;
		this.recruited_cnt = recruited_cnt;
	}
	// 선아 코드 끝

}
