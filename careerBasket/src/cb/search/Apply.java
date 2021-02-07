package cb.search;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Apply {
	//지원 현황 데이터
	
	private int id; //채용공고 id
	private String hireTitle;
	private String companyName;
	private String title;
	private int resumeId;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul") 
	private LocalDateTime applyDate;
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	private LocalDateTime endDate;

	public Apply() {}

	public Apply(int id, String hireTitle, String companyName, String title, int resumeId, LocalDateTime applyDate,
			LocalDateTime endDate) {
		super();
		this.id = id;
		this.hireTitle = hireTitle;
		this.companyName = companyName;
		this.title = title;
		this.resumeId = resumeId;
		this.applyDate = applyDate;
		this.endDate = endDate;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getHireTitle() {
		return hireTitle;
	}

	public void setHireTitle(String hireTitle) {
		this.hireTitle = hireTitle;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getResumeId() {
		return resumeId;
	}

	public void setResumeId(int resumeId) {
		this.resumeId = resumeId;
	}

	public LocalDateTime getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(LocalDateTime applyDate) {
		this.applyDate = applyDate;
	}

	public LocalDateTime getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDateTime endDate) {
		this.endDate = endDate;
	}

	@Override
	public String toString() {
		return "Apply [id=" + id + ", hireTitle=" + hireTitle + ", companyName=" + companyName + ", title=" + title
				+ ", resumeId=" + resumeId + ", applyDate=" + applyDate + ", endDate=" + endDate + "]";
	}
	
	

}
