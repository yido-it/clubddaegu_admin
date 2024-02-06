package com.clubddaegu_admin.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubddaegu_admin.model.CdCommon;
import com.clubddaegu_admin.repository.admin.AdminCommonMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("AdminCommonService")
public class AdminCommonService {
	@Autowired
	private AdminCommonMapper adminCommonMapper;

    public List<CdCommon> getCommonCodeList(CdCommon cdCommon) {
    	return adminCommonMapper.getCommonCodeList(cdCommon);
    }
    
 
}
