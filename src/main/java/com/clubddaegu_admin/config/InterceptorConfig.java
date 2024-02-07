package com.clubddaegu_admin.config;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.clubddaegu_admin.common.utils.SessionVO;
import com.clubddaegu_admin.common.utils.Utils;
import com.clubddaegu_admin.security.UserCustom;

import lombok.extern.slf4j.Slf4j;

@Configuration
@Component
@Slf4j
public class InterceptorConfig extends HandlerInterceptorAdapter {
	
	public String[] interceptY = { 
		"/**"
	};
	
	public String[] interceptN = {
		 "/ckeditor/**"
		, "/css/**"
		, "/datatables/**"
		, "/fontawesome/**"
		, "/fonts/**"
		, "/img/**"
		, "/js/**"
		, "/tabulator/**"
		, "/**/*.js"
		, "/**/*.jpg"
		, "/**/*.jpeg"
		, "/**/*.png"
		, "/login"
		, "/exception"
		, "/succ-logout"
	};
	
	@Override
    public boolean preHandle(HttpServletRequest req, HttpServletResponse res, Object handler) throws Exception {
        HttpSession session = req.getSession();        
        UserCustom user = (UserCustom) session.getAttribute("session");
		Boolean loginYn = false;
		
		// 세션에 로그인 정보 있음
		if(user != null) {				
			loginYn = true;
		}

		if(!loginYn) {
			res.sendRedirect("/succ-logout");
			return false;
		}
		
		return true;
	}		
	
	@Override
    public void postHandle(HttpServletRequest req, HttpServletResponse res, Object handler, ModelAndView modelAndView) throws Exception {

    }
	

}
