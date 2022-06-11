package com.vctgo.system.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.vctgo.system.mapper.SysDemoMapper;
import com.vctgo.system.domain.SysDemo;
import com.vctgo.system.service.ISysDemoService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.vctgo.common.core.text.Convert;
import com.vctgo.common.core.utils.ServletUtils;
import com.vctgo.common.mybatisplus.constant.MybatisPageConstants;
/**
 * 测试Service业务层处理
 *
 * @author vctgo
 * @date 2022-04-11
 */
@Service
public class SysDemoServiceImpl implements ISysDemoService
{
    @Autowired
    private SysDemoMapper sysDemoMapper;

    /**
     * 查询测试
     *
     * @param demoId 测试主键
     * @return 测试
     */
    @Override
    public SysDemo selectSysDemoByDemoId(Long demoId)
    {
        return sysDemoMapper.selectById(demoId);
    }

    /**
     * 查询测试列表-分页
     *
     * @param sysDemo 测试
     * @return 测试
     */
    @Override
    public IPage<SysDemo> selectSysDemoPage(SysDemo sysDemo)
    {
        Page mpPage =new Page(Convert.toLong(ServletUtils.getParameterToInt(MybatisPageConstants.PAGE_NUM),1L)
                ,Convert.toLong(ServletUtils.getParameterToInt(MybatisPageConstants.PAGE_SIZE),10L));
        return sysDemoMapper.selectSysDemoList(mpPage,sysDemo);
    }
    /**
     * 查询测试列表
     *
     * @param sysDemo 测试
     * @return 测试
     */
    @Override
    public List<SysDemo> selectSysDemoList(SysDemo sysDemo)
    {
        return sysDemoMapper.selectSysDemoList(sysDemo);
    }

    /**
     * 新增测试
     *
     * @param sysDemo 测试
     * @return 结果
     */

    @Override
    public int insertSysDemo(SysDemo sysDemo)
    {
        return sysDemoMapper.insert(sysDemo);
    }

    /**
     * 修改测试
     *
     * @param sysDemo 测试
     * @return 结果
     */
    @Override
    public int updateSysDemo(SysDemo sysDemo)
    {
        return sysDemoMapper.updateById(sysDemo);
    }

    /**
     * 批量删除测试
     *
     * @param demoIds 需要删除的测试主键
     * @return 结果
     */
    @Override
    public int deleteSysDemoByDemoIds(Long[] demoIds)
    {
        return sysDemoMapper.deleteSysDemoByDemoIds(demoIds);
    }

    /**
     * 删除测试信息
     *
     * @param demoId 测试主键
     * @return 结果
     */
    @Override
    public int deleteSysDemoByDemoId(Long demoId)
    {
        return sysDemoMapper.deleteById(demoId);
    }
}
