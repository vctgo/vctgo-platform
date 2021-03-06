package com.vctgo.system.mapper;

import java.util.List;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.vctgo.common.mybatisplus.mapper.BaseMapperX;
import com.vctgo.common.mybatisplus.query.LambdaQueryWrapperX;
import com.vctgo.system.domain.SysSimplePackage;
import com.vctgo.system.domain.SysTenantPackage;

/**
 * 租户套餐Mapper接口
 *
 * @author vctgo
 * @date 2022-03-25
 */
public interface SysTenantPackageMapper extends BaseMapperX<SysTenantPackage>
{
    /**
     * 查询租户套餐列表
     */
    default IPage<SysTenantPackage> selectSysTenantPackageList(SysTenantPackage sysTenantPackage) {
        return selectPage(new LambdaQueryWrapperX<SysTenantPackage>()
                .likeIfPresent(SysTenantPackage::getName,sysTenantPackage.getName())
                .eqIfPresent(SysTenantPackage::getStatus,sysTenantPackage.getStatus())
        );
    }

    /**
     * 导出租户套餐列表
     */
    default List<SysTenantPackage> selectSysTenantPackageExport(SysTenantPackage sysTenantPackage){
        return selectList(new LambdaQueryWrapperX<SysTenantPackage>()
                .likeIfPresent(SysTenantPackage::getName,sysTenantPackage.getName())
                .eqIfPresent(SysTenantPackage::getStatus,sysTenantPackage.getStatus()));
    }
    /**
     * 查询租户套餐精简列表
     *
     * @return 租户套餐
     */
    List<SysSimplePackage> getSimpleList();

    /**
     * 批量删除租户套餐
     *
     * @param ids 需要删除的数据主键集合
     * @return 结果
     */
    int deleteSysTenantPackageByIds(Long[] ids);
}
