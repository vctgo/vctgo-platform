/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云MySQL8.0
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : 127.0.0.1
 Source Schema         : vctgo_config

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 28/11/2022 22:26:52
*/
DROP DATABASE IF EXISTS `vctgo_config`;

CREATE DATABASE  `vctgo_config` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

USE vctgo_config;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for config_info
-- ----------------------------
DROP TABLE IF EXISTS `config_info`;
CREATE TABLE `config_info`  (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
                                `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
                                `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
                                `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
                                `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
                                `c_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `c_use` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `effect` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                `c_schema` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
                                `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE INDEX `uk_configinfo_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info
-- ----------------------------
INSERT INTO `config_info` VALUES (1, 'application-dev.yml', 'DEFAULT_GROUP', 'spring:\r\n  autoconfigure:\r\n    exclude: com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure\r\n  mvc:\r\n    pathmatch:\r\n      matching-strategy: ant_path_matcher\r\n# mail配置\r\n  mail:\r\n    # 配置 SMTP 服务器地址\r\n    host: smtpdm.aliyun.com\r\n    # 发送者邮箱\r\n    username: \r\n    # 配置密码，注意不是真正的密码，而是刚刚申请到的授权码\r\n    password: \r\n    # 端口号465或587\r\n    port: 465\r\n    # 默认的邮件编码为UTF-8\r\n    default-encoding: UTF-8\r\n    # 配置SSL 加密工厂\r\n    properties:\r\n      mail:\r\n        smtp:\r\n          ssl:\r\n            enable: true\r\n          socketFactoryClass: javax.net.ssl.SSLSocketFactory\r\n        #表示开启 DEBUG 模式，这样，邮件发送过程的日志会在控制台打印出来，方便排查错误\r\n        debug: true\r\n# feign 配置\r\nfeign:\r\n  sentinel:\r\n    enabled: true\r\n  okhttp:\r\n    enabled: true\r\n  httpclient:\r\n    enabled: false\r\n  client:\r\n    config:\r\n      default:\r\n        connectTimeout: 10000\r\n        readTimeout: 10000\r\n      vctgo-job:\r\n        connectTimeout: 100000\r\n        readTimeout: 100000\r\n  compression:\r\n    request:\r\n      enabled: true\r\n    response:\r\n      enabled: true\r\n\r\n# 暴露监控端点\r\nmanagement:\r\n  endpoints:\r\n    web:\r\n      exposure:\r\n        include: \'*\'\r\nlogging:\r\n  level:\r\n    org.springframework: info\r\n    com.vctgo: debug\r\n  #log日志文件配置\r\n  file_basePath: ./logs\r\n  file_prefix: ${spring.application.name}\r\nmybatis-plus:\r\n  mapper-locations: classpath*:mapper/**/*.xml\r\n  global-config:\r\n    banner: false\r\n    refresh-mapper: true\r\n    db-config:\r\n      id-type: auto\r\n      table-underline: true\r\n      logic-delete-value: 1\r\n      logic-not-delete-value: 0\r\n  configuration:\r\n    map-underscore-to-camel-case: true\r\n  type-handlers-package: com.vctgo.common.mybatisplus\r\nvctgo:\r\n  #多租户配置\r\n  tenant:\r\n    ignore-tables:\r\n      #系统表\r\n      - sys_config\r\n      - gen_table\r\n      - gen_table_column\r\n      - sys_dict_data\r\n      - sys_dict_type\r\n      - sys_menu\r\n      - sys_tenant\r\n      - sys_tenant_package\r\n      - sys_oper_log\r\n      - sys_logininfor\r\n      - branch_table\r\n      - global_table\r\n      - lock_table\r\n      - undo_log\r\n      - xxl_job_group\r\n      - xxl_job_info\r\n      - xxl_job_lock\r\n      - xxl_job_log\r\n      - xxl_job_log_report\r\n      - xxl_job_logglue\r\n      - xxl_job_registry\r\n      - xxl_job_user\r\n      #自定义表\r\n# 短信服务\r\naliyun:\r\n  endpoint: cn-shanghai\r\n  accessKeyId:  \r\n  accessKeySecret: \r\n  signName:  \r\n  templateCode: \r\n# 本地文件上传    \r\nfile:\r\n  domain: http://127.0.0.1:39300\r\n  path: /home/upload\r\n  prefix: /documents\r\n', '486f300db580135651a697a578516fd0', '2020-05-20 12:00:00', '2023-05-25 11:36:09', 'nacos', '0:0:0:0:0:0:0:1', '', '', '通用配置', 'null', 'null', 'yaml', 'null', '');
INSERT INTO `config_info` VALUES (2, 'vctgo-gateway-dev.yml', 'DEFAULT_GROUP', 'spring:\r\n  redis:\r\n    host: vctgo-redis\r\n    port: 6379\r\n#    password:\r\n    timeout: 1000 # 连接超时时间（毫秒）\r\n    jedis:\r\n      pool:\r\n        max-active: 10 # 连接池最大连接数（使用负值表示没有限制）\r\n        max-wait: -1ms # 连接池最大阻塞等待时间（使用负值表示没有限制）\r\n        max-idle: 8 # 连接池中的最大  空闲连接\r\n        min-idle: 0 # 连接池中的最小空闲连接\r\n  cloud:\r\n    gateway:\r\n      discovery:\r\n        locator:\r\n          lowerCaseServiceId: true\r\n          enabled: true\r\n      routes:\r\n        # 认证中心\r\n        - id: vctgo-auth\r\n          uri: lb://vctgo-auth\r\n          predicates:\r\n            - Path=/auth/**\r\n          filters:\r\n            # 验证码处理\r\n            - CacheRequestFilter\r\n            - ValidateCodeFilter\r\n            - StripPrefix=1\r\n        # 代码生成\r\n        - id: vctgo-gen\r\n          uri: lb://vctgo-gen\r\n          predicates:\r\n            - Path=/code/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 系统模块\r\n        - id: vctgo-system\r\n          uri: lb://vctgo-system\r\n          predicates:\r\n            - Path=/system/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 文件服务\r\n        - id: vctgo-file\r\n          uri: lb://vctgo-file\r\n          predicates:\r\n            - Path=/file/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 监控模块\r\n        - id: vctgo-monitor\r\n          uri: lb://vctgo-monitor\r\n          predicates:\r\n            - Path=/monitor/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 定时模块\r\n        - id: vctgo-job\r\n          uri: lb://vctgo-job\r\n          predicates:\r\n            - Path=/job/**\r\n          filters:\r\n            - StripPrefix=1\r\n        # 样例模块\r\n        - id: vctgo-demo\r\n          uri: lb://vctgo-demo\r\n          predicates:\r\n            - Path=/demo/**\r\n          filters:\r\n            - StripPrefix=1\r\n\r\n# 安全配置\r\nsecurity:\r\n  # 验证码\r\n  captcha:\r\n    enabled: true\r\n    type: math\r\n  # 防止XSS攻击\r\n  xss:\r\n    enabled: true\r\n    excludeUrls:\r\n      - /system/notice\r\n  # 不校验白名单\r\n  ignore:\r\n    whites:\r\n      - /auth/logout\r\n      - /auth/login\r\n      - /auth/register\r\n      - /*/v2/api-docs\r\n      - /csrf\r\n      - /job/api/callback\r\n      - /job/api/registry\r\n      - /job/api/registryRemove\r\n	  - /file/documents/**', '8f8647c54d819f1e011e06d4b71fd008', '2020-05-14 14:17:55', '2023-03-16 11:11:37', 'nacos', '192.168.71.1', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (3, 'vctgo-auth-dev.yml', 'DEFAULT_GROUP', 'spring: \n  redis:\n    host: vctgo-redis\n    port: 6379\n#    password:\n    timeout: 1000 # 连接超时时间（毫秒）\n    jedis:\n      pool:\n        max-active: 10 # 连接池最大连接数（使用负值表示没有限制）\n        max-wait: -1ms # 连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-idle: 8 # 连接池中的最大  空闲连接\n        min-idle: 0 # 连接池中的最小空闲连接\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n        #loggerLevel: full\n        requestInterceptors: com.vctgo.common.security.feign.FeignRequestInterceptor', '75ba050d90558dd0a07d9ba58b427998', '2022-11-28 22:04:14', '2022-11-28 22:19:59', 'nacos', '127.0.0.1', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (4, 'vctgo-monitor-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring: \n  redis:\n    host: vctgo-redis\n    port: 6379\n#    password:\n    timeout: 1000 # 连接超时时间（毫秒）\n    # jedis:\n    #   pool:\n    #     max-active: 10 # 连接池最大连接数（使用负值表示没有限制）\n    #     max-wait: -1ms # 连接池最大阻塞等待时间（使用负值表示没有限制）\n    #     max-idle: 8 # 连接池中的最大  空闲连接\n    #     min-idle: 0 # 连接池中的最小空闲连接\n    lettuce:\n      pool:\n        max-active: 20\n        max-wait: 500ms\n        max-idle: 10\n        min-idle: 2\n  datasource: \n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://vctgo-mysql:3306/vctgo_platform?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: \n# swagger配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By Vctgo\n  licenseUrl: https://vctgo.cn\n# seata配置\nseata:\n  # 默认关闭，如需启用spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  # Seata 应用编号，默认为 ${spring.application.name}\n  application-id: ${spring.application.name}\n  # Seata 事务组编号，用于 TC 集群名\n  tx-service-group: ${spring.application.name}-group\n  # 关闭自动代理\n  enable-auto-data-source-proxy: false\n  # 服务配置项\n  service:\n    # 虚拟组和分组的映射\n    vgroup-mapping:\n      vctgo-system-group: default\n  config:\n    type: nacos\n    nacos:\n      serverAddr: vctgo-nacos:8848\n      group: SEATA_GROUP\n      namespace:\n  registry:\n    type: nacos\n    nacos:\n      application: seata-server\n      server-addr: vctgo-nacos:8848\n      namespace:', '07b59d428a34e682083a7b693e1ae993', '2022-11-28 22:04:14', '2022-11-28 22:21:04', 'nacos', '127.0.0.1', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (5, 'vctgo-system-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring:\n  redis:\n    host: vctgo-redis\n    port: 6379\n#    password:\n    timeout: 1000 # 连接超时时间（毫秒）\n    jedis:\n      pool:\n        max-active: 10 # 连接池最大连接数（使用负值表示没有限制）\n        max-wait: -1ms # 连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-idle: 8 # 连接池中的最大  空闲连接\n        min-idle: 0 # 连接池中的最小空闲连接\n  datasource:\n    druid:\n      stat-view-servlet:\n        enabled: true\n        loginUsername: admin\n        loginPassword: 123456\n    dynamic:\n      druid:\n        initial-size: 5\n        min-idle: 50\n        maxActive: 100\n        maxWait: 60000\n        timeBetweenEvictionRunsMillis: 300000\n        minEvictableIdleTimeMillis: 300000\n        validationQuery: SELECT 1 FROM DUAL\n        testWhileIdle: true\n        testOnBorrow: false\n        testOnReturn: false\n        poolPreparedStatements: true\n        maxPoolPreparedStatementPerConnectionSize: 50\n        filters: stat,slf4j\n        connectionProperties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=500\n      datasource:\n          # 主库数据源\n          master:\n            driver-class-name: com.mysql.cj.jdbc.Driver\n            url: jdbc:mysql://vctgo-mysql:3306/vctgo_platform?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n            username: root\n            password: \nseata:\n  # 默认关闭，如需启用spring.datasource.dynami.seata需要同时开启\n  enabled: false\n  # Seata 应用编号，默认为 ${spring.application.name}\n  application-id: ${spring.application.name}\n  # Seata 事务组编号，用于 TC 集群名\n  tx-service-group: ${spring.application.name}-group\n  # 关闭自动代理\n  enable-auto-data-source-proxy: false\n  # 服务配置项\n  service:\n    # 虚拟组和分组的映射\n    vgroup-mapping:\n      vctgo-system-group: default\n  config:\n    type: nacos\n    nacos:\n      serverAddr: vctgo-nacos:8848\n      group: SEATA_GROUP\n      namespace:\n  registry:\n    type: nacos\n    nacos:\n      application: seata-server\n      server-addr: vctgo-nacos:8848\n      namespace:\n\n# mybatis配置\n# mybatis:\n#     搜索指定包别名\n#     typeAliasesPackage: com.vctgo.system\n#     配置mapper的扫描，找到所有的mapper.xml映射文件\n#     mapperLocations: classpath:mapper/**/*.xml\n\n# swagger配置\nswagger:\n  title: 系统模块接口文档\n  license: Powered By vctgo\n  licenseUrl: https://vctgo.vip\nfeign:\n  sentinel:\n    enabled: true\n  okhttp:\n    enabled: true\n  httpclient:\n    enabled: false\n  client:\n    config:\n      default:\n        connectTimeout: 10000\n        readTimeout: 10000\n        loggerLevel: full\n        requestInterceptors: com.vctgo.common.security.feign.FeignRequestInterceptor\n', 'b73286ff1a3bb877ad5a70de6457ec58', '2022-11-28 22:04:14', '2022-11-28 22:21:46', 'nacos', '127.0.0.1', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (6, 'vctgo-gen-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring: \n  redis:\n    host: vctgo-redis\n    port: 6379\n    #password: \n    timeout: 1000 # 连接超时时间（毫秒）\n    jedis:\n      pool:\n        max-active: 10 # 连接池最大连接数（使用负值表示没有限制）\n        max-wait: -1ms # 连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-idle: 8 # 连接池中的最大  空闲连接\n        min-idle: 0 # 连接池中的最小空闲连接\n  datasource: \n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://vctgo-mysql:3306/vctgo_platform?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: \n# swagger配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By vctgo\n  licenseUrl: https://vctgo.cn\n\n# 代码生成\ngen: \n  # 作者\n  author: vctgo\n  # 默认生成包路径 system 需改成自己的模块名称 如 system monitor tool\n  packageName: com.vctgo.system\n  # 自动去除表前缀，默认是false\n  autoRemovePre: false\n  # 表前缀（生成类名不会包含表前缀，多个用逗号分隔）\n  tablePrefix: sys_\n', '373d13719725d85df9184bd6c780092d', '2022-11-28 22:04:14', '2022-11-28 22:24:14', 'nacos', '127.0.0.1', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (7, 'vctgo-file-dev.yml', 'DEFAULT_GROUP', '#本地文件服务的配置迁移到公共配置文件里\r\n# FastDFS配置 -- http://vctgo-fastdfs 为hosts映射\r\nfdfs:\r\n  domain: http://vctgo-fastdfs\r\n  soTimeout: 3000\r\n  connectTimeout: 2000\r\n  trackerList: vctgo-fastdfs:22122\r\n\r\n# Minio配置\r\nminio:\r\n  url: \r\n  accessKey: \r\n  secretKey: \r\n  bucketName: ', 'e18c8d33c99a637b9ee234bd2a808b6e', '2022-11-28 22:04:14', '2022-11-28 22:23:07', 'nacos', '127.0.0.1', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (8, 'sentinel-vctgo-gateway', 'DEFAULT_GROUP', '[\n    {\n        \"resource\": \"vctgo-auth\",\n        \"count\": 500,\n        \"grade\": 1,\n        \"limitApp\": \"default\",\n        \"strategy\": 0,\n        \"controlBehavior\": 0\n    },\n	{\n        \"resource\": \"vctgo-system\",\n        \"count\": 1000,\n        \"grade\": 1,\n        \"limitApp\": \"default\",\n        \"strategy\": 0,\n        \"controlBehavior\": 0\n    },\n	{\n        \"resource\": \"vctgo-gen\",\n        \"count\": 200,\n        \"grade\": 1,\n        \"limitApp\": \"default\",\n        \"strategy\": 0,\n        \"controlBehavior\": 0\n    }\n]', 'c7ec4b61d6ccf685bd25f3abd577e24e', '2022-11-28 22:04:14', '2022-11-28 22:04:14', 'nacos', '127.0.0.1', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (9, 'vctgo-demo-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring: \n  redis:\n    host: vctgo-redis\n    port: 6379\n    #password: \n    timeout: 1000 # 连接超时时间（毫秒）\n    jedis:\n      pool:\n        max-active: 10 # 连接池最大连接数（使用负值表示没有限制）\n        max-wait: -1ms # 连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-idle: 8 # 连接池中的最大  空闲连接\n        min-idle: 0 # 连接池中的最小空闲连接\n  datasource: \n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://vctgo-mysql:3306/vctgo_platform?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: \n# swagger配置\nswagger:\n  title: 代码生成接口文档\n  license: Powered By vctgo\n  licenseUrl: https://vctgo.cn\n\nxxl:\n  job:\n    admin:\n      ### xxl-job admin address list, such as \"http://address\" or \"http://address01,http://address02\"\n      addresses: http://localhost/dev-api/job\n    ### xxl-job, access token\n    accessToken: default_token\n    executor: \n      ### xxl-job executor appname\n      appname: xxl-job-executor-sample\n      ### xxl-job executor registry-address: default use address to registry , otherwise use ip:port if address is null\n      address: \n      ### xxl-job executor server-info\n      ip: 127.0.0.1\n      port: 9999\n      ### xxl-job executor log-path\n      logpath: ./logs/xxl-job\n      ### xxl-job executor log-retention-days\n      logretentiondays: 30', '7fa7a4f6f6a52fdf42100837260bb874', '2022-10-26 20:40:11', '2023-04-13 23:57:18', 'nacos', '0:0:0:0:0:0:0:1', '', '', '', '', '', 'yaml', '', '');
INSERT INTO `config_info` VALUES (10, 'vctgo-job-dev.yml', 'DEFAULT_GROUP', '# spring配置\nspring: \n  redis:\n    host: 127.0.0.1\n    port: 6379\n    #password: \n    timeout: 1000 # 连接超时时间（毫秒）\n    jedis:\n      pool:\n        max-active: 10 # 连接池最大连接数（使用负值表示没有限制）\n        max-wait: -1ms # 连接池最大阻塞等待时间（使用负值表示没有限制）\n        max-idle: 8 # 连接池中的最大  空闲连接\n        min-idle: 0 # 连接池中的最小空闲连接\n  datasource: \n    driver-class-name: com.mysql.cj.jdbc.Driver\n    url: jdbc:mysql://vctgo-mysql:3306/vctgo_platform?useUnicode=true&characterEncoding=utf8&zeroDateTimeBehavior=convertToNull&useSSL=true&serverTimezone=GMT%2B8\n    username: root\n    password: password\n  mail:\n    host: www.163.com\n    port: 25\n    username: test@163.com\n    from: test@163.com\n    password: \n    properties: \n      mail: \n        smtp: \n          auth: false\n          starttls: \n            enable: false\n            required: false\n          socketFactory: \n            class: javax.net.ssl.SSLSocketFactory\n          \n# swagger配置\nswagger:\n  title: 定时任务接口文档\n  license: Powered By vctgo\n  licenseUrl: https://vctgo.cn\n\nxxl:\n  job:\n    accessToken: default_token\n    i18n: zh_CN\n    logretentiondays: 30\n    triggerpool: \n      fast: \n        max: 200\n      slow: \n        max: 100\n\ncustom:\n  log:\n    list:\n      - scheduleJobQuery-error\n      - findFailJobLogIds-error\n      - findByAddressType-error\n\n\n', '2caec7ca88cc94a5264ea2062a45b672', '2022-10-27 21:22:25', '2023-04-27 23:52:14', 'nacos', '192.168.2.12', '', '', '', '', '', 'yaml', '', '10');
-- ----------------------------
-- Table structure for config_info_aggr
-- ----------------------------
DROP TABLE IF EXISTS `config_info_aggr`;
CREATE TABLE `config_info_aggr`  (
                                     `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                     `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                     `group_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
                                     `datum_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'datum_id',
                                     `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '内容',
                                     `gmt_modified` datetime NOT NULL COMMENT '修改时间',
                                     `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                     `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `uk_configinfoaggr_datagrouptenantdatum`(`data_id`, `group_id`, `tenant_id`, `datum_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '增加租户字段' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_aggr
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_beta
-- ----------------------------
DROP TABLE IF EXISTS `config_info_beta`;
CREATE TABLE `config_info_beta`  (
                                     `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                     `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                     `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
                                     `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
                                     `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
                                     `beta_ips` varchar(1024) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'betaIps',
                                     `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
                                     `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                     `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                     `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
                                     `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
                                     `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
                                     `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
                                     PRIMARY KEY (`id`) USING BTREE,
                                     UNIQUE INDEX `uk_configinfobeta_datagrouptenant`(`data_id`, `group_id`, `tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_beta' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_beta
-- ----------------------------

-- ----------------------------
-- Table structure for config_info_tag
-- ----------------------------
DROP TABLE IF EXISTS `config_info_tag`;
CREATE TABLE `config_info_tag`  (
                                    `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                    `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                    `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
                                    `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
                                    `tag_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_id',
                                    `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
                                    `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'content',
                                    `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'md5',
                                    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                    `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL COMMENT 'source user',
                                    `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'source ip',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `uk_configinfotag_datagrouptenanttag`(`data_id`, `group_id`, `tenant_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_info_tag' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_info_tag
-- ----------------------------

-- ----------------------------
-- Table structure for config_tags_relation
-- ----------------------------
DROP TABLE IF EXISTS `config_tags_relation`;
CREATE TABLE `config_tags_relation`  (
                                         `id` bigint NOT NULL COMMENT 'id',
                                         `tag_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'tag_name',
                                         `tag_type` varchar(64) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tag_type',
                                         `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'data_id',
                                         `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'group_id',
                                         `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
                                         `nid` bigint NOT NULL AUTO_INCREMENT,
                                         PRIMARY KEY (`nid`) USING BTREE,
                                         UNIQUE INDEX `uk_configtagrelation_configidtag`(`id`, `tag_name`, `tag_type`) USING BTREE,
                                         INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'config_tag_relation' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of config_tags_relation
-- ----------------------------

-- ----------------------------
-- Table structure for group_capacity
-- ----------------------------
DROP TABLE IF EXISTS `group_capacity`;
CREATE TABLE `group_capacity`  (
                                   `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                   `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Group ID，空字符表示整个集群',
                                   `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
                                   `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
                                   `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
                                   `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数，，0表示使用默认值',
                                   `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
                                   `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
                                   `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                   PRIMARY KEY (`id`) USING BTREE,
                                   UNIQUE INDEX `uk_group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '集群、各Group容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of group_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for his_config_info
-- ----------------------------
DROP TABLE IF EXISTS `his_config_info`;
CREATE TABLE `his_config_info`  (
                                    `id` bigint UNSIGNED NOT NULL,
                                    `nid` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
                                    `data_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
                                    `group_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
                                    `app_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'app_name',
                                    `content` longtext CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
                                    `md5` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                    `src_user` text CHARACTER SET utf8 COLLATE utf8_bin NULL,
                                    `src_ip` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                    `op_type` char(10) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL,
                                    `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT '租户字段',
                                    `encrypted_data_key` text CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT '秘钥',
                                    PRIMARY KEY (`nid`) USING BTREE,
                                    INDEX `idx_gmt_create`(`gmt_create`) USING BTREE,
                                    INDEX `idx_gmt_modified`(`gmt_modified`) USING BTREE,
                                    INDEX `idx_did`(`data_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '多租户改造' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of his_config_info
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions`  (
                                `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                `resource` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                `action` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                                UNIQUE INDEX `uk_role_permission`(`role`, `resource`, `action`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permissions
-- ----------------------------

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
                          `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                          `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                          UNIQUE INDEX `idx_user_role`(`username`, `role`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('nacos', 'ROLE_ADMIN');

-- ----------------------------
-- Table structure for tenant_capacity
-- ----------------------------
DROP TABLE IF EXISTS `tenant_capacity`;
CREATE TABLE `tenant_capacity`  (
                                    `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键ID',
                                    `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'Tenant ID',
                                    `quota` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '配额，0表示使用默认值',
                                    `usage` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用量',
                                    `max_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个配置大小上限，单位为字节，0表示使用默认值',
                                    `max_aggr_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '聚合子配置最大个数',
                                    `max_aggr_size` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '单个聚合数据的子配置大小上限，单位为字节，0表示使用默认值',
                                    `max_history_count` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大变更历史数量',
                                    `gmt_create` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                    `gmt_modified` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '修改时间',
                                    PRIMARY KEY (`id`) USING BTREE,
                                    UNIQUE INDEX `uk_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = '租户容量信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_capacity
-- ----------------------------

-- ----------------------------
-- Table structure for tenant_info
-- ----------------------------
DROP TABLE IF EXISTS `tenant_info`;
CREATE TABLE `tenant_info`  (
                                `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'id',
                                `kp` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'kp',
                                `tenant_id` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_id',
                                `tenant_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT '' COMMENT 'tenant_name',
                                `tenant_desc` varchar(256) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'tenant_desc',
                                `create_source` varchar(32) CHARACTER SET utf8 COLLATE utf8_bin NULL DEFAULT NULL COMMENT 'create_source',
                                `gmt_create` bigint NOT NULL COMMENT '创建时间',
                                `gmt_modified` bigint NOT NULL COMMENT '修改时间',
                                PRIMARY KEY (`id`) USING BTREE,
                                UNIQUE INDEX `uk_tenant_info_kptenantid`(`kp`, `tenant_id`) USING BTREE,
                                INDEX `idx_tenant_id`(`tenant_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_bin COMMENT = 'tenant_info' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tenant_info
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
                          `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                          `password` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
                          `enabled` tinyint(1) NOT NULL,
                          PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('nacos', '$2a$10$EuWPZHzz32dJN7jexM34MOeYirDdFAZm2kuWj7VEOJhhZkDrxfvUu', 1);

SET FOREIGN_KEY_CHECKS = 1;
