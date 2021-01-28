package cb.search;

import java.io.File;
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

import cb.resume.Document;
import cb.resume.Resume;
import cb.resume.ResumeService;
import cb.signUp.UserService;

@Controller
//@RequestMapping(value = "/hire", produces = "text/html; charset=UTF-8")
//이거하면 계속 500에러뜸
@RequestMapping("/hire")
public class HireInfoController {

	@Autowired
	HireInfoService service;
	
	@Autowired
	ResumeService resumService;
	
	@Autowired
	UserService userService;
	
	@GetMapping("/list")
	public String getHireList(String userId,Model m){
		m.addAttribute("userId", userId);
		return "searchForm";
	}
	
	@PostMapping("/search")
	public @ResponseBody HireListView getHireList(int hireCareer,String workPlace,String position,int page,String userId,Model m){
		System.out.println("post컨트롤러에서 hireCareer:"+hireCareer);
		System.out.println("post컨트롤러에서 workPlace:"+workPlace);
		System.out.println("post컨트롤러에서 position:"+position);
		
		m.addAttribute("userId", userId);
		
		HireListView viewData = service.getHireListView(hireCareer, workPlace, position, page);
		
		//한페이지에 보여줄 채용공고 가져오기
		int firstRow = viewData.getFirstRow();
		int hireCntPerPage = viewData.getHireCntPerPage();
		List<HireInfo> hList = viewData.getHireList();
		System.out.println(firstRow);
		System.out.println(hireCntPerPage);
		System.out.println(hList);
		System.out.println(viewData);
		return viewData;
	}
	
	//페이지 네이션 a태그 눌렀을 때 실행될 메서드
	@GetMapping("/search")
	public @ResponseBody HireListView getHireList(int hireCareer,String workPlace,String position,int page){
		
		System.out.println("get컨트롤러에서 hireCareer:"+hireCareer);
		System.out.println("get컨트롤러에서 workPlace:"+workPlace);
		System.out.println("get컨트롤러에서 position:"+position);
		
		
		HireListView viewData = service.getHireListView(hireCareer, workPlace, position, page);
		
		//해당 페이지에 보여줄 채용공고 가져오기
		int firstRow = viewData.getFirstRow();
		int hireCntPerPage = viewData.getHireCntPerPage();
		List<HireInfo> hList = viewData.getHireList();
		
		System.out.println(firstRow);
		System.out.println(hireCntPerPage);
		System.out.println(hList);
		System.out.println(viewData);
		
		return viewData;
	}
	
	//상세페이지로 이동
	@GetMapping("/detail")
	public String getDetail(int id,Model m,String userId) {
		System.out.println(userId);
		
		//해당 id의 상세페이지 뿌려주는 메서드(service에 만들기)
		HireInfo hireInfo = service.getHireDetail(id);
		Company company = service.getCompany(hireInfo.getCompanyName());
		m.addAttribute("detail", hireInfo);
		m.addAttribute("company", company);
		
		//userId="durumi"; //임의로 지정해둠
		
		m.addAttribute("userId", userId);
		int resumeCount = resumService.resumeCount(userId);
		m.addAttribute("count", resumeCount);
		List<Resume> reList = resumService.showList(userId);
		m.addAttribute("list", reList);
		List<Document> doList = resumService.selectDoPreView(userId);
		System.out.println(doList);
		m.addAttribute("doList", doList);
		
		return "detailView";
	}
	
	//조건 선택하라는 안내문
	@PostMapping("/check")
	@ResponseBody  //이거 주석하면 왜 404뜨는거지?
	public void getCheckInfo() {
		//return "검색할 조건을 모두 선택해주세요";
	}
	
	@PostMapping(value = "/apply",  produces = "text/html; charset=UTF-8")
	public @ResponseBody String addApply(int id,String companyName,String title,String userId) { //String userId 추가해야함(회원가입 완료되면)
		System.out.println(title);
		System.out.println(id);
		System.out.println(companyName);
		
		String result ="";
		
		List<Integer> applyIdList = service.getApplyId(userId);
		System.out.println(applyIdList);
		
		System.out.println(	applyIdList.contains(id)); //true로 나와야해
		
		if(applyIdList.contains(id)){
			
			result = "이미 지원하신 채용공고입니다.";
			System.out.println(applyIdList.contains(id));
			System.out.println("이미 지원하신 채용공고입니다.");
			
		}else{
			System.out.println(applyIdList.contains(id));
			System.out.println("DB저장 부분 실행!");
			//채용공고id가 중복되지 않는다면 지원!
			//지원현황 데이터테이블에 넣기
			
			//resume_id 받아오는 서비스 메서드 실행해서 변수에 넣기
			int resumeId = service.getResumeId(title, userId);
			
			service.addApplyInfo(id, companyName, title,userId,resumeId); //int resumeId
			//resume테이블에서 resume_path값 가져와 변수에 담음
			String resumePath = service.getResumePath(title,userId);
			//File file = new File(resumePath);
			//apply에 이력서(사진형식) 업로드하기
			
			//service.applyResume(file);
			
			System.out.println("지원이 완료되었습니다.");
			result = "지원이 완료되었습니다.";
			
		}
		return result;
	}
	
	@GetMapping("/applyInfo")
	public String getApplyList(Model m,String userId) { //String userId 추가해야함(회원가입 완료되면)
		
		//임의로 회원 정해둠
		//userId = "durumi";
		
		//지원한 개수
		int applyCnt = service.getApplyCnt(userId);
		System.out.println(applyCnt);
		m.addAttribute("applyCnt", applyCnt);
		List<Apply> applyList = service.getApplyList(userId);
		System.out.println(applyList);
		m.addAttribute("applyList", applyList);
		
		return "applyListView";
	}
	
	@GetMapping("/myPage")
	public String getMyPage() {
		return "myPage";
	}
	
	
	
}
