package com.vctgo.system.api;

import com.vctgo.common.core.constant.ServiceNameConstants;
import com.vctgo.system.api.domain.SmsResult;
import com.vctgo.system.api.factory.RemoteSmsFallbackFactory;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

/**
 * # 短信服务 测试服务器 config
 * sms:
 *   account:
 *   password:
 *   title: 菜盟
 *   url: http://
 *   login: /api/admin/login
 *   loginType: Content-Type=application/json
 *   sendSms: /api/sms/telecom/sendSms
 *   sendSmsType: Content-Type=multipart/form-data
 *
 * @author xuchao
 */
@FeignClient(url="${sms.url}",value = ServiceNameConstants.SYSTEM_SERVICE,fallbackFactory = RemoteSmsFallbackFactory.class)
public interface RemoteSmsService {

    @RequestMapping(value = "${sms.login}", method = RequestMethod.POST , headers = {"${sms.loginType}"})
    SmsResult getToken(@PathVariable("account") String account, @PathVariable("password") String password);

    @RequestMapping(value = "${sms.sendSms}", method = RequestMethod.GET, headers = {"${sms.sendSmsType}"})
    SmsResult sendMessage(@RequestParam("signName") String signName, @RequestParam("massage") String massage, @RequestParam("mobiles") String mobiles, @RequestHeader("authorization") String authorization);
}
