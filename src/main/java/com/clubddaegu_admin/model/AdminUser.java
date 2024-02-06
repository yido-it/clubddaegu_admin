package com.clubddaegu_admin.model;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

/**
 * 테이블명 : ADMIN_USER
 * 테이블 설명 : 어드민 유저 테이블
 */

@Data
@Builder(toBuilder = true)   
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = false)
public class AdminUser {

	private String userId;	
	private String userNm;	
	private String userPw;	
	private String userAuth;	
	private String userAuthNm;	
	private Boolean useYn;	
	private String inputStaff;
	
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime inputDatetime;	
	private String inputIp;	

}


