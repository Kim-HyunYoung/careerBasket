package cb.search;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
public class HireInfoService {
	@Autowired
	HireInfoMapper hireInfoMapper; 
	
	@Autowired
	CompanyMapper companyMapper;
	
	//hireCntPerPage
	static final int HIRE_CNT_PER_PAGE = 3;
	
	public List<HireInfo> getHireList(){
		return hireInfoMapper.selectAll();
	}
	
	public HireInfo getHireDetail(int id) {
		return hireInfoMapper.selectDetail(id);
				
	}
	
	public List<HireInfo> getHireCareerList(int career, String place, String position){
		return hireInfoMapper.selectCareere(career, place, position);
	}
	
	//해당 회사 정보 보여주기
	public Company getCompany(String companyName) {
		return companyMapper.selectCompany(companyName);
	}
	
	//채용공고 전체 개수 가져오는 메서드 
	public int getHireTotalCount(int career,String place,String position) {
		return hireInfoMapper.selectHireTotalCnt(career, place, position);
	}
	
	//한페이지에 보여줄 채용공고들만 가져오는 메서드
	public List<HireInfo> getPerHireList(int career,String place,String position, int firstRow, int hireCntPerPage){
		
		//return hireInfoMapper.selectPerList(firstRow, hireCntPerPage);
		return hireInfoMapper.selectPerList(career, place, position, firstRow, hireCntPerPage);
	}
	
	//HireListView객체 값 세팅하는 메서드
	public HireListView getHireListView(int career,String place,String position,int pageNumber) {
		//값들 잘 넘어오는지 확인
		System.out.println("career :"+career);
		System.out.println("place :"+place);
		System.out.println("position :"+position);
		//페이지수 잘넘어오는지 확인
		System.out.println("pageNumber :"+pageNumber);
		HireListView hListView = null;
		
		//전체 메시지 개수 담기
		int hireTotalCnt = hireInfoMapper.selectHireTotalCnt(career, place, position);
		System.out.println("hireTotalCnt :"+hireTotalCnt);
		 	
		//채용공고 담는 리스트
		List<HireInfo> hireList = null;
		int firstRow = 0;
		
		if(hireTotalCnt > 0) {
			firstRow = (pageNumber -1) * HIRE_CNT_PER_PAGE;
			hireList = hireInfoMapper.selectPerList(career, place, position, firstRow, HIRE_CNT_PER_PAGE);
			
			System.out.println("서비스에서 hireList :"+hireList);
		}else {
			pageNumber = 0;
		}
		
		hListView = new HireListView(hireTotalCnt, pageNumber, hireList, HIRE_CNT_PER_PAGE, firstRow);
		
		System.out.println("hListView :"+ hListView);
		
		return hListView;
	}
	
	//resume_id 가져오기
	public int getResumeId(String title,String userId) {
		return hireInfoMapper.selectResumeId(title, userId);
	}
	
	//지원 정보 추가하기
	public void addApplyInfo(int id,String companyName,String title,String userId,int resumeId) {
		hireInfoMapper.insertApplyInfo(id, companyName, title,userId,resumeId);
	}
	
	//apply의 id를 List로 가져오기
	public List<Integer> getApplyId(String userId){
		return hireInfoMapper.selectApplyId(userId);
	}
	
	//resume테이블의 resume_path값 가져오기
	public String getResumePath(String title,String userId) {
		return hireInfoMapper.selectResumePath(title,userId);
	}
	
	//이력서(사진파일-WEB-INF/resume안에 있는) "한 개"를  (WEB-INF/apply)에 업로드하기
	public String applyResume(MultipartFile file) { //그냥 file형식 넣으면??
		//MultipartFile 형식 : 사진,동영상 등 글자가 아닌 파일형식
		String result = "";
		
		//파일 저장 위치
		String uploadFolder = "C:/Users/rbfl6/git/careerBasket/careerBasket/WebContent/WEB-INF/apply"; //apply폴더
		
		//파일경로 입력
		File f = new File(uploadFolder);
		
		//해당 파일이 존재하지 않으면 생성
		if(!f.exists()) {
			f.mkdir(); //주소에 해당되는 폴더 한개 생성
		}
		
		try {
			//난수 생성
			UUID nums = UUID.randomUUID();
			String newName = nums.toString()+file.getOriginalFilename();
			
			//파일 생성
			f = new File(uploadFolder, newName);
		
			file.transferTo(f);  //multipart형식의 파일을 file형식으로 바꾸어 저장함
			
		} catch (IllegalStateException e) {
			e.printStackTrace();
			result="실패";
		} catch (IOException e) {
			e.printStackTrace();
			result="실패";
		}
		
		result="성공";
		return result;
	}
	
	//지원 현황 리스트 가져오기
	public List<Apply> getApplyList(String userId){
		return hireInfoMapper.selectApplyList(userId);
	}
	
	//지원한 개수 
	public int getApplyCnt(String userId) {
		return hireInfoMapper.selectApplyCnt(userId);
	}
}
