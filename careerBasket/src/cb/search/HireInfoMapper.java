package cb.search;

import java.util.List;

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
	
	
	
	
	
	
	
	/*
	@Select("select * from hire_info where hire_career = #{career}")
	public List<HireInfo> selectCareer(@Param("career")int career);
	
	@Select("select * from hire_info where work_place like CONCAT('%',#{place},'%')")
	public List<HireInfo> selectPlace(@Param("place")String place);
	
	@Select("select * from hire_info where position=#{position}")
	public List<HireInfo> selectPosition(@Param("position") String position);
	 */
	
}
