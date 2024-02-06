package com.clubddaegu_admin.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.clubddaegu_admin.common.utils.Utils;
import com.clubddaegu_admin.model.AdminUser;
import com.clubddaegu_admin.model.CdCommon;
import com.clubddaegu_admin.security.UserCustom;
import com.clubddaegu_admin.service.AdminCommonService;
import com.clubddaegu_admin.service.AdminUserService;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j

/**
 * 시스템 관리 컨트롤러
 * @author MSYOO
 *
 */
@RequestMapping("/sys")
public class SystemController {
	
	@Autowired AdminCommonService adminCommonService;
	@Autowired AdminUserService adminUserService;
	
	/**
	 * 어드민 사용자 관리
	 * @param model
	 * @return
	 */
	@GetMapping("/adminUser")
	public String goAmdinUserList(Model model) {
		CdCommon cdCommon = new CdCommon(); 
		cdCommon.setCoDiv("001");
		cdCommon.setCdDivision("A32");
		List<CdCommon> cdList = adminCommonService.getCommonCodeList(cdCommon);
		
		model.addAttribute("cdList", cdList);
		return "/sys/adminUserList";
	}


	@RequestMapping(value="/saveUser", method=RequestMethod.POST)  
	@ResponseBody
	public Map<String, Object> saveUser (HttpServletRequest req,
			@SessionAttribute("session") UserCustom session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		AdminUser au  =  new AdminUser();
		
		String userId = req.getParameter("userId");
		if("".equals(userId)) {
			userId = session.getUserId();
			if("".equals(userId)) {
				throw new Exception("사용자 등록 중 오류가 발생했습니다");
			}
		}
		au.setUserId(userId);
		au.setUserNm(req.getParameter("userNm"));
		au.setUserPw(req.getParameter("userPw"));
		au.setUserAuth(req.getParameter("userAuth"));
		au.setInputStaff(session.getUserId());
		au.setInputIp(Utils.getClientIpAddress(req));
		
		Boolean b = ("Y".equals(req.getParameter("useYn")))? true : false;
		au.setUseYn(b);
		
		try {
			if("Y".equals(req.getParameter("addYn"))) {
				adminUserService.insertAdminUser(au);				
			} else {				
				adminUserService.updateAdminUser(au);				
			}
			map.put("result", true);
		} catch(Exception e) {			
			throw new Exception("사용자 등록 중 오류가 발생했습니다");
		}		
		return map;
	}
	
	@RequestMapping(value="/deleteUser", method=RequestMethod.POST)  
	@ResponseBody
	public Map<String, Object> deleteUser (HttpServletRequest req,
			@SessionAttribute("session") UserCustom session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		AdminUser au  =  new AdminUser();
		
		au.setUserId(req.getParameter("userId"));
		
		try {
			adminUserService.deleteAdminUser(au);	
			map.put("result", true);
		} catch(Exception e) {			
			throw new Exception("사용자 등록 중 오류가 발생했습니다");
		}		
		return map;
	}
	
	@RequestMapping("/getUserList")  
	@ResponseBody
	public List<AdminUser> getUserList (HttpServletRequest req,
			@SessionAttribute("session") UserCustom session) throws Exception {
		List<AdminUser> list = new ArrayList<AdminUser>();
		AdminUser adminUser = new AdminUser();
		try {			
			list = adminUserService.getAdminUserList(adminUser);
		} catch(Exception e) {			
			throw new Exception("사용자 목록 조회 중 오류가 발생했습니다");
		}		
		return list;
	}
	/**
	 * 수신대상 관리
	 * @param model
	 * @return
	 */
	@GetMapping("/adminSms")
	public String goAdminSmsList(Model model) {
		CdCommon cdCommon = new CdCommon(); 
		cdCommon.setCoDiv("001");
		cdCommon.setCdDivision("A32");
		List<CdCommon> cdList = adminCommonService.getCommonCodeList(cdCommon);
		
		model.addAttribute("cdList", cdList);
		return "/sys/adminSmsList";
	}
	
	@RequestMapping("/getSmsAdminList")  
	@ResponseBody
	public Map<String, Object> getAdminList (@RequestParam Map<String, Object> params, HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();	
		try {			
			CdCommon cdCommon = new CdCommon();
			cdCommon.setCoDiv("001");
			cdCommon.setCdDivision("A31");
			cdCommon.setCdUseyn((String)params.get("cdUseyn"));
			List<CdCommon> adminList = adminCommonService.getCommonCodeList(cdCommon);
			
			map.put("adminList", adminList);
			map.put("result", true);
		} catch(Exception e) {			
			map.put("result", false);
			map.put("message", "전송대상 조회 중 오류가 발생했습니다.");
		}
		
		return map;
	}
	
	@RequestMapping(value="/saveSmsAdminList", method=RequestMethod.POST)  
	@ResponseBody
	public Map<String, Object> saveSmsAdminList (HttpServletRequest req,
			@SessionAttribute("session") UserCustom session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		CdCommon cdCommon  =  new CdCommon();
		
		cdCommon.setCoDiv("001");
		cdCommon.setCdDivision("A31");
		cdCommon.setCdTitle1("일별마감보고 대상자");
		cdCommon.setCdTitle2(req.getParameter("cdTitle2"));
		cdCommon.setCdTitle3(req.getParameter("cdTitle3").replaceAll("-", ""));
		cdCommon.setCdUseyn(req.getParameter("cdUseyn"));
		
		cdCommon.setUserId(session.getUserId());
		cdCommon.setIpAddr(Utils.getClientIpAddress(req));
		
		String cdCode = req.getParameter("cdCode") == null? "" : req.getParameter("cdCode");
				
		try {
			if("".equals(cdCode)) {
				adminUserService.insertSmsAdmin(cdCommon);				
			} else {
				cdCommon.setCdCode(cdCode);
				adminUserService.updateSmsAdmin(cdCommon);				
			}
			map.put("result", true);
			
		} catch(Exception e) {			
			throw new Exception("수신대상 등록 중 오류가 발생했습니다");
		}		
		return map;
	}
	
	@RequestMapping(value="/deleteSmsAdmin", method=RequestMethod.POST)  
	@ResponseBody
	public Map<String, Object> deleteSmsAdmin (HttpServletRequest req,
			@SessionAttribute("session") UserCustom session) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		CdCommon cdCommon  =  new CdCommon();
		
		cdCommon.setCoDiv("001");
		cdCommon.setCdDivision("A31");
		cdCommon.setCdCode(req.getParameter("cdCode"));
		
		try {
			adminUserService.deleteSmsAdmin(cdCommon);	
			map.put("result", true);
		} catch(Exception e) {			
			throw new Exception("사용자 등록 중 오류가 발생했습니다");
		}		
		return map;
	}
	
	
}