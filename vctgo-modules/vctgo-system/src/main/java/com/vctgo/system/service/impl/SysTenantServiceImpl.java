package com.vctgo.system.service.impl;

import java.util.*;
import java.util.stream.Collectors;

import com.vctgo.common.core.constant.CacheConstants;
import com.vctgo.common.core.context.SecurityContextHolder;
import com.vctgo.common.core.utils.StringUtils;
import com.vctgo.common.core.web.domain.AjaxResult;
import com.vctgo.common.message.mail.EmailUtil;
import com.vctgo.common.mybatisplus.util.TenantUtils;
import com.vctgo.common.redis.service.RedisService;
import com.vctgo.common.security.utils.SecurityUtils;
import com.vctgo.system.api.domain.SmsResult;
import com.vctgo.system.api.domain.SysDept;
import com.vctgo.system.api.domain.SysRole;
import com.vctgo.system.api.domain.SysUser;
import com.vctgo.system.api.model.LoginUser;
import com.vctgo.system.domain.*;
import com.vctgo.system.mapper.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import com.vctgo.system.service.ISysTenantService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.vctgo.common.core.text.Convert;
import com.vctgo.common.core.utils.ServletUtils;
import com.vctgo.common.mybatisplus.constant.MybatisPageConstants;
import org.springframework.transaction.annotation.Transactional;
import com.vctgo.system.api.RemoteSmsService;


/**
 * 租户管理Service业务层处理
 *
 * @author vctgo
 * @date 2022-04-11
 */
@Service
public class SysTenantServiceImpl implements ISysTenantService
{
    @Autowired
    private SysTenantMapper sysTenantMapper;

    @Autowired
    private SysTenantPackageMapper sysTenantPackageMapper;

    @Autowired
    private SysDeptMapper deptMapper;

    @Autowired
    private SysPostMapper sysPostMapper;

    @Autowired
    private SysRoleMapper sysRoleMapper;

    @Autowired
    private SysRoleMenuMapper sysRoleMenuMapper;

    @Autowired
    private SysUserMapper userMapper;

    @Autowired
    private SysUserRoleMapper userRoleMapper;

    @Autowired
    private SysUserPostMapper userPostMapper;

    @Autowired
    private RemoteSmsService remoteSmsService;

    @Autowired
    EmailUtil emailUtil;

    @Autowired
    private RedisService redisService;

    /**
     * 短信服务登录验证名
     */
    @Value("${sms.account}")
    private String account;

    /**
     * 短信服务登录密码
     */
    @Value("${sms.password}")
    private String password;

    /**
     * 短信标题
     */
    @Value("${sms.title}")
    private String title;

    /**
     * 查询租户管理
     *
     * @param id 租户管理主键
     * @return 租户管理
     */
    @Override
    public SysTenant selectSysTenantById(Long id)
    {
        return sysTenantMapper.selectById(id);
    }

    /**
     * 查询租户管理列表-分页
     *
     * @param sysTenant 租户管理
     * @return 租户管理
     */
    @Override
    public IPage<SysTenant> selectSysTenantPage(SysTenant sysTenant)
    {
        Page mpPage =new Page(Convert.toLong(ServletUtils.getParameterToInt(MybatisPageConstants.PAGE_NUM),1L)
                ,Convert.toLong(ServletUtils.getParameterToInt(MybatisPageConstants.PAGE_SIZE),10L));
        return sysTenantMapper.selectSysTenantList(mpPage,sysTenant);
    }
    /**
     * 查询租户管理列表
     *
     * @param sysTenant 租户管理
     * @return 租户管理
     */
    @Override
    public List<SysTenant> selectSysTenantList(SysTenant sysTenant) {return sysTenantMapper.selectSysTenantList(sysTenant);}

    /**
     * 新增租户管理
     *
     * @param sysTenant 租户管理
     * @return 结果
     */

    @Override
    @Transactional(rollbackFor = Exception.class)

