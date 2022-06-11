package com.vctgo.gen;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.vctgo.common.security.annotation.EnableCustomConfig;
import com.vctgo.common.security.annotation.EnableVctgoFeignClients;
import com.vctgo.common.swagger.annotation.EnableCustomSwagger2;

/**
 * 代码生成
 *
 * @author vctgo
 */
@Slf4j
@EnableCustomConfig
@EnableCustomSwagger2
@EnableVctgoFeignClients
@SpringBootApplication
public class VctgoGenApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(VctgoGenApplication.class, args);
        log.info(" (^^)／▽ ▽＼(^^)------vctgo代码生成模块启动成功---(^_^)／★＼(^_^) \n");
    }
}
