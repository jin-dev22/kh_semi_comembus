package kh.semi.comembus.gathering.model.dto;

import java.sql.Date;

public class GatheringExt extends Gathering{
	
	private String planning;
	private String design;
	private String frontend;
	private String backend;
	private int planning_cnt;
	private int design_cnt;
	private int frontend_count;
	private int backend_cnt;
	
	public GatheringExt() {
		super();
	}

	public GatheringExt(int psNo, String writer, GatheringType psType, String title, Date regDate, String content,
			int viewcount, int bookmark, String topic, String local, int people, Status status, Date startDate,
			Date endDate) {
		super(psNo,writer,psType,title,regDate,content,viewcount,bookmark,topic,local,people,status,startDate,endDate);
		this.planning = planning;
		this.design = design;
		this.frontend = frontend;
		this.backend = backend;
		this.planning_cnt = planning_cnt;
		this.design_cnt = design_cnt;
		this.frontend_count = frontend_count;
		this.backend_cnt = backend_cnt;
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

	public int getFrontend_count() {
		return frontend_count;
	}

	public void setFrontend_count(int frontend_count) {
		this.frontend_count = frontend_count;
	}

	public int getBackend_cnt() {
		return backend_cnt;
	}

	public void setBackend_cnt(int backend_cnt) {
		this.backend_cnt = backend_cnt;
	}
	
	

}
