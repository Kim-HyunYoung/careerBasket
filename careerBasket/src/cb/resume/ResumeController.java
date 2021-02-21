package cb.resume;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import cb.search.HireInfoService;
import cb.signUp.User;



@Controller
@RequestMapping("/resume")
public class ResumeController {

	@Autowired
	ResumeService service;
	
	@Autowired
	HireInfoService hireService;
	
	//마이페이지에서 미리보여주는 간단리스트, 이력서 카운트
//	@GetMapping("/list")
//	public String showViewPreview(Model m, String userId) {
////		//실행확인
////		System.out.println("실행!");
////		userId="durumi";
//		User myInfo = service.selectOneUserId(userId);
//		m.addAttribute("info", myInfo);
//		int resumeCount = service.resumeCount(userId);
//		m.addAttribute("count", resumeCount);
//		List<Resume> reList = service.showPreview(userId);
//		m.addAttribute("list", reList);
//		List<Document> doList = service.selectDoPreView(userId);
////		System.out.println(doList);
//		m.addAttribute("doList", doList);
//		return "list";
//	}
	
	//전체보기 클릭시 이력서 전체 목록 보여주기
	@GetMapping("/listAll")
	public String showViewList(Model m, String userId){
//		//실행확인
//		System.out.println("실행");
		List<Resume> reList = service.showList(userId);
		m.addAttribute("list", reList);
		m.addAttribute("userId", userId);
		return "allList";
	}
	
	//확인하려는 이력서 클릭하면 보이는 이력서 상세페이지
	@GetMapping("/details")
	public String showPickView(Model m, String resumeId, String userId) {
//		System.out.println("실행");
		System.out.println(resumeId+userId);
		//이력서 정보 조회
		Resume re = service.selectOne(Integer.parseInt(resumeId));
		m.addAttribute("re", re);
		//회원 정보 조회
		User si = service.selectMyInfo(userId);
		m.addAttribute("si", si);
		//회원 나이 계산
		int age = (LocalDate.now().getYear()-si.getBirthDate().getYear()+1);
		m.addAttribute("age", age);
		//경력 정보 조회
		List<Career> ca = service.selectCareer(Integer.parseInt(resumeId));
		m.addAttribute("ca", ca);
		//이력서에 저장한 문서 보여주기
		List<Document> doList = service.selectResumeDoc(Integer.parseInt(resumeId));
		m.addAttribute("doList", doList);
		return "pickList";
	}
	
	//이력서 등록하는 폼
	@GetMapping("/addresume")
	public String addResumeForm(String userId, Model m) {
//		//실행확인
//		System.out.println("실행");
//		System.out.println(userId);
		//회원 정보 조회
		User si = service.selectMyInfo(userId);
		m.addAttribute("si", si);
		
		List<Document> doList = service.selectDoAllView(userId);
		m.addAttribute("doList", doList);
		
		return "insertForm";
	}
	
	//이력서 등록하고 디비에 저장후 저장된 이력서 상세페이지 보여주기
	@PostMapping("/addresume")
	@ResponseBody
	public String addResume(InsertUpdate iu, Model m) {
//		System.out.println("실행");
		System.out.println(iu);
		int resumeId = service.insert(iu);
		m.addAttribute("userId", iu.getUserId());
		m.addAttribute("resumeId", resumeId);
		return "updatePickListResult";
	}
	
	//이력서 리스트에서 수정버튼 클릭시 해당 이력서 수정할수 있는 폼
	@GetMapping("/update")
	public String update(Model m, String resumeId, String userId) {
//		//실행확인
//		System.out.println("실행");
//		//아이디값 넘어오는지 확인
		System.out.println(resumeId);
		Resume re = service.selectOne(Integer.parseInt(resumeId));
		m.addAttribute("re", re);
		//회원 정보 조회
		User si = service.selectMyInfo(userId);
		m.addAttribute("si", si);
		//경력 정보 조회
		List<Career> ca = service.selectCareer(Integer.parseInt(resumeId));
		m.addAttribute("ca", ca);
		List<Document> doList = service.selectDoAllView(userId);
		m.addAttribute("doList", doList);
		List<Document> doSelList = service.selectResumeDoc(Integer.parseInt(resumeId));
		m.addAttribute("docSel", doSelList);
		return "updateForm";
	}
	
	//이력서 상세페이지, 인쇄가능 페이지
	@PostMapping("/update")
	@ResponseBody
	public String update(InsertUpdate iu, Model m) {
		System.out.println("실행");
		System.out.println(iu);
		service.update(iu);
		m.addAttribute("userId", iu.getUserId());
		m.addAttribute("resumeId", iu.getResumeId());
		return "updatePickListResult";
	}
	