    public AjaxResult insertSysTenant(SysTenant sysTenant)
    {
        AjaxResult res = new AjaxResult();
        //新增租户开始
        if (StringUtils.isEmpty(sysTenant.getId())){
            return res.error("租户编码为空,请重新设置!");
        }
        //先判断租户编码是否存在
        Long tenantcount = sysTenantMapper.selectCount("id",sysTenant.getId());
        if (tenantcount > 0)
        {
            return res.error("租户编码已存在,请重新设置!");
        }
        if (StringUtils.isEmpty(sysTenant.getUserName())){
            return res.error("管理员账号为空,请重新设置!");
        }
        //先判断admin账号是否存在
        int usercount = userMapper.checkUserNameUnique(sysTenant.getUserName());
        if (usercount > 0)
        {
            return res.error("用户名已存在,请重新设置!");
        }
        //创建租户
        sysTenantMapper.insert(sysTenant);
        //租户创建完成后 开始创建相关基础数据
        TenantUtils.execute(sysTenant.getId(), () -> {
            //创建默认部门--部门默认名称以租户名称
            Long deptid = createDept(sysTenant);
            //创建默认岗位--岗位默认为董事长
            Long postid = createPost(sysTenant.getUserName());
            //创建默认角色--角色默认为租户名称+管理员
            Long roleid = createRole(sysTenant);
            //创建默认账号
            createUser(sysTenant,deptid,postid,roleid);
        });
        return res.success("租户创建成功!");
    }

    private void createUser(SysTenant sysTenant,Long deptId,Long postid,Long roleid) {
        SysUser user = new SysUser();
        user.setDeptId(deptId).setUserName(sysTenant.getUserName()).setNickName(sysTenant.getTenantName())
                .setUserType("10")//用户类型 10 表示各租户管理员账号，不允许租户修改删除
                .setEmail(sysTenant.getUserEmail()).setPhonenumber(sysTenant.getUserPhone()).setRemark("租户管理员");
        //默认密码采用随机生成
        String randomPassword = SecurityUtils.randomStr(8);//随机密码8位

        String password = SecurityUtils.encryptPassword(randomPassword);
        user.setPassword(password);
        userMapper.insert(user);
        userPostMapper.insert(new SysUserPost().setUserId(user.getUserId()).setPostId(postid));
        userRoleMapper.insert(new SysUserRole().setRoleId(roleid).setUserId(user.getUserId()));
        /**
         * 短信功能需要更具需求定制化 目前先关闭 改为发邮件
         */
        emailUtil.sendSimpleMail("租户管理员账号注册成功","请牢记登录密码:"+randomPassword,sysTenant.getUserEmail());
        //发送短信的形式 告知租户管理员登录密码randomPassword
        //SmsResult ss = remoteSmsService.getToken(this.account,this.password);
        // String authorization = ss.getData();
        //Map<String,Object> remoterheader = new HashMap<>();
        //remoterheader.put("authorization","Bearer "+authorization);
        //SecurityContextHolder.setRemoteHeader(remoterheader);
//        remoteSmsService.sendMessage(this.title,"租户管理员账号注册成功，请牢记登录密码:"+randomPassword,sysTenant.getUserPhone(), "Bearer "+authorization);
    }

    private Long createRole(SysTenant sysTenant) {
        // 创建角色
        SysRole role = new SysRole();
        role.setRoleName(sysTenant.getTenantName()+"管理员").setRoleKey("admin")
                .setRoleSort("1").setDataScope("1").setMenuCheckStrictly(true).setDeptCheckStrictly(true);
        role.setCreateBy(sysTenant.getUserName());
        sysRoleMapper.insert(role);

        //根据租户套餐ids查出套餐编码塞入角色-菜单表（支持多套餐组合）
        createRoleMenu(sysTenant,role);
        return role.getRoleId();
    }

