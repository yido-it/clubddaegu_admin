package com.clubddaegu_admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.clubddaegu_admin.model.AdminUser;
import com.clubddaegu_admin.model.CdCommon;
import com.clubddaegu_admin.repository.admin.AdminUserMapper;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class AdminUserService {
	
	@Autowired
	public AdminUserMapper adminUserMapper;
	@Autowired
    private PasswordEncoder passwordEncoder;

    public String encodePassword(String password) {
    	return passwordEncoder.encode(password);
    }
    
    public AdminUser getAdminUser(AdminUser adminUser) {
    	return adminUserMapper.selectAdminUser(adminUser);
    }
    
    public List<AdminUser> getAdminUserList(AdminUser adminUser) {
    	return adminUserMapper.selectAdminUserList(adminUser);
    }
    
    public void insertAdminUser(AdminUser adminUser) {
    	adminUserMapper.insertAdminUser(adminUser
			.toBuilder()
			.userPw(encodePassword(adminUser.getUserPw()))
			.build());
    }

	public void updateAdminUser(AdminUser adminUser) {
		if(adminUser.getUserPw() != "") {
			adminUser.setUserPw(encodePassword(adminUser.getUserPw()));
		}
		adminUserMapper.updateAdminUser(adminUser);
	}

	public void deleteAdminUser(AdminUser adminUser) {
		adminUserMapper.deleteAdminUser(adminUser);
		
	}
	
	public void insertSmsAdmin(CdCommon cdCommon) {
		adminUserMapper.insertSmsAdmin(cdCommon);
	}

	public void updateSmsAdmin(CdCommon cdCommon) {
		adminUserMapper.updateSmsAdmin(cdCommon);
	}
	public void deleteSmsAdmin(CdCommon cdCommon) {
		adminUserMapper.deleteSmsAdmin(cdCommon);
	}
    
}
