package com.vctgo.file;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import com.vctgo.common.swagger.annotation.EnableCustomSwagger2;

/**
 * 文件服务
 *
 * @author vctgo
 */
@Slf4j
@EnableCustomSwagger2
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class })
public class VctgoFileApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(VctgoFileApplication.class, args);
        log.info(" (^^)／▽ ▽＼(^^)------vctgo文件服务启动成功---(^_^)／★＼(^_^) \n");
    }
}
