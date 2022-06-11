package com.vctgo.system.service.impl;

import java.util.List;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.vctgo.system.domain.SysSimplePackage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.vctgo.system.mapper.SysTenantPackageMapper;
import com.vctgo.system.domain.SysTenantPackage;
import com.vctgo.system.service.ISysTenantPackageService;


/**
 * 租户套餐Service业务层处理
 *
 * @author vctgo
 * @date 2022-03-25
 */
@Service
public class SysTenantPackageServiceImpl implements ISysTenantPackageService
{
    @Autowired
    private SysTenantPackageMapper sysTenantPackageMapper;

    /**
     * 查询租户套餐
     *
     * @param id 租户套餐主键
     * @return 租户套餐
     */
    @Override
    public SysTenantPackage selectSysTenantPackageById(Long id)
    {
        return sysTenantPackageMapper.selectById(id);
    }

    /**
     * 查询租户套餐精简列表
     */
    @Override
    public List<SysSimplePackage> getSimpleList() {
        return sysTenantPackageMapper.getSimpleList();
    }

    /**
     * 查询租户套餐列表
     *
     * @param sysTenantPackage 租户套餐
     * @return 租户套餐
     */
    @Override
    public IPage<SysTenantPackage> selectSysTenantPackageList(SysTenantPackage sysTenantPackage)
    {
        return sysTenantPackageMapper.selectSysTenantPackageList(sysTenantPackage);
    }

    /**
     * 新增租户套餐
     *
     * @param sysTenantPackage 租户套餐
     * @return 结果
     */
    @Override
    public int insertSysTenantPackage(SysTenantPackage sysTenantPackage)
    {
        return sysTenantPackageMapper.insert(sysTenantPackage);
    }

    /**
     * 修改租户套餐
     *
     * @param sysTenantPackage 租户套餐
     * @return 结果
     */
    @Override
    public int updateSysTenantPackage(SysTenantPackage sysTenantPackage)
    {
        return sysTenantPackageMapper.updateById(sysTenantPackage);
    }

    /**
     * 批量删除租户套餐
     *
     * @param ids 需要删除的租户套餐主键
     * @return 结果
     */
    @Override
    public int deleteSysTenantPackageByIds(Long[] ids)
    {
        return sysTenantPackageMapper.deleteSysTenantPackageByIds(ids);
    }

    /**
     * 查询导出
     * @return 租户套餐
     */
    @Override
    public List<SysTenantPackage> selectSysTenantPackageExport(SysTenantPackage sysTenantPackage) {
        return sysTenantPackageMapper.selectSysTenantPackageExport(sysTenantPackage);
    }
}
