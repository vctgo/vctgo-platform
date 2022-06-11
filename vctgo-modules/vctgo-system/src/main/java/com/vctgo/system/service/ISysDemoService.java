package com.vctgo.system.service;

import java.util.List;
import com.vctgo.system.domain.SysDemo;
import com.baomidou.mybatisplus.core.metadata.IPage;

/**
 * 测试Service接口
 *
 * @author vctgo
 * @date 2022-04-11
 */
public interface ISysDemoService
{
    /**
     * 查询测试
     *
     * @param demoId 测试主键
     * @return 测试
     */
    SysDemo selectSysDemoByDemoId(Long demoId);

    /**
     * 查询测试列表-分页
     *
     * @param sysDemo 测试
     * @return 测试集合
     */
    IPage<SysDemo> selectSysDemoPage(SysDemo sysDemo);
    /**
     * 查询测试列表
     *
     * @param sysDemo 测试
     * @return 测试集合
     */
    List<SysDemo> selectSysDemoList(SysDemo sysDemo);

    /**
     * 新增测试
     *
     * @param sysDemo 测试
     * @return 结果
     */
    int insertSysDemo(SysDemo sysDemo);

    /**
     * 修改测试
     *
     * @param sysDemo 测试
     * @return 结果
     */
    int updateSysDemo(SysDemo sysDemo);

    /**
     * 批量删除测试
     *
     * @param demoIds 需要删除的测试主键集合
     * @return 结果
     */
    int deleteSysDemoByDemoIds(Long[] demoIds);

    /**
     * 删除测试信息
     *
     * @param demoId 测试主键
     * @return 结果
     */
    int deleteSysDemoByDemoId(Long demoId);
}