	//이력서 리스트에서 삭제버튼 클릭시 해당 이력서 디비에서 삭제
	@GetMapping("/delete")
	public String delete(String resumeId, Model m, String userId) {
//		//아이디값 넘어오는지 확인
//		System.out.println(id);
//		//실행확인
//		System.out.println("삭제실행");
//		//아이디값이 string으로 넘어오기때문에 int로 형변환
		service.delete(Integer.parseInt(resumeId));
		return showViewList(m, userId);
	}
	
	//기타문서 폼 및 등록한 문서 리스트
	@GetMapping("/documentList")
	public String documentUploadForm(Model m, String userId) {
		List<Document> doList = service.selectDoAllView(userId);
		m.addAttribute("doList", doList);
		m.addAttribute("userId", userId);
		return "allDoInsertList";
	}
	
	
	//파일 받아와서 저장
	@PostMapping(value="/documentList", produces = "plain/text; charset=utf-8")
	public String fileUpload(MultipartFile[] files, String type, String userId, Model m) {
		System.out.println(files[0].getOriginalFilename());
		System.out.println(files[0].getSize());
		System.out.println(type);
		service.uploadFiles(files, type, userId);
		List<Document> doList = service.selectDoAllView(userId);
		m.addAttribute("doList", doList);
		m.addAttribute("userId", userId);
		return "allDoInsertList";
	}
	
	//사진저장해주는 컨트롤러
	@PostMapping(value="/photoUpdate", produces = "plain/text; charset=utf-8")
	public String photoUpload(MultipartFile[] files, String userId, Model m) {
		System.out.println("사진 컨트롤러로 넘어옴");
		System.out.println(files[0].getOriginalFilename().trim());
		m.addAttribute("photo", service.savePhoto(files, userId));
		m.addAttribute("userId", userId);
		User myInfo = service.selectOneUserId(userId);
		m.addAttribute("info", myInfo);
		int resumeCount = service.resumeCount(userId);
		m.addAttribute("count", resumeCount);
		List<Resume> reList = service.showPreview(userId);
		m.addAttribute("list", reList);
		List<Document> doList = service.selectDoPreView(userId);
//		System.out.println(doList);
		m.addAttribute("doList", doList);
		int applyCnt = hireService.getApplyCnt(userId);
		m.addAttribute("applyCnt", applyCnt);
		return "main";
	}
	
	//기타문서 삭제
	@GetMapping("/deleteDocument")
	public String deleteDo(String documentId, String userId, Model m) {
		service.deleteDo(Integer.parseInt(documentId));
		return documentUploadForm(m, userId);
	}
	
	//유저기본정보 수정하는 폼
	@GetMapping("/infoUpdateForm")
	public String myinfoUpdateForm(Model m, String userId) {
		System.out.println("infoUpdate userId 받아옴" + userId);
		User userInfo = service.selectMyInfo(userId);
		m.addAttribute("info", userInfo);
		int idx = userInfo.getEmail().indexOf("@");
		String emailStart = userInfo.getEmail().substring(0, idx);
		String emailEnd = userInfo.getEmail().substring(idx+1);
		m.addAttribute("emailStart", emailStart);
		m.addAttribute("emailEnd", emailEnd);
		return "myInfoUpdateForm";
	}
	
	//유저 기본정보 받아오는 폼
	@PostMapping("/userInfoUpdate")
	public String userInfoUpdate(Model m, String userId, String password, String rePassword, String name, String birthDate,
			String sex, String emailStart, String emailEnd, String tel, String post, String addr,
			String detailAddr, String extraAddr, String address) {
		
		String email = emailStart + "@" + emailEnd;		//이메일
		
		if(post!=null) {
			String address1 = post + addr + detailAddr + extraAddr;		//api에서 받은 주소 문자열 하나로 합쳐주기
			User user = new User(userId, rePassword, name, LocalDate.parse(birthDate), sex, email, tel, address1);//user 객체 생성
			service.signupUpdate(user);
		}else {
			User user = new User(userId, rePassword, name, LocalDate.parse(birthDate), sex, email, tel, address);	//user 객체 생성
			service.signupUpdate(user);
		}
		
		System.out.println("보내줄 아이디: "+userId);
		m.addAttribute("userId", userId);
		
		return "userInfoUpdateResult";
	}
	
}
