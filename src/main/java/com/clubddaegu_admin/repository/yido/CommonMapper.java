package com.clubddaegu_admin.repository.yido;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;


@Mapper
@Repository
public interface CommonMapper {

	public void sendSms(Map<String, Object> params) throws Exception;

}