    //根据租户套餐ids查出套餐编码塞入角色-菜单表（支持多套餐组合）
    private void createRoleMenu(SysTenant sysTenant,SysRole role)
    {
        List<String> tenantPackageIdList =  Arrays.asList(sysTenant.getTenantPackage().split(","));
        List<String> meuns = new ArrayList<String>();
        for(String tenantPackageId : tenantPackageIdList)
        {
            SysTenantPackage sysTenantPackage = sysTenantPackageMapper.selectById(tenantPackageId);
            List<String> subMeuns = Arrays.asList(sysTenantPackage.getMenuIds().split(","));
            meuns.addAll(subMeuns);
        }
        List<String> meunsR = meuns.stream().distinct().collect(Collectors.toList());//去重

        List<SysRoleMenu> roleMenuList = meunsR.stream().map(menuid -> {
            SysRoleMenu entity = new SysRoleMenu();
            entity.setRoleId(role.getRoleId());
            entity.setMenuId(Convert.toLong(menuid));
            return entity;
        }).collect(Collectors.toList());
        sysRoleMenuMapper.batchRoleMenu(roleMenuList);
    }

    private Long createPost(String username) {
        SysPost post = new SysPost();
        post.setPostCode("ceo").setPostName("董事长").setPostSort("1");
        post.setCreateBy(username);
        sysPostMapper.insert(post);
        return post.getPostId();
    }

    private Long createDept(SysTenant sysTenant) {
        // 创建部门
        SysDept dept = new SysDept();
        dept.setParentId(0L).setAncestors("0").setDeptName(sysTenant.getTenantName()).setOrderNum(0)
                .setLeader(sysTenant.getTenantName()+"管理员").setPhone(sysTenant.getUserPhone()).setEmail(sysTenant.getUserEmail());
        deptMapper.insert(dept);
        return dept.getDeptId();
    }


    /**
     * 修改租户管理
     *
     * @param sysTenant 租户管理
     * @return 结果
     */
    @Override
    public int updateSysTenant(SysTenant sysTenant)
    {
        //判断最新的租户套餐是否改变 重新授权 租户二级管理员账号需重新分配三级账号权限
        SysTenant t_sysTenant = sysTenantMapper.selectById(sysTenant.getId());
        if(sysTenant.getTenantPackage() != null && !sysTenant.getTenantPackage().equals(t_sysTenant.getTenantPackage()))
        {
            List<SysRole> roleList = sysRoleMapper.queryAdminRole(sysTenant.getId());
            SysRole t_role = roleList.get(0);//正常逻辑下每个租户只有一个二级管理员账号
            if(t_role != null)
            {
                //删除原租户下所有的角色-菜单信息
                sysRoleMenuMapper.deleteRoleMenuByTenantId(sysTenant.getId());
                //新增默认角色-菜单信息
                TenantUtils.execute(sysTenant.getId(), () -> {
                    createRoleMenu(sysTenant,t_role);
                });
                //原登租户录账号退出重登 租户二级管理员账号需重新分配三级账号权限
                Collection<String> keys = redisService.keys(CacheConstants.LOGIN_TOKEN_KEY + "*");
                for (String key : keys)
                {
                    LoginUser onlineUser = redisService.getCacheObject(key);
                    if(onlineUser.getSysUser().getTenantId() != null && onlineUser.getSysUser().getTenantId().equals(sysTenant.getId()))
                    {
                        redisService.deleteObject(key);
                    }
                }
            }
        }
        return sysTenantMapper.updateById(sysTenant);
    }

    /**
     * 批量删除租户管理
     *
     * @param ids 需要删除的租户管理主键
     * @return 结果
     */
    @Override
    public int deleteSysTenantByIds(Long[] ids)
    {
        return sysTenantMapper.deleteSysTenantByIds(ids);
    }

    /**
     * 删除租户管理信息
     *
     * @param id 租户管理主键
     * @return 结果
     */
    @Override
    public int deleteSysTenantById(Long id)
    {
        return sysTenantMapper.deleteById(id);
    }
}
