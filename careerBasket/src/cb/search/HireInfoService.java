package cb.search;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	
	/*
	public List<HireInfo> getHireCareerList(int career){
		return hireInfoMapper.selectCareer(career);
	}
	
	public List<HireInfo> getHirePlaceList(String place){
		return hireInfoMapper.selectPlace(place);
	}
	
	public List<HireInfo> getHirePositionList(String position){
		return hireInfoMapper.selectPosition(position);
	}
	 */
	
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
			//hireList = hireInfoMapper.selectPerList(firstRow, HIRE_CNT_PER_PAGE);
			hireList = hireInfoMapper.selectPerList(career, place, position, firstRow, HIRE_CNT_PER_PAGE);
			
			System.out.println("서비스에서 hireList :"+hireList);
		}else {
			pageNumber = 0;
		}
		
		hListView = new HireListView(hireTotalCnt, pageNumber, hireList, HIRE_CNT_PER_PAGE, firstRow);
		
		System.out.println("hListView :"+ hListView);
		
		return hListView;
	}
	
	
}
