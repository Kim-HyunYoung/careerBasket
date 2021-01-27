package cb.signUp;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

//유저 정보를 담을 클래스
public class User {
	private String userId;	//유저 아이디
	private String password;	//비밀번호
	private String name;	//이름
	
	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthDate;	//생일
	private String sex;		//성별
	private String email;	//이메일
	private String tel;		//전화번호
	private String address;		//주소
	
	//기본 생성자
	public User() {}

	public User(String userId, String password, String name, LocalDate birthDate, String sex, String email, String tel,
			String address) {
		super();
		this.userId = userId;
		this.password = password;
		this.name = name;
		this.birthDate = birthDate;
		this.sex = sex;
		this.email = email;
		this.tel = tel;
		this.address = address;
	}

	//getter, setter
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public LocalDate getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(LocalDate birthDate) {
		this.birthDate = birthDate;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", password=" + password + ", name=" + name + ", birthDate=" + birthDate
				+ ", sex=" + sex + ", email=" + email + ", tel=" + tel + ", address=" + address + "]";
	}
	
}
