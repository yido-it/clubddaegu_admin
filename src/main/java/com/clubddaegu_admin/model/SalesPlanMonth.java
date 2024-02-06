package com.clubddaegu_admin.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 계획 테이블
 * 
 * @author bae
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class SalesPlanMonth {

	private String planMonth;		// 월
	private long roomRevenue;		// 객실매출
	private long totalFood;			// 식음매출
	private long totalOther;		// 기타매출	
	private long cogs;				// 매출원가
	private long sgna;				// 판관비
	private long overheadCharges;	// 공통비용
	private int roomAvailable;		// 판매가능룸수

	/* 기타 */
	private String planYear;		// 년 YYYY
	
}


