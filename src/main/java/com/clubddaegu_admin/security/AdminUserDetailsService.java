package com.clubddaegu_admin.security;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.clubddaegu_admin.model.AdminUser;
import com.clubddaegu_admin.service.AdminUserService;

import lombok.Builder;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class AdminUserDetailsService implements UserDetailsService {

	@Autowired
	private AdminUserService adminUserService;
	
	@Override
    public UserDetails loadUserByUsername(String userId) throws UsernameNotFoundException {

		AdminUser user = adminUserService.getAdminUser(AdminUser.builder().userId(userId).build());
		
		if(user == null) {
			throw new UsernameNotFoundException("사용자 찾을수 없음");
		}else {
			
			List<GrantedAuthority> authorities = Collections.singletonList(new SimpleGrantedAuthority("ROLE_"+user.getUserAuth()));
		        
	//        return new User(user.getUserId(), user.getUserPw(), authorities);
	        return new UserCustom(user.getUserId(), user.getUserPw(), authorities, user.getUserAuthNm(), user);
		}
        
    }
	
	
}
