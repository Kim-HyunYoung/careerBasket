package cb.resume;

import java.io.File;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import cb.signup.SignUp;

@Service
public class ResumeService {

	@Autowired
	ResumeMapper mapper;
	
	//이력서 최신등록 3개만 가져오는 메서드
	public List<Resume> showPreview(){
		return mapper.selecLimit();
	}
	
	//이력서 전체를 가져오는 메서드
	public List<Resume> showList(){
		return mapper.selectAll();
	}
	
	//이력서 1개만 가져오는 메서드
	public Resume selectOne(int id) {
		return mapper.selectOne(id);
	}
	
	//회원 기본정보 불러오는 메서드
	public SignUp selectMyInfo(String userId) {
		return mapper.selectMyInfo(userId);
	}
	
	//이력서 삭제하는 메서드(이력서 아이디 받아오기)
	public int delete(int id) {
		return mapper.delete(id);
	}

	//이력서 등록하는 메서드
	public int insert(InsertUpdate iu) {
		Resume re = new Resume();
		re.setResumeId(iu.getResumeId());
		re.setUserId(iu.getUserId());
		re.setDocumentId(iu.getDocumentId());
		re.setTitle(iu.getTitle());
		re.setFinalEducation(iu.getFinalEducation());
		re.setEducationName(iu.getEducationName());
		re.setPeriod(iu.getPeriod());
		re.setState(iu.getState()[0]);
		re.setMajor(iu.getMajor());
		re.setScore(iu.getScore());
		re.setBasicScore(iu.getBasicScore());
		re.setCareer(iu.getCareer());
		re.setResumePath(iu.getResumePath());
		re.setMyinfo(iu.getMyinfo());
		
		mapper.insert(re);
		
		System.out.println(iu.getCompany());
		
		if(iu.getCompany()==null) {
			return mapper.selectId(iu.getUserId());
		}else {
			
			Career career = new Career();
			for (int i = 0; i < iu.getCompany().length; i++) {
				career.setResumeId(mapper.selectId(iu.getUserId()));
				career.setCompany(iu.getCompany()[i]);
				career.setCareerPeriod(iu.getCareerPeriod()[i]);
				career.setCareerPosition(iu.getCareerPosition()[i]);
				career.setCareerSalary(iu.getCareerSalary()[i]);
				career.setDescription(iu.getDescription()[i]);
				mapper.insertCareer(career);
				
			}
			return mapper.selectId(iu.getUserId());
		}
	}
	
	//이력서 업데이트하는 메서드
	public int update(InsertUpdate iu) {
		Resume re = new Resume();
		re.setResumeId(iu.getResumeId());
		re.setUserId(iu.getUserId());
		re.setDocumentId(iu.getDocumentId());
		re.setTitle(iu.getTitle());
		re.setFinalEducation(iu.getFinalEducation());
		re.setEducationName(iu.getEducationName());
		re.setPeriod(iu.getPeriod());
		re.setState(iu.getState()[0]);
		re.setMajor(iu.getMajor());
		re.setScore(iu.getScore());
		re.setBasicScore(iu.getBasicScore());
		re.setCareer(iu.getCareer());
		re.setResumePath(iu.getResumePath());
		re.setMyinfo(iu.getMyinfo());
		
		mapper.update(re);
		
		System.out.println(iu.getCompany());
		
		if(iu.getCompany()==null) {
			return mapper.selectId(iu.getUserId());
		}else {
			Career career = new Career();
			
			for (int i = 0; i < iu.getCompany().length; i++) {
				//career객체에 값 셋팅해주기
				career.setResumeId(iu.getResumeId());
				career.setCompany(iu.getCompany()[i]);
				career.setCareerPeriod(iu.getCareerPeriod()[i]);
				career.setCareerPosition(iu.getCareerPosition()[i]);
				career.setCareerSalary(iu.getCareerSalary()[i]);
				career.setDescription(iu.getDescription()[i]);
				//아이디값으로 카운트 해보고 값이 있으면 업데이트 없으면 인서트
				if(mapper.countCareer(iu.getCareerId()[i])>0) {
					mapper.updateCareer(career);
				}else {
					mapper.insertCareer(career);
				}
			}
			return mapper.selectId(iu.getUserId());
		}
	}

	//전체경력 불러오는 메서드
	public List<Career> selectCareer(int id) {
		return mapper.selectCareer(id);
	}
	
	//기타문서 미리보기로 불러오는 메서드
	public List<Document> selectDoPreView(String userId) {
		return mapper.selectDo(userId);
	}
	
	//기타문서 전체를 불러오는 메서드
	public List<Document> selectDoAllView(String userId){
		return mapper.selectAllDo(userId);
	}
	
	//기타문서 파일 저장하는 메서드
	public String uploadFiles(MultipartFile[] files, String type, String userId) {
		String result = null;
		
		String uploadFolder = "/Users/jeong-yeji/git/careerBasket/careerBasket/WebContent/WEB-INF/resource/document ";
		
		
		File file = new File(uploadFolder);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		try {
			for (int i = 0; i < files.length; i++) {
				Document document = new Document();
				document.setUserId(userId);
				document.setType(type);
				document.setFileTitle(files[0].getOriginalFilename());
				
				if(files[0].getSize()/1024<1024) {
					String fileSize = files[0].getSize()/1024+"KB";
					document.setFileSize(fileSize);
				}else if((files[0].getSize()/1024)/1024<50) {
					String fileSize = files[0].getSize()/1024+"MB";
					document.setFileSize(fileSize);
				}else {
					result = "문서저장 실패! 다시 시도해주세요!";
				}
				
				UUID nums = UUID.randomUUID();
				String newName = nums.toString()+files[i].getOriginalFilename();
				file = new File(file, newName);
				files[i].transferTo(file);
				document.setFilePath(uploadFolder+nums.toString()+files[i].getOriginalFilename());
				
				mapper.insertDo(document);
			}
		} catch (IllegalStateException e) {
			result = "저장 실패! 다시 시도해주세요!";
			e.printStackTrace();
		} catch (IOException e) {
			result = "문서저장 실패! 다시 시도해주세요!";
			e.printStackTrace();
		}
		result = "저장에 성공했습니다!";
		return	type+result;
	}

	public int resumeCount(String userId) {
		return mapper.resumeCount(userId);
	}
}
