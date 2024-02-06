package com.clubddaegu_admin.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.clubddaegu_admin.common.utils.ResultVO;
import com.clubddaegu_admin.common.utils.Utils;
import com.clubddaegu_admin.model.DailyReport;
import com.clubddaegu_admin.model.SalesPlanMonth;
import com.clubddaegu_admin.security.UserCustom;
import com.clubddaegu_admin.service.CommonService;
import com.clubddaegu_admin.service.DailyReportService;
import com.clubddaegu_admin.service.SalesPlanMonthService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/report")
public class ReportController {
	
	@Autowired DailyReportService dpService;
	@Autowired SalesPlanMonthService spmService;
	@Autowired CommonService commonService;
	
	@GetMapping("/dailySales")
	public String dailySales(Model model) {
		return "/dailySales";
	}
	
	/**
	 * 일매출리포트 자료 조회
	 * 
	 * @param req
	 * @param dp
	 * @return
	 */
	@RequestMapping("/getDailySales")  
	@ResponseBody
	public ResultVO getDailySales(HttpServletRequest req, DailyReport dailyReport) {

		ResultVO result = new ResultVO();
		log.debug("[getDailySales] dailyReport : " + dailyReport);

		// 월 계획  
		SalesPlanMonth spm = new SalesPlanMonth();
		spm.setPlanMonth(dailyReport.getSearchDt2().substring(0, 7));
		spm = spmService.getSalesPlanMonth(spm);
		log.debug("[getDailySales] 월 계획 : " + spm);
	
		// 년 계획 
		SalesPlanMonth spm2 = new SalesPlanMonth();
		spm2.setPlanYear(dailyReport.getSearchDt2().substring(0, 4));
		spm2 = spmService.getSalesPlanYear(spm2);
		log.debug("[getDailySales] 년 계획 : " + spm2);
		
		// 연간실적 
		DailyReport yearReport = new DailyReport();
		yearReport.setPlanYear(dailyReport.getSearchDt2().substring(0, 4));
		yearReport = dpService.getYearReport(yearReport);
		log.debug("[getDailySales] 연간실적 : " + yearReport);
		
		// 일매출
		dailyReport = dpService.getDailyReport(dailyReport);
		log.debug("[getDailySales] 일매출자료 조회 : " + dailyReport);
	
		if (dailyReport == null) {
			result.setCode("9999");
			result.setMessage("마감 데이터가 없습니다.");
		} else {
			dailyReport.setCloseYn("Y");
			result.setDailyReport(dailyReport);
			result.setYearReport(yearReport);
			if (spm != null) result.setSalesPlanMonth(spm);
			if (spm2 != null) result.setSalesPlanYear(spm2);
		}
		return result;
	}
	
	@RequestMapping("/deleteDailySales")  
	@ResponseBody
	public ResultVO deleteDailySales(HttpServletRequest req, DailyReport dailyReport) {

		ResultVO result = new ResultVO();
		log.debug("[deleteDailySales] closeDate : " + dailyReport.getCloseDate());

		// 일매출 삭제 
		result = dpService.deleteDailySales(dailyReport);
		
		return result;
	}
	
	@RequestMapping(value = "/insertDailyReport", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO insertDailyReport(HttpServletRequest req, ModelMap model, DailyReport dailyReport
			, @SessionAttribute("session") UserCustom session) {
		
        log.debug("[insertDailyReport] insertDailyReport : {}", dailyReport);

		dailyReport.setInputStaff(session.getUserId());
		dailyReport.setUpdateStaff(session.getUserId());
		dailyReport.setInputIp(Utils.getClientIpAddress(req));
		dailyReport.setUpdateIp(Utils.getClientIpAddress(req));
        ResultVO result = dpService.insertDailyReport(dailyReport);
		return result;
	}
	
	/**
	 * 일매출리포트 엑셀 파일 읽어오기
	 * >> DB에 insert 하는 작업은 없음
	 * 
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 * @throws JSONException
	 * @throws IOException
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/readDailyReportExcel", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO readDailyReportExcel(HttpServletRequest req, ModelMap model)
			throws JSONException, IOException, ParseException {
		
		ResultVO result = new ResultVO();
		DailyReport dailyReport = new DailyReport();

        MultipartHttpServletRequest multi = (MultipartHttpServletRequest) req;
        MultipartFile file = multi.getFile("excelFile");

        log.debug("[readDailyReportExcel] file : {}", file);
        
        if (file.isEmpty()) {
        	result.setCode("9999");
        	result.setMessage("업로드할 파일이 존재하지 않습니다.");
        } else {    	
        	dailyReport = dpService.readDailyReportExcel(file);
        	if (dailyReport != null) {
        		dailyReport.setCloseYn("N");
        		result.setData(dailyReport);
        	}
        } 
			
		return result;
	}
	
	
	/**
	 * 엑셀 업로드 
	 * 참고 예제 : https://m.blog.naver.com/PostView.nhn?blogId=sh_park0107&logNo=130175605306&proxyReferer=https%3A%2F%2Fwww.google.com%2F
	 * 
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 * @throws JSONException
	 * @throws IOException
	 * @throws ParseException 
	 */
	@RequestMapping(value = "/uploadDailyReport", method = RequestMethod.POST)
	@ResponseBody
	public ResultVO uploadDailyReport(HttpServletRequest req, ModelMap model
			, @SessionAttribute("session") UserCustom session)
			throws JSONException, IOException, ParseException {
		
		ResultVO result = new ResultVO();

        MultipartHttpServletRequest multi = (MultipartHttpServletRequest) req;
        MultipartFile file = multi.getFile("excelFile");

        log.debug("[uploadDailyReport] file : {}", file);
        
        if (file.isEmpty()) {
        	result.setCode("9999");
        	result.setMessage("업로드할 파일이 존재하지 않습니다.");
        } else {
        	DailyReport dailyReport = new DailyReport();
    		dailyReport.setInputStaff(session.getUserId());
    		dailyReport.setUpdateStaff(session.getUserId());
    		dailyReport.setInputIp(Utils.getClientIpAddress(req));
    		dailyReport.setUpdateIp(Utils.getClientIpAddress(req));
            result = dpService.uploadDailyReport(file, dailyReport);
        } 
			
		return result;
	}
	
	@PostMapping("/dailySales/sendCloseSms")  
	@ResponseBody
	public Map<String, Object> sendCloseSms (@RequestBody Map<String, Object> params, HttpServletRequest req) {
		Map<String, Object> map = new HashMap<String, Object>();	
		try {
			@SuppressWarnings("unchecked")
			List<Map<String, Object>> smsList = (List<Map<String, Object>>) params.get("smsList");
			String txt = (String) params.get("smsText");
			
			for(Map<String, Object> item : smsList) {				
				// SMS 전송
				Map<String, Object> smsParams = new HashMap<>();
			
				smsParams.put("hpNo", (item.get("cdTitle3")).toString().replace("-", ""));
				smsParams.put("sendMsg", txt);
				
				commonService.sendSms(smsParams);
			}
			
			map.put("result", true);
		} catch(Exception e) {			
			map.put("result", false);
			map.put("message", "마감문자 전송 중 오류가 발생했습니다.");
		}
		
		return map;
	}
	
}
 	