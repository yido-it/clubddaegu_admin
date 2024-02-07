package com.clubddaegu_admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.LockedException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.clubddaegu_admin.model.AdminUser;
import com.clubddaegu_admin.service.AdminUserService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/")
public class WebController {
	
	@Autowired AdminUserService adminUserService;

	@GetMapping("/")
	public String index(Model model) {
		return "/index";
	}
	
	@GetMapping("/login")
	public String login(@RequestParam(required = false) String error, HttpServletRequest request, Model model)
				throws IOException {
		String userId = "", userPw = "";
	
		if (null != error) {
			Exception exception = (Exception) request.getSession().getAttribute("SPRING_SECURITY_LAST_EXCEPTION");
			if (exception instanceof LockedException || exception instanceof BadCredentialsException) {
				error = exception.getMessage();
				error = exception.getMessage().split(";")[0];
				userId = exception.getMessage().split(";")[1];
				userPw = exception.getMessage().split(";")[3];
			} else {
				error = "로그인에 실패하였습니다.";
			}
			model.addAttribute("errorMessage", error);
			model.addAttribute("userId", userId);
			model.addAttribute("userPw", userPw);
		}
				
		return "/login";
	}
	
	@GetMapping("/succ-logout")
	public String logout() {
		log.debug("logout...");
		return "/login";
	}
}
 	