package com.vctgo.job.core.alarm;

import com.vctgo.job.domain.XxlJobInfo;
import com.vctgo.job.domain.XxlJobLog;

public interface JobAlarm {

    /**
     * job alarm
     *
     * @param info
     * @param jobLog
     * @return
     */
    boolean doAlarm(XxlJobInfo info, XxlJobLog jobLog);

}
