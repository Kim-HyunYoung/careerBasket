package cb.search;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface CompanyMapper {
	//해당하는 company_name 정보 가져오기
	@Select("select * from com_info where company_name=#{companyName}")
	public Company selectCompany(String companyName);
}
