package com.vctgo.common.log.service;

import com.vctgo.common.security.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import com.vctgo.common.core.constant.SecurityConstants;
import com.vctgo.system.api.RemoteLogService;
import com.vctgo.system.api.domain.SysOperLog;

/**
 * 异步调用日志服务
 *
 * @author vctgo
 */
@Service
public class AsyncLogService
{
    @Autowired
    private RemoteLogService remoteLogService;

    /**
     * 保存系统日志记录
     */
    @Async
    public void saveSysLog(SysOperLog sysOperLog)
    {
        sysOperLog.setTenantId(SecurityUtils.getTenantId());
        remoteLogService.saveLog(sysOperLog, SecurityConstants.INNER);
    }
}
