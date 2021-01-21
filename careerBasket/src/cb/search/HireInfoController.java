package cb.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
//@RequestMapping(value = "/hire", produces = "text/html; charset=UTF-8")
//이거하면 계속 500에러뜸
@RequestMapping("/hire")
public class HireInfoController {

	@Autowired
	HireInfoService service;
	
	@GetMapping("/list")
	public String getHireList(){
		return "searchForm";
	}
	
	@PostMapping("/search")
	public @ResponseBody HireListView getHireList(int hireCareer,String workPlace,String position,int page,Model m){
		System.out.println("post컨트롤러에서 hireCareer:"+hireCareer);
		System.out.println("post컨트롤러에서 workPlace:"+workPlace);
		System.out.println("post컨트롤러에서 position:"+position);
		
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
	public String getDetail(int id,Model m) {
		//해당 id의 상세페이지 뿌려주는 메서드(service에 만들기)
		HireInfo hireInfo = service.getHireDetail(id);
		Company company = service.getCompany(hireInfo.getCompanyName());
		m.addAttribute("detail", hireInfo);
		m.addAttribute("company", company);
		return "detailView";
	}
	
	//조건 선택하라는 안내문
	@PostMapping("/check")
	@ResponseBody  //이거 주석하면 왜 404뜨는거지?
	public void getCheckInfo() {
		//return "검색할 조건을 모두 선택해주세요";
	}
	
}
