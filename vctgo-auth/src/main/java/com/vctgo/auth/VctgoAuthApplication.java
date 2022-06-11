package com.vctgo.auth;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import com.vctgo.common.security.annotation.EnableVctgoFeignClients;

/**
 * 认证授权中心
 *
 * @author vctgo
 */
@Slf4j
@EnableVctgoFeignClients
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
public class VctgoAuthApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(VctgoAuthApplication.class, args);
        log.info(" (^^)／▽ ▽＼(^^)------vctgo权限启动成功---(^_^)／★＼(^_^) \n");
    }
}
