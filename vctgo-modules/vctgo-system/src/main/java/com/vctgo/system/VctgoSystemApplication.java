package com.vctgo.system;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.vctgo.common.security.annotation.EnableCustomConfig;
import com.vctgo.common.security.annotation.EnableVctgoFeignClients;
import com.vctgo.common.swagger.annotation.EnableCustomSwagger2;

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
public class VctgoSystemApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(VctgoSystemApplication.class, args);
        log.info(" (^^)／▽ ▽＼(^^)------vctgo系统模块启动成功---(^_^)／★＼(^_^) \n");
    }
}
