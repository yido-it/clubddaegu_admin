package com.clubddaegu_admin.config;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.boot.jdbc.DataSourceBuilder;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
 
@Configuration
@MapperScan(value="com.clubddaegu_admin.repository.yido", sqlSessionFactoryRef="secondarySqlSessionFactory")
public class SecondaryDatasource {
 
    @Bean(name="secondaryDataSource")
    @ConfigurationProperties(prefix="spring.second.datasource")
    public DataSource secondaryDataSource() {
        return DataSourceBuilder.create().build();
    }
 
    @Bean(name="secondarySqlSessionFactory")
    public SqlSessionFactory secondarySqlSessionFactoryBean(@Autowired @Qualifier("secondaryDataSource") DataSource secondaryDataSource, ApplicationContext applicationContext)
            throws Exception {
        SqlSessionFactoryBean factoryBean = new SqlSessionFactoryBean();
        factoryBean.setDataSource(secondaryDataSource);
        factoryBean.setConfigLocation(applicationContext.getResource("classpath:mybatis-config.xml"));
        factoryBean.setMapperLocations(applicationContext.getResources("classpath:mapper/**/**.xml"));
        return factoryBean.getObject();
    }
    
    @Bean(name = "secondarySqlSessionTemplate")
    public SqlSessionTemplate secondarySqlSessionTemplate(SqlSessionFactory secondarySqlSessionFactoryBean) throws Exception {
        return new SqlSessionTemplate(secondarySqlSessionFactoryBean);
    }



/*    @Bean(name="secondarySqlSession")
    public SqlSession secondarySqlSession(@Autowired @Qualifier("secondarySqlSessionFactory") SqlSessionFactory secondarySqlSessionFactory) {
        return new SqlSessionTemplate(secondarySqlSessionFactory);
    }
     
    @Bean(name="secondaryTransactionManager")
    public DataSourceTransactionManager secondaryTransactionManager(@Autowired @Qualifier("secondaryDataSource") DataSource secondaryDataSource) {
        return new DataSourceTransactionManager(secondaryDataSource);
    }*/
 
}
