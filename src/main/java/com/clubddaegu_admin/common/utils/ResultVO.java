package com.clubddaegu_admin.common.utils;

import com.clubddaegu_admin.model.DailyReport;
import com.clubddaegu_admin.model.SalesPlanMonth;

import lombok.Data;

@Data
public class ResultVO {
	
	private String code = "0000";
	private String message = "";
	private Object data;
	private Object data2;
	private Object sub;
	private DailyReport dailyReport;
	private DailyReport yearReport;
	private SalesPlanMonth salesPlanMonth;
	private SalesPlanMonth salesPlanYear;

}
