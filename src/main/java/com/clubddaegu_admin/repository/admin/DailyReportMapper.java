package com.clubddaegu_admin.repository.admin;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubddaegu_admin.model.DailyReport;

@Mapper
@Repository
public interface DailyReportMapper {
	

	public DailyReport getDailyReport(DailyReport dailyReport);
	
	public DailyReport getYearReport(DailyReport dailyReport);
	
	public int insertDailyReport(DailyReport dailyReport);
	
	public int insertDailyReportLog(DailyReport dailyReport);
	
	public int deleteDailyReport(DailyReport dailyReport);
	
	

}
