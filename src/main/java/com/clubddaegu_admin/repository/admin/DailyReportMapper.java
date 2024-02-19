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
	
	public DailyReport selectReportPicture(DailyReport dailyReport);
	
	// 일별마감 이미지 등록 
	public int insertReportPicture(DailyReport dailyReport);
	
	// 일별마감 이미지 삭제
	public int deleteReportPicture(DailyReport dailyReport);
	
	// 일별마감 이미지 마감여부 변경
	public int updateCloseYn(DailyReport dailyReport);

}
