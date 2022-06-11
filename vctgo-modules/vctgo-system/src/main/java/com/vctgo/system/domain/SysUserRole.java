package com.vctgo.system.domain;

import lombok.Data;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

/**
 * 用户和角色关联 sys_user_role
 *
 * @author vctgo
 */
@Data
public class SysUserRole
{
    /** 用户ID */
    private Long userId;

    /** 角色ID */
    private Long roleId;

    /** 租户ID */
    private Long tenantId;
}
