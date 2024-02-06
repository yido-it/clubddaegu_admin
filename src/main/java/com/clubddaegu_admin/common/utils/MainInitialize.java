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
		} catch (Exception e) {
			System.out.println(e);
		}
	}
	
}
