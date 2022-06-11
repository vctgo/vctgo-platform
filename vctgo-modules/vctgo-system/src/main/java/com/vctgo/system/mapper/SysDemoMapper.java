package com.vctgo.system.mapper;

import java.util.List;
import com.vctgo.system.domain.SysDemo;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.vctgo.common.mybatisplus.mapper.BaseMapperX;
import org.apache.ibatis.annotations.Param;
/**
 * 测试Mapper接口
 *
 * @author vctgo
 * @date 2022-04-11
 */
public interface SysDemoMapper extends BaseMapperX<SysDemo>
{

    /**
     * 查询测试列表-分页
     *
     * @param sysDemo 测试
     * @return 测试集合
     */
    IPage<SysDemo> selectSysDemoList(Page page,@Param("query") SysDemo sysDemo);
    /**
     * 查询测试列表
     *
     * @param sysDemo 测试
     * @return 测试集合
     */
    List<SysDemo> selectSysDemoList(@Param("query") SysDemo sysDemo);

    /**
     * 批量删除测试
     *
     * @param demoIds 需要删除的数据主键集合
     * @return 结果
     */
    int deleteSysDemoByDemoIds(Long[] demoIds);
}
