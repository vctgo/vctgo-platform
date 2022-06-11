package com.vctgo.modules.monitor;

import com.vctgo.common.security.annotation.EnableCustomConfig;
import com.vctgo.common.security.annotation.EnableVctgoFeignClients;
import com.vctgo.common.swagger.annotation.EnableCustomSwagger2;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * 监控中心
 *
 * @author vctgo
 */
@Slf4j
@EnableCustomConfig
@EnableCustomSwagger2
@EnableVctgoFeignClients
@SpringBootApplication
@EnableScheduling
public class VctgoMonitorApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(VctgoMonitorApplication.class, args);
        log.info(" (^^)／▽ ▽＼(^^)------vctgo监控中心模块启动成功---(^_^)／★＼(^_^) \n");
    }
}
