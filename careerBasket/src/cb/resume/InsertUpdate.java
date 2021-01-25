package cb.resume;

import java.time.LocalDate;
import java.util.Arrays;

import cb.signup.SignUp;

public class InsertUpdate {

	private int resumeId;
	private String userId;
	private int documentId;
	private String title;
	private String finalEducation;
	private String educationName;
	private String period;
	private String[] state;
	private String major;
	private String score;
	private String basicScore;
	private String career;
	private String resumePath;
	private String myinfo;
	private SignUp info;
	private int[] careerId;
	private String[] company;
	private String[] careerPeriod;
	private String[] position;
	private long[] salary;
	private String[] description;
	public InsertUpdate() {}
	public InsertUpdate(int resumeId, String userId, int documentId, String title, String finalEducation,
			String educationName, String period, String[] state, String major, String score, String basicScore,
			String career, String resumePath, String myinfo, SignUp info, int[] careerId, String[] company,
			String[] careerPeriod, String[] position, long[] salary, String[] description) {
		super();
		this.resumeId = resumeId;
		this.userId = userId;
		this.documentId = documentId;
		this.title = title;
		this.finalEducation = finalEducation;
		this.educationName = educationName;
		this.period = period;
		this.state = state;
		this.major = major;
		this.score = score;
		this.basicScore = basicScore;
		this.career = career;
		this.resumePath = resumePath;
		this.myinfo = myinfo;
		this.info = info;
		this.careerId = careerId;
		this.company = company;
		this.careerPeriod = careerPeriod;
		this.position = position;
		this.salary = salary;
		this.description = description;
	}
	public int getResumeId() {
		return resumeId;
	}
	public void setResumeId(int resumeId) {
		this.resumeId = resumeId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public int getDocumentId() {
		return documentId;
	}
	public void setDocumentId(int documentId) {
		this.documentId = documentId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getFinalEducation() {
		return finalEducation;
	}
	public void setFinalEducation(String finalEducation) {
		this.finalEducation = finalEducation;
	}
	public String getEducationName() {
		return educationName;
	}
	public void setEducationName(String educationName) {
		this.educationName = educationName;
	}
	public String getPeriod() {
		return period;
	}
	public void setPeriod(String period) {
		this.period = period;
	}
	public String[] getState() {
		return state;
	}
	public void setState(String[] state) {
		this.state = state;
	}
	public String getMajor() {
		return major;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getBasicScore() {
		return basicScore;
	}
	public void setBasicScore(String basicScore) {
		this.basicScore = basicScore;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}
	public String getResumePath() {
		return resumePath;
	}
	public void setResumePath(String resumePath) {
		this.resumePath = resumePath;
	}
	public String getMyinfo() {
		return myinfo;
	}
	public void setMyinfo(String myinfo) {
		this.myinfo = myinfo;
	}
	public SignUp getInfo() {
		return info;
	}
	public void setInfo(SignUp info) {
		this.info = info;
	}
	public int[] getCareerId() {
		return careerId;
	}
	public void setCareerId(int[] careerId) {
		this.careerId = careerId;
	}
	public String[] getCompany() {
		return company;
	}
	public void setCompany(String[] company) {
		this.company = company;
	}
	public String[] getCareerPeriod() {
		return careerPeriod;
	}
	public void setCareerPeriod(String[] careerPeriod) {
		this.careerPeriod = careerPeriod;
	}
	public String[] getPosition() {
		return position;
	}
	public void setPosition(String[] position) {
		this.position = position;
	}
	public long[] getSalary() {
		return salary;
	}
	public void setSalary(long[] salary) {
		this.salary = salary;
	}
	public String[] getDescription() {
		return description;
	}
	public void setDescription(String[] description) {
		this.description = description;
	}
	@Override
	public String toString() {
		return "InsertUpdate [resumeId=" + resumeId + ", userId=" + userId + ", documentId=" + documentId + ", title="
				+ title + ", finalEducation=" + finalEducation + ", educationName=" + educationName + ", period="
				+ period + ", state=" + Arrays.toString(state) + ", major=" + major + ", score=" + score
				+ ", basicScore=" + basicScore + ", career=" + career + ", resumePath=" + resumePath + ", myinfo="
				+ myinfo + ", info=" + info + ", careerId=" + Arrays.toString(careerId) + ", company="
				+ Arrays.toString(company) + ", careerPeriod=" + Arrays.toString(careerPeriod) + ", position="
				+ Arrays.toString(position) + ", salary=" + Arrays.toString(salary) + ", description="
				+ Arrays.toString(description) + "]";
	}
	
	
}
