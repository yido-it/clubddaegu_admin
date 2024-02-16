package com.clubddaegu_admin.common.utils;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.stereotype.Service;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@PropertySources({ @PropertySource("classpath:application.properties") })
public class MainInitialize {
	
	@Value("${spring.profiles.active}")
	public String serverType;

	@PostConstruct
	public void init() {
		try {
			log.info("======================= Initialize Start =======================");
			Globals.serverType = Utils.getProperties("spring.profiles.active", "");
			log.info("serverType : " + Globals.serverType);
			Globals.serverIpAddress = Utils.getLocalIpAddr();
			log.info("Server Ip Address : " + Globals.serverIpAddress);		
			//Globals.fileUploadPath = filePath;
			
			Globals.reportFileRoot  = Utils.getPropertiesByType("report.file.root", "", serverType);
			log.info("reportFileRoot : " + Globals.reportFileRoot);
			log.info("======================= Initialize Finish =======================");
			
			log.info("======================= AWS S3 Info Start =======================");			
			Globals.accessKey = Utils.getProperties("Globals.awsS3.accessKey", "");
			log.info("AWS S3 accessKey : " + Globals.accessKey);
			Globals.secretKey = Utils.getProperties("Globals.awsS3.secretKey", "");
			log.info("AWS S3 secretKey : " + Globals.secretKey);
			Globals.endPoint = Utils.getProperties("Globals.awsS3.endPoint", "");
			log.info("AWS S3 endPoint : " + Globals.endPoint);
			Globals.bucketName = Utils.getProperties("Globals.awsS3.bucketName", "");			
			log.info("AWS S3 bucketName : " + Globals.bucketName);
			log.info("======================= AWS S3 Info Finish =======================");
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
}
