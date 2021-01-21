package cb.search;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Company {
	private String companyName;
	private String companyLogo;
	private String companyType;
	//@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private LocalDate startDate;
	private String bossName;
	private String companyAddress;
	
	public Company() {}
	
	public Company(String companyName, String companyLogo, String companyType, LocalDate startDate, String bossName,
			String companyAddress) {
		super();
		this.companyName = companyName;
		this.companyLogo = companyLogo;
		this.companyType = companyType;
		this.startDate = startDate;
		this.bossName = bossName;
		this.companyAddress = companyAddress;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getCompanyLogo() {
		return companyLogo;
	}

	public void setCompanyLogo(String companyLogo) {
		this.companyLogo = companyLogo;
	}

	public String getCompanyType() {
		return companyType;
	}

	public void setCompanyType(String companyType) {
		this.companyType = companyType;
	}

	public LocalDate getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDate startDate) {
		this.startDate = startDate;
	}

	public String getBossName() {
		return bossName;
	}

	public void setBossName(String bossName) {
		this.bossName = bossName;
	}

	public String getCompanyAddress() {
		return companyAddress;
	}

	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}

	@Override
	public String toString() {
		return "Company [companyName=" + companyName + ", companyLogo=" + companyLogo + ", companyType=" + companyType
				+ ", startDate=" + startDate + ", bossName=" + bossName + ", companyAddress=" + companyAddress + "]";
	}
	
	
	
}
