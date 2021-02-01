package cb.signUp;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

@Mapper
public interface UserMapper {
	
	//id 중복인지 조회하기
	@Select("select count(*) from sign_up where user_id=#{userId}")
	public int dupIdCheck(String userId);
	
	//이름 있는지 조회
	@Select("select count(*) from sign_up where name=#{name}")
	public int nameCheck(String name);
	
	//email 중복인지 조회
	@Select("select count(*) from sign_up where email=#{email}")
	public int dupEmailCheck(String email);
	
	//회원가입한 유저 테이블에 추가
	@Insert("insert into sign_up(user_id, password, name, birth_date, sex, email, tel, address) values(#{userId}, #{password}, #{name}, #{birthDate}, #{sex}, #{email}, #{tel}, #{address})")
	public int addUser(User user);
	
	//구글 로그인 정보 테이블에 추가(아이디, 이메일만 넣기)
	@Insert("insert into sign_up(user_id, email) values(#{userId}, #{email})")
	public int addSnsInfo(@Param("userId")String userId, @Param("email")String email);
	
	//로그인 할때 조회
	//함수에 파라미터가 2개이상이면 @Param을 붙혀줘야한다.
	@Select("select count(*) from sign_up where user_id=#{userId} and password=#{password}")
	public int login(@Param("userId")String userId, @Param("password")String password);
	
	//아이디 찾는데 없을 경우를 위해(nullPointerException 때문)
	@Select("select count(user_id) from sign_up where name=#{name} and email=#{email}")
	public int countfindId(@Param("name")String name, @Param("email")String email);
	
	//아이디 찾기
	@Select("select user_id from sign_up where name=#{name} and email=#{email}")
	public String findId(@Param("name")String name, @Param("email")String email);
	
	//조건(아이디, 이름)에 맞는 이메일 있는지 확인
	@Select("select email from sign_up where user_id=#{userId} and name=#{name}")
	public String findEmail(@Param("userId")String userId, @Param("name")String name);
	
	//아이디랑 이름이랑 정보가 맞지 않을때
	@Select("select count(*) from sign_up where user_id=#{userId} and name=#{name}")
	public int SameIdName(@Param("userId")String userId, @Param("name")String name);
	
	//아이디랑 이메일이랑 정보가 맞지 않을 때
	@Select("select count(*) from sign_up where user_id=#{userId} and email=#{email}")
	public int SameIdEmail(@Param("userId")String userId, @Param("email")String email);
	
	//이름이랑 이메일이랑 정보가 맞지 않을 때
	@Select("select count(*) from sign_up where name=#{name} and email=#{email}")
	public int SameNameEmail(@Param("name")String name, @Param("email")String email);
	
	//비밀번호 변경
	@Update("update sign_up set password=#{password} where email=#{email} and name=#{name} and user_id=#{userId}")
	public int changePw(@Param("password")String password, @Param("email")String email, @Param("name")String name, @Param("userId")String userId);

}
