package com.vctgo.job;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import com.vctgo.common.security.annotation.EnableCustomConfig;
import com.vctgo.common.security.annotation.EnableVctgoFeignClients;
import com.vctgo.common.swagger.annotation.EnableCustomSwagger2;

@Slf4j
@EnableCustomConfig
@EnableCustomSwagger2
@EnableVctgoFeignClients
@SpringBootApplication
public class VctgoJobApplication {

    public static void main(String[] args) {
        SpringApplication.run(VctgoJobApplication.class, args);
        log.info(" (^^)／▽ ▽＼(^^)------vctgo定时任务模块启动成功---(^_^)／★＼(^_^) \n");
    }

}
