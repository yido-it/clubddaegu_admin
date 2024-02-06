package com.clubddaegu_admin.security;

import java.util.Collection;

import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.userdetails.User;

import com.clubddaegu_admin.model.AdminUser;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class UserCustom extends User {
	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;

    // 유저의 정보를 더 추가하고 싶다면 이곳과, 아래의 생성자 파라미터를 조절해야 한다.
	private String userId;
	private String userName;
	private String userAuth;
	private String userAuthNm;
	
    public UserCustom(String username, String password, Collection authorities, String authorityname, AdminUser adminUser) {
    	
    	super(username, password, authorities);
    	
        this.userId = adminUser.getUserId();
        this.userName = adminUser.getUserNm();
        this.userAuth = adminUser.getUserAuth();
        this.userAuthNm = adminUser.getUserAuthNm();
    }


}
