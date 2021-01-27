package cb.signUp;

import java.time.LocalDate;
import java.util.List;
import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;

//메일 전송에 필요한 클래스들
import org.springframework.mail.javamail.JavaMailSender;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cb.resume.Document;
import cb.resume.Resume;
import cb.resume.ResumeService;
import cb.search.HireInfoService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService service;
	@Autowired
	ResumeService resumeService;
	
	@Autowired
	HireInfoService hireService;
	
	//임시 메인 화면
	@GetMapping("/main")
	public String main(@RequestParam("userId")String userId, Model m) {
		m.addAttribute("userId", userId);
		User myInfo = resumeService.selectOneUserId(userId);
		m.addAttribute("info", myInfo);
		int resumeCount = resumeService.resumeCount(userId);
		m.addAttribute("count", resumeCount);
		List<Resume> reList = resumeService.showPreview(userId);
		m.addAttribute("list", reList);
		List<Document> doList = resumeService.selectDoPreView(userId);
//		System.out.println(doList);
		m.addAttribute("doList", doList);
		int applyCnt = hireService.getApplyCnt(userId);
		m.addAttribute("applyCnt", applyCnt);
		return "main";
	}
	
	//네아로 콜백 jsp
	@GetMapping("/callback")
	public String callback() {
		return "callback";
	}
	
	//회원가입 폼 보여주기
	@GetMapping("/signup")
	public String getUserForm() {
		return "signUpForm";
	}
	
	//아이디 중복인지 확인
	@GetMapping("/idCheck")
	public @ResponseBody int idCheck(@RequestParam("userId")String user_Id) {
		return service.idCheck(user_Id);
	}
	
	//이메일 중복인지 확인
	@GetMapping("/emailCheck")
	public @ResponseBody int emailCheck(String email) {
		return service.emailCheck(email);
	}

	//회원가입 폼 정보 가져오기
	@PostMapping("/signup")
	public String signUp(String userId, String password, String rePassword, String name, String birthDate,
			String sex, String emailStart, String emailEnd, String tel, String post, String addr,
			String detailAddr, String extraAddr) {
		
		String email = emailStart + "@" + emailEnd;		//이메일
		String address = post + addr + detailAddr + extraAddr;		//api에서 받은 주소 문자열 하나로 합쳐주기
		User user = new User(userId, rePassword, name, LocalDate.parse(birthDate), sex, email, tel, address);	//user 객체 생성
		
		service.addUser(user);	//user db에 추가
		return "signUpResult";
	}
	
	//로그인 화면
	@GetMapping("/loginForm")
	public String getLogInForm() {
		return "login";
	}
	
	//로그인
	@GetMapping("/login")
	public @ResponseBody int logIn(@RequestParam("userId")String userId, @RequestParam("password")String password, HttpSession session) {
		//로그인 정보 세션에 저장하기.
		session.setAttribute("userId", userId);
		session.setAttribute("password", password);
		return service.userLogIn(userId, password);
	}
	
	//구글 로그인 정보 테이블에 넣기
	@GetMapping("/googleInfo")
	public String addGoogleInfo(@RequestParam("userId")String userId, @RequestParam("email")String email, Model m) {
		if(service.idCheck(userId) != 1) {	//테이블에 정보가 없다면
			service.snsInfoAdd(userId, email);	//아이디, 이메일 정보 추가
			m.addAttribute("id", userId);	
		}else {
			m.addAttribute("id", userId);
		}
		return "main";
	}
	
	//네이버 로그인 정보 테이블에 넣기
	@GetMapping("/naverInfo")
	public String addNaverInfo(@RequestParam("userId")String userId, @RequestParam("email")String email, Model m) {
		if(service.idCheck(userId) != 1) { //테이블에 정보가 없다면
			service.snsInfoAdd(userId, email); //아이디, 이메일 정보 추가
			m.addAttribute("id", userId);
		}else {
			m.addAttribute("id", userId);
		}
		return "main";
	}
	
	//로그아웃
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();	//세션 정보 초기화
		return "home";
		
	}
	
	//아이디 찾기 폼 화면
	@GetMapping("/findIdForm")
	public String findId() {
		return "idFindForm";
	}
	
	//아이디 찾기 폼 데이터 가져와서 아이디 찾기
	@PostMapping("/findId")
	public String idFind(@RequestParam("name")String name, @RequestParam("email")String email, Model m) {
		if(service.countIdFind(name, email) == 1) {		//조건(이름, 이메일)에 맞는 아이디가 있을 때
			String id = service.idFind(name, email);
			String showId = id.substring(0, id.length()-2);		//화면에 아이디 일부분만 보여주기
			
			for(int i = 0; i<id.length()-(id.length()-2); i++) {
				showId = showId + "*";		//아이디 뒷부분 * 붙혀주기
			}
			
			m.addAttribute("userId", showId);		//화면에 출력해주기 위해 model attribute에 담음.
			return "idFindSucc";
		}else{		//조건(이름, 이메일)에 맞는 아이디가 없을 때
			return "idFindFail";
		}
		
	}
	
	//비밀번호 찾기 폼 화면
	@GetMapping("/findPwForm")
	public String findPwForm() {
		return "pwFindForm";
	}
	
	//비밀번호 찾기 이메일 인증
	//조건(아이디, 이름)에 맞는 이메일 있는지 확인
	@PostMapping("/findEmail")
	public String findEmail(@RequestParam("userId")String userId, @RequestParam("name")String name, 
			@RequestParam("email")String email, Model m) {
		
		String findEmail = service.emailFind(userId, name);
		if(findEmail == "" || service.idCheck(userId) == 0 || service.nameCheck(name) == 0 ||
				!findEmail.equals(email)) {		//입력한 정보가 테이블에 없다면
			return "pwFindFail";
		}else{ 
			int idx = findEmail.indexOf("@");	//@ 인덱스 구하기
			String startEmail = findEmail.substring(0, idx);		//이메일 주소 '@' 전까지만 추출
			String endEmail = findEmail.substring(idx, findEmail.length());		//@부터 이메일 주소 끝까지
			
			//이메일 아이디부분 일부분만 출력하기 위해 
			String subSubEmail = startEmail.substring(0, startEmail.length()-4);
			int subEmailLength = subSubEmail.length();	//아이디 일부분만 추출한 문자열 길이
			for(int i = 0; i<startEmail.length()-subEmailLength; i++) {		//subSubEmail.length()로 하면 subSubEmail 길이가 계속 바뀌기 때문에 안됨.
				subSubEmail += "*";
			}

			subSubEmail += endEmail;	//@뒤 주소 붙혀주기
			m.addAttribute("showEmail", subSubEmail);
			m.addAttribute("email", email);
			return "pwFindSucc";
		}
	}
	
	//메일 전송을 위해
	@Autowired
	private JavaMailSender mailSender;
	@RequestMapping(value = "/sendMail", method = RequestMethod.GET)
	public String sendMail(@RequestParam("emailAddr")String email, Model m) throws Exception{
		
		 //인증 번호 생성기
        StringBuffer temp =new StringBuffer();
        Random rnd = new Random();
        for(int i=0;i<10;i++)	//인증번호 10자리
        {
            int rIndex = rnd.nextInt(3);	//nextInt(3):0~2까지 랜덤으로
            switch (rIndex) {
            case 0:
                // a-z
                temp.append((char) ((int) (rnd.nextInt(26)) + 97));
                break;
            case 1:
                // A-Z
                temp.append((char) ((int) (rnd.nextInt(26)) + 65));
                break;
            case 2:
                // 0-9
                temp.append((rnd.nextInt(10)));
                break;
            }
        }
        
        String randNum = temp.substring(0, temp.length());	//string buffer To string 해주기.
		
        String subject = "안녕하세요. careerBasket 인증 메일입니다.";		//이메일 제목
        String content = "인증 번호는 " +randNum +" 입니다.";	//이메일 내용
        String from = "ekek0725@naver.com";		//보내는 사람
        String to = email;		//받는 사람
        
        final MimeMessagePreparator preparator = new MimeMessagePreparator() {
            
            public void prepare(MimeMessage mimeMessage) throws Exception{
            	
                final MimeMessageHelper mailHelper = new MimeMessageHelper(mimeMessage, "UTF-8");	
                //MimeMessageHelper(mail,true,"UTF-8") : 멀티파트 메세지(이미지,첨부파일) 사용하겠다는 의미
                //단순 텍스트만 전송할 것이기 때문에 true 안써줌.
                
                //보내는사람, 내용, 제목, 받는 사람 설정
                mailHelper.setFrom(from);
                mailHelper.setTo(to);
                mailHelper.setSubject(subject);
                mailHelper.setText(content);	//mailHelper.setText(content, true); true: html 사용하겠다는 의미, 단순 텍스트이면 true 빼도됨.
            }
        };
        
        try {    
            mailSender.send(preparator);	//메일 보내기
            
        } catch(Exception e) {
            e.printStackTrace();
        }        
        
        m.addAttribute("email", email);
        m.addAttribute("confirmNum", randNum);
        return "emailConfirm";		//인증번호 입력하는 폼으로 이동.
	}
	
	//이메일 인증 완료
	@PostMapping("/emailSucc")
	public String emailSucc(@RequestParam("confirmNum")String answer, @RequestParam("userConfirm")String input, 
			@RequestParam("email")String email, Model m) {
		m.addAttribute("email", email);
		
		if(answer.equals(input)) {
			return "emailSucc";
		}else {
			return "emailFail";
		}
		
	}
	
	//비밀번호 변경 폼 화면
	@GetMapping("/changePwForm")
	public String changePwForm(@RequestParam("email")String email, Model m) {
		m.addAttribute("email", email);
		return "changePwForm";
	}
	
	//비밀번호 변경
	@PostMapping("/changePw")
	public String changePw(@RequestParam("pw")String pw, @RequestParam("rePw")String rePw, 
			@RequestParam("email")String email) {
		
		//이메일 정보로 기존 password 변경(update) 해주기
		int rs = service.pwChange(rePw, email);
		if(rs == 1) {	//비밀번호 변경 쿼리문이 실행이 잘 됐다면
			return "login";
		}else {
			return "changePwFail";
		}

	}

	
}
