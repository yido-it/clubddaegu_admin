package com.clubddaegu_admin.repository.admin;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.clubddaegu_admin.model.SalesPlanMonth;

@Mapper
@Repository
public interface SalesPlanMonthMapper {
	

	public SalesPlanMonth getSalesPlanMonth(SalesPlanMonth salesPlanMonth);

	public SalesPlanMonth getSalesPlanYear(SalesPlanMonth salesPlanMonth);
	

}
