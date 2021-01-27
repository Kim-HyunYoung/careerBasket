package cb.search;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class HireInfo {
	private int id;
	private String companyName;
	private String hireTitle;
	private String position;
	private int hireCareer;
	private String education;
	private String workType;
	private long salary;
	private String workPlace;
	private String detailImg;
	private String logoImg; //얘 나중에 추가함
	
	//@DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime startDate;
	
	//@DateTimeFormat(pattern = "yyyy-MM-dd'T'HH:mm")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime endDate;
	
	public HireInfo() {}

	public HireInfo(int id, String companyName, String hireTitle, String position, int hireCareer, String education,
			String workType, long salary, String workPlace, String detailImg, String logoImg, LocalDateTime startDate,
			LocalDateTime endDate) {
		super();
		this.id = id;
		this.companyName = companyName;
		this.hireTitle = hireTitle;
		this.position = position;
		this.hireCareer = hireCareer;
		this.education = education;
		this.workType = workType;
		this.salary = salary;
		this.workPlace = workPlace;
		this.detailImg = detailImg;
		this.logoImg = logoImg;
		this.startDate = startDate;
		this.endDate = endDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getHireTitle() {
		return hireTitle;
	}

	public void setHireTitle(String hireTitle) {
		this.hireTitle = hireTitle;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public int getHireCareer() {
		return hireCareer;
	}

	public void setHireCareer(int hireCareer) {
		this.hireCareer = hireCareer;
	}

	public String getEducation() {
		return education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	public String getWorkType() {
		return workType;
	}

	public void setWorkType(String workType) {
		this.workType = workType;
	}

	public long getSalary() {
		return salary;
	}

	public void setSalary(long salary) {
		this.salary = salary;
	}

	public String getWorkPlace() {
		return workPlace;
	}

	public void setWorkPlace(String workPlace) {
		this.workPlace = workPlace;
	}

	public String getDetailImg() {
		return detailImg;
	}

	public void setDetailImg(String detailImg) {
		this.detailImg = detailImg;
	}

	public String getLogoImg() {
		return logoImg;
	}

	public void setLogoImg(String logoImg) {
		this.logoImg = logoImg;
	}

	public LocalDateTime getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDateTime startDate) {
		this.startDate = startDate;
	}

	public LocalDateTime getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDateTime endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "HireInfo [id=" + id + ", companyName=" + companyName + ", hireTitle=" + hireTitle + ", position="
				+ position + ", hireCareer=" + hireCareer + ", education=" + education + ", workType=" + workType
				+ ", salary=" + salary + ", workPlace=" + workPlace + ", detailImg=" + detailImg + ", logoImg="
				+ logoImg + ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}

	
}
