package com.clubddaegu_admin.security;

import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class CustomAuthenticationProvider implements AuthenticationProvider {
	@Autowired
	private AdminUserDetailsService userDetailService;
	
	private PasswordEncoder passwordEncoder;

	public CustomAuthenticationProvider(AdminUserDetailsService adminUserDetailsService, PasswordEncoder passwordEncoder) {
		this.userDetailService = adminUserDetailsService;
		this.passwordEncoder = passwordEncoder;
	}
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		String username = authentication.getName();
		String password = authentication.getCredentials().toString();

		UserDetails userDetails;
		try {
			userDetails = userDetailService.loadUserByUsername(username);
			
		} catch(Exception e) {
			e.printStackTrace();
			throw new BadCredentialsException("ID 또는 비밀번호가 일치하지 않습니다.;"+username+";"+password);
		}

		Collection<? extends GrantedAuthority> authorities = userDetails.getAuthorities();
		log.debug(userDetails.getPassword());
		if (passwordEncoder.matches(password, userDetails.getPassword()) ) {
        	return new UsernamePasswordAuthenticationToken(userDetails, null, authorities);        	
        } else {
        	log.debug(passwordEncoder.encode(password));
        	throw new BadCredentialsException("ID 또는 비밀번호가 일치하지 않습니다.;"+username+";"+password);
        }
	}
	
	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}
