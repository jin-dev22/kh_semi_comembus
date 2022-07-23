package kh.semi.comembus.gathering.model.dto;

public class ProjectMemberDept {
	
	private int psNo;
	private String planning;
	private String design;
	private String frontend;
	private String backend;
	private int planning_cnt;
	private int design_cnt;
	private int frontend_cnt;
	private int backend_cnt;
	
	public ProjectMemberDept() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public ProjectMemberDept(int psNo, String planning, String design, String frontend, String backend,
			int planning_cnt, int design_cnt, int frontend_cnt, int backend_cnt) {
		super();
		this.psNo = psNo;
		this.planning = planning;
		this.design = design;
		this.frontend = frontend;
		this.backend = backend;
		this.planning_cnt = planning_cnt;
		this.design_cnt = design_cnt;
		this.frontend_cnt = frontend_cnt;
		this.backend_cnt = backend_cnt;
	}

	public int getPsNo() {
		return psNo;
	}

	public void setPsNo(int psNo) {
		this.psNo = psNo;
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
	
	
	
}
