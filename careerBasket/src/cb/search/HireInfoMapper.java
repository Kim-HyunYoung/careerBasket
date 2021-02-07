package cb.search;

import java.util.List;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface HireInfoMapper {
	//전체 리스트 조회
	@Select("select * from hire_info")
	public List<HireInfo> selectAll();
	
	//조건 : 경력(인 사람만 조회 hire_career = 1)
	//경력 & 지역 & 포지션
	@Select("select * from hire_info where hire_career = #{career} and work_place like CONCAT('%',#{place},'%') and position=#{position} ")
	public List<HireInfo> selectCareere(@Param("career")int career, @Param("place")String place, @Param("position") String position);
	
	@Select("select * from hire_info where id = #{id}")
	public HireInfo selectDetail(@Param("id")int id);
	
	//경력 & 지역 & 포지션 
	//-> 조건에 해당하는 채용공고 전체 개수를 가져오는 메서드
	@Select("select count(*) from hire_info where hire_career = #{career} and work_place like CONCAT('%',#{place},'%') and position=#{position} ")
	public int selectHireTotalCnt(@Param("career")int career, @Param("place")String place, @Param("position") String position);
	
	//한페이지에 보여줄 채용공고들을 가져오는 메서드
	//날짜 순으로 정렬해서 보여주기 desc (최신순)
	@Select("select * from hire_info  where hire_career = #{career} and work_place like CONCAT('%',#{place},'%') and position=#{position} order by start_date desc limit #{firstRow},#{hireCntPerPage}")
	public List<HireInfo> selectPerList(@Param("career")int career, @Param("place")String place, @Param("position") String position,@Param("firstRow")int firstRow,@Param("hireCntPerPage")int hireCntPerPage);
	
	//resume_id가져오기
	@Select("select resume_id from resume where title=#{title} and user_id=#{userId}")
	public int selectResumeId(@Param("title")String title,@Param("userId")String userId);
	
	//지원 정보 삽입
	@Insert("insert into apply_list (id, company_name, title,user_id,resume_id) values(#{id},#{companyName},#{title},#{userId},#{resumeId})")
	public void insertApplyInfo(@Param("id")int id,@Param("companyName")String companyName,@Param("title")String title,@Param("userId")String userId,@Param("resumeId")int resumeId);
	
	//apply_list의 id를 List로 가져오기
	@Select("select id from apply_list where user_id = #{userId}")
	public List<Integer> selectApplyId(String userId);
	
	//join으로 지원현황 리스트 조회
	@Select("select H.hire_title,H.company_name,R.title,H.end_date,A.apply_date,A.id,A.resume_id " +  //A.id랑 A.resume_id도 가져오기
			"	from hire_info H " + 
			"		inner join apply_list A " + 
			"		on H.id = A.id " + 
			"			inner join resume R " + 
			"			on A.resume_id = R.resume_id " +
			"        where A.user_id = #{userId} order by A.apply_date desc")
	public List<Apply> selectApplyList(String userId);
	
	//지원한 개수
	@Select("select count(*) from apply_list where user_id=#{userId}")
	public int selectApplyCnt(String userId);
	
}
