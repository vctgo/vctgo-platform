package com.vctgo.system.api.factory;

import com.vctgo.system.api.RemoteSmsService;
import com.vctgo.system.api.domain.SmsResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cloud.openfeign.FallbackFactory;
import org.springframework.stereotype.Component;

/**
 * @description: 短信服务降级处理
 * @author: xuchao
 * @time: 2022/4/20 13:24
 */
@Component
public class RemoteSmsFallbackFactory implements FallbackFactory<RemoteSmsService>
{
    private static final Logger log = LoggerFactory.getLogger(RemoteSmsFallbackFactory.class);

    @Override
    public RemoteSmsService create(Throwable throwable)
    {
        log.error("短信服务调用失败:{}", throwable.getMessage());
        return new RemoteSmsService()
        {
            @Override
            public SmsResult getToken(String account, String password){return null;}

            @Override
            public SmsResult sendMessage(String signName, String massage, String mobiles, String authorization){return null;}
        };

    }
}
