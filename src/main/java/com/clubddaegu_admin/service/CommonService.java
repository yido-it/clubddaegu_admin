package com.clubddaegu_admin.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubddaegu_admin.repository.yido.CommonMapper;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service("CommonService")
public class CommonService {
	
	@Autowired
	private CommonMapper commonMapper;
	

	public void sendSms(Map<String, Object> params) throws Exception {
		commonMapper.sendSms(params);
	}


}
