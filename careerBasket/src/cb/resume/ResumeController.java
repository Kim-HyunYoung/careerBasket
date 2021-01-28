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

import cb.signUp.User;



@Controller
@RequestMapping("/resume")
public class ResumeController {

	@Autowired
	ResumeService service;
	
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
	public String showPickView(Model m, String id, String userId) {
//		System.out.println("실행");
		System.out.println(id+userId);
		//이력서 정보 조회
		Resume re = service.selectOne(Integer.parseInt(id));
		m.addAttribute("re", re);
		//회원 정보 조회
		User si = service.selectMyInfo(userId);
		m.addAttribute("si", si);
		//회원 나이 계산
		int age = (LocalDate.now().getYear()-si.getBirthDate().getYear()+1);
		m.addAttribute("age", age);
		//경력 정보 조회
		List<Career> ca = service.selectCareer(Integer.parseInt(id));
		m.addAttribute("ca", ca);
		List<Document> doList = service.selectDoAllView(userId);
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
		return "insertForm";
	}
	
	//이력서 등록하고 디비에 저장후 저장된 이력서 상세페이지 보여주기
	@PostMapping("/addresume")
	@ResponseBody
	public String addResume(InsertUpdate iu, Model m) {
//		System.out.println("실행");
		System.out.println(iu);
		service.insert(iu);
		//이력서 정보 조회
		Resume re = service.selectOne(iu.getResumeId());
		m.addAttribute("re", re);
		//회원 정보 조회
		User si = service.selectMyInfo(iu.getUserId());
		m.addAttribute("si", si);
		//회원 나이 계산
		int age = (LocalDate.now().getYear()-si.getBirthDate().getYear()+1);
		m.addAttribute("age", age);
		//경력 정보 조회
		List<Career> ca = service.selectCareer(iu.getResumeId());
		return "pickList";
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
		return "updateForm";
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String update(InsertUpdate iu, Model m) {
		System.out.println("실행");
		System.out.println(iu);
		service.update(iu);
		//이력서 정보 조회
		Resume re = service.selectOne(iu.getResumeId());
		m.addAttribute("re", re);
		//회원 정보 조회
		User si = service.selectMyInfo(iu.getUserId());
		m.addAttribute("si", si);
		//회원 나이 계산
		int age = (LocalDate.now().getYear()-si.getBirthDate().getYear()+1);
		m.addAttribute("age", age);
		//경력 정보 조회
		List<Career> ca = service.selectCareer(iu.getResumeId());
		m.addAttribute("ca", ca);
		return "pickList";
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
	
	//기타문서 폼
	@GetMapping("/documentList")
	public String documentUploadForm(Model m, String userId) {
		List<Document> doList = service.selectDoAllView(userId);
		m.addAttribute("doList", doList);
		return "allDoInsertList";
	}
	
	
	//파일 받아와서 저장
	@PostMapping(value="/documentList", produces = "plain/text; charset=utf-8")
	public String fileUpload(MultipartFile[] files, String type, String userId, Model m) {
		System.out.println(files[0].getOriginalFilename());
		System.out.println(files[0].getSize());
		System.out.println(type);
		String result = service.uploadFiles(files, type, userId);
		m.addAttribute("result", result);
		return documentUploadForm(m, userId);
	}
	
	@GetMapping("/deleteDocument")
	public String deleteDo(String documentId, String userId, Model m) {
		service.deleteDo(Integer.parseInt(documentId));
		return documentUploadForm(m, userId);
	}
	
}
