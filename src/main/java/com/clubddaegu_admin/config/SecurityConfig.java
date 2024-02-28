package com.clubddaegu_admin.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.clubddaegu_admin.security.AdminUserDetailsService;
import com.clubddaegu_admin.security.CustomAuthenticationProvider;
import com.clubddaegu_admin.security.MyAuthenticationSuccessHandler;


@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter {
    
	@Autowired
    private CustomAuthFailureHandler customAuthFailureHandler;

    @Autowired
    private AdminUserDetailsService adminUserDetailsService;

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean(name = "customAuthenticationProvider")
    public CustomAuthenticationProvider customAuthenticationProvider(AdminUserDetailsService adminUserDetailsService, PasswordEncoder passwordEncoder) {
        return new CustomAuthenticationProvider(adminUserDetailsService, passwordEncoder);
    }
    
    @Bean
    public MyAuthenticationSuccessHandler myAuthenticationSuccessHandler(){
        return new MyAuthenticationSuccessHandler();
    }
    
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(customAuthenticationProvider(adminUserDetailsService, passwordEncoder()));
//        auth
//                .userDetailsService(adminUserDetailService)
//                .passwordEncoder(passwordEncoder());
    }

    protected void configure(HttpSecurity http) throws Exception {
        http
                .headers().frameOptions().sameOrigin()
                .and()
                .authorizeRequests()
                .antMatchers("/css/**").permitAll()
                .antMatchers("/img/**").permitAll()
                .antMatchers("/image/**").permitAll()
                .antMatchers("/js/**").permitAll()
                .antMatchers("/login").permitAll()
                .antMatchers("/api/**").permitAll()
                .antMatchers("/download/**").permitAll()
                .antMatchers("/file/**").permitAll()
                .antMatchers("/insertUser/**").permitAll()
                .antMatchers("/.well-known/**").permitAll()
                
                .antMatchers("/**").hasAnyRole("ATH000", "ATH100", "ATH200", "ATH300","ATH400", "ATH500", "ATH600", "ATH700", "ATH800")
//                .antMatchers("/**").permitAll()
                .and()
                .formLogin()
                .loginPage("/login")
                .loginProcessingUrl("/checkLogin")
                .usernameParameter("userId")
                .passwordParameter("password")
                .successHandler(myAuthenticationSuccessHandler())
               // .failureUrl("/login?error")
                .failureHandler(customAuthFailureHandler) // 실패 핸들러 
                .permitAll()
                .and()
                .rememberMe()
                .key("clubd-daegu")
                .rememberMeParameter("rememberMe")
                .tokenValiditySeconds(86400 * 30)
                .userDetailsService(adminUserDetailsService)
                .authenticationSuccessHandler(myAuthenticationSuccessHandler())	// 자동로그인 안 되서 추가함
                .and()
                .logout()
                .logoutUrl("/logout")
                .logoutSuccessUrl("/succ-logout")
                .clearAuthentication(true)
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID")
                .permitAll()
                .and()
                .csrf().disable();
        
    }
    

}
