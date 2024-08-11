package com.vctgo.demo;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.vctgo.common.security.annotation.EnableCustomConfig;
import com.vctgo.common.security.annotation.EnableVctgoFeignClients;
import com.vctgo.common.swagger.annotation.EnableCustomSwagger2;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 系统模块
 *
 * @author vctgo
 */
@Slf4j
@EnableCustomConfig
@EnableCustomSwagger2
@EnableVctgoFeignClients
@SpringBootApplication
public class VctgoDemoApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(VctgoDemoApplication.class, args);
        log.info(" (^^)／▽ ▽＼(^^)------vctgo Demo样例模块启动成功---(^_^)／★＼(^_^) \n");
    }
}
