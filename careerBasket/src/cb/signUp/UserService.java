package cb.signUp;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	
	//유저 아이디 중복인지 확인
	public int idCheck(String userId) {
		return userMapper.dupIdCheck(userId);
	}
	
	//이름 있는지 확인
	public int nameCheck(String name) {
		return userMapper.nameCheck(name);
	}
	
	//이메일 중복인지 확인
	public int emailCheck(String email) {
		return userMapper.dupEmailCheck(email);
	}
	
	//유저 추가(회원가입)
	public int addUser(User user) {
		return userMapper.addUser(user);
	}
	
	//소셜 로그인 유저 정보 추가
	public int snsInfoAdd(String userId, String email) {
		return userMapper.addSnsInfo(userId, email);
	}
	
	//로그인
	public int userLogIn(String userId, String password) {
		return userMapper.login(userId, password);
	}
	
	//아이디 찾기 nullpointerException 막기위해 count 해주는 sql문 만듦
	public int countIdFind(String name, String email) {
		return userMapper.countfindId(name, email);
	}
	
	//아이디찾기
	public String idFind(String name, String email) {
		return userMapper.findId(name, email);
	}
	
	//조건(아이디, 이름) 에 맞는 이메일 조회
	public String emailFind(String userId, String name) {
		return userMapper.findEmail(userId, name);
	}
	
	//비밀번호 변경
	public int pwChange(String password, String email) {
		return userMapper.changePw(password, email);
	}
	

}
