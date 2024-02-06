package com.clubddaegu_admin.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.clubddaegu_admin.service.AdminUserService;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class MyAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	@Autowired
	private AdminUserService adminUserService;
	
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		handle(request, response, authentication);
        clearAuthenticationAttributes(request);
			
	}

	protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException {

		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String targetUrl = "";
//		String sAuth = "";
		
//		Collection<? extends GrantedAuthority> authorities = auth.getAuthorities();
//		for (GrantedAuthority grantedAuthority : authorities) {
//			sAuth = grantedAuthority.getAuthority();
//			break;
//        }
//        
		
//
//        if (response.isCommitted()) {
//            System.out.println("Response has already been committed. Unable to redirect to "+ targetUrl);
//            return;
//        }
        
		
        UserCustom user = (UserCustom)auth.getPrincipal();
        HttpSession session = request.getSession();

        session.setAttribute("session",  user);
        session.setMaxInactiveInterval(12 * 60 * 60); 
        
        targetUrl = determineTargetUrl(authentication, request, user);
        log.debug(targetUrl);

        redirectStrategy.sendRedirect(request, response, targetUrl);
    }
	
    protected String determineTargetUrl(Authentication authentication, HttpServletRequest request, UserCustom user) {
    	return "/";
    }
 
    protected void clearAuthenticationAttributes(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return;
        }
        session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
    }
 
    public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
        this.redirectStrategy = redirectStrategy;
    }
    protected RedirectStrategy getRedirectStrategy() {
        return redirectStrategy;
    }
}
