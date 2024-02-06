package com.clubddaegu_admin.repository.admin;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubddaegu_admin.model.AdminUser;
import com.clubddaegu_admin.model.CdCommon;

@Mapper
@Repository
public interface AdminUserMapper {

	public AdminUser selectAdminUser(AdminUser adminUser);

	public List<AdminUser> selectAdminUserList(AdminUser adminUser);

	public void insertAdminUser(AdminUser adminUser);

	public void updateAdminUser(AdminUser adminUser);

	public void deleteAdminUser(AdminUser adminUser);
	
	public void insertSmsAdmin(CdCommon cdCommon);

	public void updateSmsAdmin(CdCommon cdCommon);

	public void deleteSmsAdmin(CdCommon cdCommon);

}



