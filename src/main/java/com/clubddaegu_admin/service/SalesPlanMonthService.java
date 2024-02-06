package com.clubddaegu_admin.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.clubddaegu_admin.model.SalesPlanMonth;
import com.clubddaegu_admin.repository.admin.SalesPlanMonthMapper;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class SalesPlanMonthService {
	
	@Autowired
	public SalesPlanMonthMapper spmMapper;

    public SalesPlanMonth getSalesPlanMonth(SalesPlanMonth spm) {
    	return spmMapper.getSalesPlanMonth(spm);
    }
    
    public SalesPlanMonth getSalesPlanYear(SalesPlanMonth spm) {
    	return spmMapper.getSalesPlanYear(spm);
    }


 
}
