
<h1 align="center" style="margin: 30px 0 30px; font-weight: bold;">vctgo v1.0.0</h1>
<h4 align="center">基于 Vue/Element UI 和 Spring Boot/Spring Cloud & Alibaba 前后端分离的分布式微服务架构</h4>
 
## 演示地址
http://platform.vctgo.cn

账号密码 admin/admin123
## 文档地址
https://doc.vctgo.cn
## 个人blog(偷懒ing....)
https://www.vctgo.cn

## 主要添加模块
### 1.添加了租户功能,包含自定义租户套餐
### 2.替代mybatis为mybatis-plus模块
### 3.添加了邮件通知功能
### 4.添加了自定义监控模块,暂时代替monitor模块
### 5.去除定时任务模块,选择了xxl-job,目前没有加入代码库
### 6.后续优化数据权限模块.....

![Vctgo-Platform1](https://www.vctgo.cn:39000/vctgo/vctgo-1.png)
![Vctgo-Platform2](https://www.vctgo.cn:39000/vctgo/vctgo-2.png)
![Vctgo-Platform3](https://www.vctgo.cn:39000/vctgo/vctgo-3.png)
![Vctgo-Platform4](https://www.vctgo.cn:39000/vctgo/vctgo-4.png)

## 启动说明
### 1.nacos自行运行 如果是 M1的芯片 会出现内核报错 采用下方nacos镜像即可
docker pull zhusaidong/nacos-server-m1:2.0.3

## 系统模块

~~~
com.vctgo     
├── vctgo-ui              // 前端框架 [80]
├── vctgo-gateway         // 网关模块 [38080]
├── vctgo-auth            // 认证中心 [39200]
├── vctgo-api             // 接口模块
│       └── vctgo-api-system                          // 系统接口
├── vctgo-common          // 通用模块
│       └── vctgo-common-core                         // 核心模块
│       └── vctgo-common-datascope                    // 权限范围
│       └── vctgo-common-datasource                   // 多数据源
│       └── vctgo-common-log                          // 日志记录
│       └── vctgo-common-redis                        // 缓存服务
│       └── vctgo-common-security                     // 安全模块
│       └── vctgo-common-swagger                      // 系统接口
│       └── vctgo-common-message                      // 消息通知
│       └── vctgo-common-mybatisplus                  // mybatis增强组件
├── vctgo-modules         // 业务模块
│       └── vctgo-system                              // 系统模块 [39201]
│       └── vctgo-gen                                 // 代码生成 [39202]
│       └── vctgo-file                                // 文件服务 [39300]
├── vctgo-visual          // 图形化管理模块
│       └── vctgo-visual-monitor                      // 监控中心 [39100]
├──pom.xml                // 公共依赖
~~~

 
## 内置功能

1.  用户管理：用户是系统操作者，该功能主要完成系统用户配置。
2.  部门管理：配置系统组织机构（公司、部门、小组），树结构展现支持数据权限。
3.  岗位管理：配置系统用户所属担任职务。
4.  菜单管理：配置系统菜单，操作权限，按钮权限标识等。
5.  角色管理：角色菜单权限分配、设置角色按机构进行数据范围权限划分。
6.  字典管理：对系统中经常使用的一些较为固定的数据进行维护。
7.  参数管理：对系统动态配置常用参数。
8.  通知公告：系统通知公告信息发布维护。
9.  操作日志：系统正常操作日志记录和查询；系统异常信息日志记录和查询。
10. 登录日志：系统登录日志记录查询包含登录异常。
11. 在线用户：当前系统中活跃用户状态监控。
12. 定时任务：在线（添加、修改、删除)任务调度包含执行结果日志。
13. 代码生成：前后端代码的生成（java、html、xml、sql）支持CRUD下载 。
14. 系统接口：根据业务代码自动生成相关的api接口文档。
15. 服务监控：监视当前系统CPU、内存、磁盘、堆栈等相关信息。
16. 在线构建器：拖动表单元素生成相应的HTML代码。
17. 连接池监视：监视当前系统数据库连接池状态，可进行分析SQL找出系统性能瓶颈。


## 有问题请issues提问 或者邮件咨询 邮件详情见blog
