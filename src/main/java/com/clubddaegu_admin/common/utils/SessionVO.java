package com.clubddaegu_admin.common.utils;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class SessionVO {
	
	/* 기본 정보 */
	private int iNo;
	private String agentCode; 		//업장번호 ex)년월(4) + 일련번호(4)
	private String mbNo; 			//회원번호 ex) YYMM + 일련번호(6)
	private String mbId;			//회원아이디
	private String mbName; 			//회원명
	private String hpNo; 			//핸드폰번호 ex 01012341234
	private String birthDate; 		//생년월일 2000-09-20
	private String sex; 			//성별 ex) 남 : M, 여 : W
	private String mbCode; 			//회원구분 ex) 일반회원 1, 연간회원 2
	private String mbCardNo; 		// 회원카드번호
	private String mbSajin; 		// 회원사진
	private String pMBName; 		// 보호자성명
	private String pMBHpNo; 		// 보호자핸드폰번호
	private String regiDate; 		// 가입일자 2000-09-20
	private String regiTime; 		// 가입시간
	private String isLeave; 		// 탈퇴여부
	private String leaveDate; 		// 탈퇴일자 2000-09-20
	private String leaveTime; 		// 탈퇴시간
	private String isDel; 			// 삭제유무
	private String msEmail; 		// 이메일
	private String msMktAgreeYN; 	// 마케팅동의여부(약관동의)
	private String msSessionKey; 	// 자동로그인 세션키
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss", timezone = "Asia/Seoul")
	@DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime msSessionLimit;	// 자동로그인 세션 유효기간
	private String msPushKey; 		// 토큰키
	private String msSmsYN; 		// 문자발송여부
	private String msEmailYN; 		// 이메일수신여부
	private String msArea1; 		// 지역코드1 - 220
	private String msArea2;			// 지역코드2 - 221
	private String msLoginCd;		// 로그인구분 - 030
	private String msDormant;		// 휴면계정구분
	private String dupInfo;			// 중복가입 확인값(DI)
	private String connInfo;		// 연계정보 확인값(CI)

	/* 컬럼 외  */
	private String ipAddr;
	private String yymm;
	private String naverToken;

	public String getYymm() {
		Date now = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyMM");
		String formattedNow = simpleDateFormat.format(now); 
		return formattedNow; 
	}
}
