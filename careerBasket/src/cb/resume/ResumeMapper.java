package cb.resume;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import cb.signup.SignUp;

@Mapper
public interface ResumeMapper {
	
	@Select("select * from resume where user_id='durumi' order by resume_id desc limit 3")
	public List<Resume> selecLimit();

	@Select("select * from resume where user_id='durumi' order by resume_id desc")
	public List<Resume> selectAll();
	
	@Select("select * from resume where resume_id=#{resumeId}")
	public Resume selectOne(int resumeId);
	
	@Select("select resume_id from resume where user_id=#{userId} order by resume_id desc limit 1")
	public int selectId(String userId);
	
	@Select("select * from signup where user_id=#{userId}")
	public SignUp selectMyInfo(String userId);
	
	@Select("select * from career where resume_id=#{resumeId}")
	public List<Career> selectCareer(int resumeId);
	
	@Insert("insert into resume(user_id, title, final_education, education_name, "
			+ "period, state, major, score, basic_score, career, resume_path, myinfo) "
			+ "values(#{userId}, #{title}, #{finalEducation}, #{educationName}, #{period}, "
			+ "#{state}, #{major}, #{score}, #{basicScore}, #{career}, #{resumePath}, #{myinfo})")
	public int insert(Resume resume);
	
	@Insert("insert into career(resume_id, company, career_period, career_position, career_salary, description) "
			+ "values(#{resumeId}, #{company}, #{careerPeriod}, #{careerPosition}, #{careerSalary}, #{description})")
	public int insertCareer(Career career);
	
	@Update("update resume set title=#{title}, final_education=#{finalEducation}, "
			+ "education_name=#{educationName}, period=#{period}, state=#{state}, major=#{major}, "
			+ "score=#{score}, basic_score=#{basicScore}, career=#{career}, "
			+ "resume_path=#{resumePath}, myinfo=#{myinfo} "
			+ "where resume_id=#{resumeId}")
	public int update(Resume resume);
	
	@Update("update career set company=#{company}, career_period=#{careerPeriod}, "
			+ "career_position=#{careerPosition}, career_salary=#{careerSalary}, description=#{description} "
			+ "where resume_id=#{resumeId}")
	public void updateCareer(Career career);
	
	@Select("select count(career_id) from career where career_id=#{careerId}")
	public int countCareer(int careerId);
	
	@Delete("delete from resume where resume_id=#{id}")
	public int delete(int id);

	
	//document query
	
	@Select("select * from document where user_id='durumi' order by resume_id desc limit 3")
	public List<Document> selectDo(String userId);
	
	@Select("select * from document where user_id='durumi'")
	public List<Document> selectAllDo(String userId);
	
	@Select("select * from document where document_id=#{documentId}")
	public Document selectDoOne(int documentId);

	@Insert("insert into document(user_id, type, file_title, file_path, file_size) "
			+ "values(#{userId}, #{type}, #{fileTitle}, #{filePath}, #{fileSize})")
	public int insertDo(Document document);

	@Select("select count(*) from resume where user_id=#{userId}")
	public int resumeCount(String userId);
	
	@Delete("delete from document where document_id=#{documentId}")
	public int deleteDocument(int documentId);
}
