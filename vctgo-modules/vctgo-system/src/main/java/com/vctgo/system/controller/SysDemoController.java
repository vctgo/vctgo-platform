package com.vctgo.system.controller;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.vctgo.common.log.annotation.Log;
import com.vctgo.common.log.enums.BusinessType;
import com.vctgo.common.security.annotation.RequiresPermissions;
import com.vctgo.system.domain.SysDemo;
import com.vctgo.system.service.ISysDemoService;
import com.vctgo.common.core.web.controller.BaseController;
import com.vctgo.common.core.web.domain.AjaxResult;
import com.vctgo.common.core.utils.poi.ExcelUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;

/**
 * 测试Controller
 *
 * @author vctgo
 * @date 2022-04-11
 */
@RestController
@RequestMapping("/demo")
public class SysDemoController extends BaseController
{
    @Autowired
    private ISysDemoService sysDemoService;

    /**
     * 查询测试列表
     */
    @RequiresPermissions("system:demo:list")
    @GetMapping("/list")
    public AjaxResult list(SysDemo sysDemo)
    {
        IPage<SysDemo> list = sysDemoService.selectSysDemoPage(sysDemo);
        return AjaxResult.success(list);
    }

    /**
     * 导出测试列表
     */
    @RequiresPermissions("system:demo:export")
    @Log(title = "测试", businessType = BusinessType.EXPORT)
    @PostMapping("/export")
    public void export(HttpServletResponse response, SysDemo sysDemo)
    {
        List<SysDemo> list = sysDemoService.selectSysDemoList(sysDemo);
        ExcelUtil<SysDemo> util = new ExcelUtil<SysDemo>(SysDemo.class);
        util.exportExcel(response, list, "测试数据");
    }

    /**
     * 获取测试详细信息
     */
    @RequiresPermissions("system:demo:query")
    @GetMapping(value = "/{demoId}")
    public AjaxResult getInfo(@PathVariable("demoId") Long demoId)
    {
        return AjaxResult.success(sysDemoService.selectSysDemoByDemoId(demoId));
    }

    /**
     * 新增测试
     */
    @RequiresPermissions("system:demo:add")
    @Log(title = "测试", businessType = BusinessType.INSERT)
    @PostMapping
    public AjaxResult add(@RequestBody SysDemo sysDemo)
    {
        return toAjax(sysDemoService.insertSysDemo(sysDemo));
    }

    /**
     * 修改测试
     */
    @RequiresPermissions("system:demo:edit")
    @Log(title = "测试", businessType = BusinessType.UPDATE)
    @PutMapping
    public AjaxResult edit(@RequestBody SysDemo sysDemo)
    {
        return toAjax(sysDemoService.updateSysDemo(sysDemo));
    }

    /**
     * 删除测试
     */
    @RequiresPermissions("system:demo:remove")
    @Log(title = "测试", businessType = BusinessType.DELETE)
	@DeleteMapping("/{demoIds}")
    public AjaxResult remove(@PathVariable Long[] demoIds)
    {
        return toAjax(sysDemoService.deleteSysDemoByDemoIds(demoIds));
    }
}
