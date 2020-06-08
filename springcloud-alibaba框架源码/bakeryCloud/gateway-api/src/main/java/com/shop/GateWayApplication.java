package com.shop;

import com.shop.common.config.DataSourceProxyConfig;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.FilterType;

@EnableDiscoveryClient
@SpringBootApplication
@EnableAutoConfiguration(exclude={DataSourceAutoConfiguration.class})
@ComponentScan(excludeFilters= {@ComponentScan.Filter(type=FilterType.ASSIGNABLE_TYPE, classes = {DataSourceProxyConfig.class})})
public class GateWayApplication {
    public static void main(String[] args){
        SpringApplication.run(GateWayApplication.class,args);
    }
}
