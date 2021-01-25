package cb.resume;

public class Career {

	private int careerId;
	private int resumeId;
	private String company;
	private String careerPeriod;
	private String careerPosition;
	private long careerSalary;
	private String description;
	public Career() {}
	public Career(int careerId, int resumeId, String company, String careerPeriod, String careerPosition, long careerSalary,
			String description) {
		super();
		this.careerId = careerId;
		this.resumeId = resumeId;
		this.company = company;
		this.careerPeriod = careerPeriod;
		this.careerPosition = careerPosition;
		this.careerSalary = careerSalary;
		this.description = description;
	}
	public int getCareerId() {
		return careerId;
	}
	public void setCareerId(int careerId) {
		this.careerId = careerId;
	}
	public int getResumeId() {
		return resumeId;
	}
	public void setResumeId(int resumeId) {
		this.resumeId = resumeId;
	}
	public String getCompany() {
		return company;
	}
	public void setCompany(String company) {
		this.company = company;
	}
	public String getCareerPeriod() {
		return careerPeriod;
	}
	public void setCareerPeriod(String careerPeriod) {
		this.careerPeriod = careerPeriod;
	}
	public String getCareerPosition() {
		return careerPosition;
	}
	public void setCareerPosition(String careerPosition) {
		this.careerPosition = careerPosition;
	}
	public long getCareerSalary() {
		return careerSalary;
	}
	public void setCareerSalary(long careerSalary) {
		this.careerSalary = careerSalary;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString() {
		return "Career [careerId=" + careerId + ", resumeId=" + resumeId + ", company=" + company + ", careerPeriod="
				+ careerPeriod + ", careerPosition=" + careerPosition + ", careerSalary=" + careerSalary + ", description=" + description + "]";
	}
	
	
	
	
}
