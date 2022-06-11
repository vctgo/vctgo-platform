package com.vctgo.gateway;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;


/**
 * 网关启动程序
 *
 * @author vctgo
 */
@Slf4j
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
public class VctgoGatewayApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(VctgoGatewayApplication.class, args);
        log.info(" (^^)／▽ ▽＼(^^)------vctgo网关启动成功---(^_^)／★＼(^_^) \n");
    }
}
