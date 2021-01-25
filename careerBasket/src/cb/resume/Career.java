package cb.resume;

public class Career {

	private int careerId;
	private int resumeId;
	private String company;
	private String careerPeriod;
	private String position;
	private long salary;
	private String description;
	public Career() {}
	public Career(int careerId, int resumeId, String company, String careerPeriod, String position, long salary,
			String description) {
		super();
		this.careerId = careerId;
		this.resumeId = resumeId;
		this.company = company;
		this.careerPeriod = careerPeriod;
		this.position = position;
		this.salary = salary;
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
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public long getSalary() {
		return salary;
	}
	public void setSalary(long salary) {
		this.salary = salary;
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
				+ careerPeriod + ", position=" + position + ", salary=" + salary + ", description=" + description + "]";
	}
	
	
	
	
}
