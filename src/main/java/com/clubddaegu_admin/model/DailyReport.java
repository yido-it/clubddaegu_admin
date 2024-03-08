package com.clubddaegu_admin.model;

import com.clubddaegu_admin.common.utils.Globals;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 일매출 테이블
 * 
 * @author bae
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DailyReport {
	
	private String closeDate;			// 마감일자
	private int dailyRoomSalesCnt;		// 일 판매 객실수
	private long dailySalesTarget;		// 당일 매출액 목표
	private long dailySalesActual;		// 당일 매출액 실적	
	private long roomSales;				// 객실매출
	private long roomPrice;				// 객실단가
	private long restaurantSales;		// 식음매출
	private long etcSales;				// 기타매출
	private long monthSales;			// 당월실적
	private long monthSum;// 월매출
	private String remark;				// 비고
	private String inputStaff;		
	private String inputDatetime;		
	private String inputIp;	
	private String updateStaff;		
	private String updateDatetime;		
	private String updateIp;		

	/* 기타 */
	private String searchDt;		// 검색일 YYYYMMDD
	private String searchDt2;		// 검색일 YYYY-MM-DD
	private String planYear;		// YYYY
	private String planMonth;		// YYYYMM
	private String closeYn; 		// 마감여부 > Y : 마감 , N : 미마감
	private long yearlySalesActual;	// 연간실적  
	private String logDiv;			// I : insert , U : update , D : delete
	
	/* 일별마감 이미지 */
	private String imgName;
	private String imgPath;
	
	public String getFileURL() {
	
		return Globals.endPoint + "/" + Globals.bucketName + "/" + this.imgPath + this.imgName; 
	}
}


