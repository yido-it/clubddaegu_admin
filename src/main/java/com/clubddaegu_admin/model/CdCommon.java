package com.clubddaegu_admin.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * 테이블명 : CO_COMMON
 * 테이블 설명 : 공통코드
 * 
 * @author bae
 *
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class CdCommon {

	private String coDiv;			// 지점코드
	private String cdDivision;		// 코드구분
	private String cdCode;			// 세부코드
	private String cdTitle1;		// 코드명
	private String cdTitle2;		
	private String cdTitle3;		
	private String cdTitle4;		
	private String cdUseyn;
	private String cdSort;
	private String cdLength;
	private String cdType;
	private String cdRefer;
	private String cdRefer2;
	
	private String userId;
	private String ipAddr;;
	

}


