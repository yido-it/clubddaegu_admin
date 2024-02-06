package com.clubddaegu_admin;

import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

@EnableAsync
@EnableAspectJAutoProxy
@EnableScheduling
@SpringBootApplication
public class clubddaeguAdminApplication {

	public static void main(String[] args) {
		//SpringApplication.run(asset_manageApplication.class, args);
		/* jasper report viewer 출력을 위한 headless 변경*/
		SpringApplicationBuilder builder = new SpringApplicationBuilder(clubddaeguAdminApplication.class);
		builder.headless(false);
		ConfigurableApplicationContext context = builder.run(args);
	}

}
