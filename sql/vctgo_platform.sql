/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云rds
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : localhost:3306
 Source Schema         : vctgo_platform

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 03/09/2022 22:53:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table` (
  `table_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表';

-- ----------------------------
-- Records of gen_table
-- ----------------------------
BEGIN;
INSERT INTO `gen_table` VALUES (1, 'sys_role', '角色信息表', NULL, NULL, 'SysRole', 'crud', 'com.shenghong.system', 'system', 'role', '角色信息', 'shenghong', '0', '/', NULL, 'admin', '2022-03-07 19:28:14', '', NULL, NULL);
INSERT INTO `gen_table` VALUES (2, 'sys_tenant', '租户表', '', '', 'SysTenant', 'crud', 'com.shenghong.system', 'system', 'tenant', '租户管理', 'shenghong', '0', '/', '{\"parentMenuId\":\"1\"}', 'admin', '2022-03-15 15:26:05', '', '2022-04-11 12:16:49', NULL);
INSERT INTO `gen_table` VALUES (4, 'sys_tenant_package', '租户套餐表', '', '', 'SysTenantPackage', 'crud', 'com.shenghong.system', 'system', 'tenantpackage', '租户套餐', 'shenghong', '0', '/', '{\"parentMenuId\":\"1\"}', 'admin', '2022-03-19 20:59:00', '', '2022-03-25 16:58:34', NULL);
INSERT INTO `gen_table` VALUES (5, 'sys_demo', '测试表', NULL, NULL, 'SysDemo', 'crud', 'com.shenghong.system', 'system', 'demo', '测试', 'shenghong', '0', '/', '{}', 'admin', '2022-04-09 16:18:07', '', '2022-04-10 00:40:02', NULL);
INSERT INTO `gen_table` VALUES (6, 'monitor_sys', '系统监控表', NULL, NULL, 'MonitorSys', 'crud', 'com.shenghong.modules.monitor', 'monitor', 'monitor', '服务器管理', 'shenghong', '0', '/', '{\"parentMenuId\":\"2\"}', 'admin', '2022-04-26 15:02:19', '', '2022-04-26 15:07:06', NULL);
INSERT INTO `gen_table` VALUES (7, 'monitor_sys_info', '系统监控信息记录表', NULL, NULL, 'MonitorSysInfo', 'crud', 'com.shenghong.modules.monitor', 'monitor', 'monitor', '系统监控信息记录', 'shenghong', '0', '/', '{\"parentMenuId\":\"2\"}', 'admin', '2022-04-26 16:26:36', '', '2022-04-26 16:27:42', NULL);
INSERT INTO `gen_table` VALUES (8, 'monitor_cache', '缓存列表', NULL, NULL, 'MonitorCache', 'crud', 'com.shenghong.modules.monitor', 'monitor', 'monitor', '缓存管理', 'shenghong', '0', '/', '{\"parentMenuId\":2}', 'admin', '2022-04-27 09:01:48', '', '2022-04-27 09:10:51', NULL);
COMMIT;

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column` (
  `column_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` varchar(64) DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) DEFAULT '' COMMENT '字典类型',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COMMENT='代码生成业务表字段';

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
BEGIN;
INSERT INTO `gen_table_column` VALUES (1, '1', 'role_id', '角色ID', 'bigint', 'Long', 'roleId', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (2, '1', 'role_name', '角色名称', 'varchar(30)', 'String', 'roleName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (3, '1', 'role_key', '角色权限字符串', 'varchar(100)', 'String', 'roleKey', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (4, '1', 'role_sort', '显示顺序', 'int', 'Long', 'roleSort', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (5, '1', 'data_scope', '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）', 'char(1)', 'String', 'dataScope', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (6, '1', 'menu_check_strictly', '菜单树选择项是否关联显示', 'tinyint(1)', 'Integer', 'menuCheckStrictly', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (7, '1', 'dept_check_strictly', '部门树选择项是否关联显示', 'tinyint(1)', 'Integer', 'deptCheckStrictly', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (8, '1', 'status', '角色状态（0正常 1停用）', 'char(1)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', '', 8, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (9, '1', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (10, '1', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 10, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (11, '1', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 11, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (12, '1', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (13, '1', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (14, '1', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 14, 'admin', '2022-03-07 19:28:14', '', NULL);
INSERT INTO `gen_table_column` VALUES (15, '2', 'id', '租户编码', 'bigint', 'Long', 'id', '1', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-03-15 15:26:05', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (17, '2', 'tenant_name', '租户名称', 'varchar(50)', 'String', 'tenantName', '0', '0', '1', '1', NULL, '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-03-15 15:26:05', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (24, '2', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', NULL, 11, 'admin', '2022-03-15 15:26:05', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (26, '2', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', NULL, 13, 'admin', '2022-03-15 15:26:05', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (27, '2', 'status', '租户状态（0正常 1停用）', 'int', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'sys_tenant_status', 8, 'admin', '2022-03-15 15:26:05', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (29, '2', 'user_name', '管理员账号', 'varchar(20)', 'String', 'userName', '0', '0', '1', '1', NULL, '1', '1', 'LIKE', 'input', '', 3, '', '2022-03-15 17:50:56', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (30, '2', 'user_phone', '手机号码', 'varchar(20)', 'String', 'userPhone', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 4, '', '2022-03-15 17:50:56', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (31, '2', 'user_email', '邮箱地址', 'varchar(20)', 'String', 'userEmail', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, '', '2022-03-15 17:50:56', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (32, '2', 'tenant_package', '租户套餐', 'bigint', 'Long', 'tenantPackage', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 6, '', '2022-03-15 17:50:56', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (33, '2', 'tenant_time', '租赁结束时间', 'datetime', 'Date', 'tenantTime', '0', '0', '1', '1', '1', '1', '1', 'BETWEEN', 'datetime', '', 7, '', '2022-03-15 17:50:56', NULL, '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (44, '4', 'id', '套餐编号', 'bigint(20)', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-03-19 20:59:01', NULL, '2022-04-11 11:31:17');
INSERT INTO `gen_table_column` VALUES (45, '4', 'name', '套餐名', 'varchar(30)', 'String', 'name', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-03-19 20:59:01', NULL, '2022-04-11 11:31:17');
INSERT INTO `gen_table_column` VALUES (47, '4', 'menu_ids', '关联的菜单编号', 'varchar(2048)', 'String', 'menuIds', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2022-03-19 20:59:01', NULL, '2022-04-11 11:31:17');
INSERT INTO `gen_table_column` VALUES (49, '4', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', NULL, 7, 'admin', '2022-03-19 20:59:01', NULL, '2022-04-11 11:31:17');
INSERT INTO `gen_table_column` VALUES (51, '4', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', NULL, 9, 'admin', '2022-03-19 20:59:01', NULL, '2022-04-11 11:31:17');
INSERT INTO `gen_table_column` VALUES (53, '4', 'status', '角色状态（0正常 1停用）', 'tinyint(4)', 'String', 'status', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'radio', 'sys_tenant_status', 4, 'admin', '2022-03-19 20:59:01', NULL, '2022-04-11 11:31:17');
INSERT INTO `gen_table_column` VALUES (54, '5', 'demo_id', '测试ID', 'bigint(20)', 'Long', 'demoId', '1', '1', NULL, NULL, NULL, '1', '1', 'EQ', 'input', '', 1, 'admin', '2022-04-09 16:18:07', '', '2022-04-10 00:40:03');
INSERT INTO `gen_table_column` VALUES (55, '5', 'demo_name', '测试账号', 'varchar(30)', 'String', 'demoName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-04-09 16:18:07', '', '2022-04-10 00:40:03');
INSERT INTO `gen_table_column` VALUES (56, '5', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 3, 'admin', '2022-04-09 16:18:07', '', '2022-04-10 00:40:03');
INSERT INTO `gen_table_column` VALUES (57, '5', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 4, 'admin', '2022-04-09 16:18:07', '', '2022-04-10 00:40:03');
INSERT INTO `gen_table_column` VALUES (58, '5', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 5, 'admin', '2022-04-09 16:18:07', '', '2022-04-10 00:40:03');
INSERT INTO `gen_table_column` VALUES (59, '5', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 6, 'admin', '2022-04-09 16:18:08', '', '2022-04-10 00:40:03');
INSERT INTO `gen_table_column` VALUES (60, '5', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 7, 'admin', '2022-04-09 16:18:08', '', '2022-04-10 00:40:03');
INSERT INTO `gen_table_column` VALUES (61, '5', 'tenant_id', '租户id', 'bigint(20)', 'Long', 'tenantId', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, 'admin', '2022-04-09 16:18:08', '', '2022-04-10 00:40:03');
INSERT INTO `gen_table_column` VALUES (62, '2', 'del_flag', '删除标志（0代表存在 1代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, '', '2022-04-11 11:31:15', '', '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (63, '2', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 10, '', '2022-04-11 11:31:15', '', '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (64, '2', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 12, '', '2022-04-11 11:31:15', '', '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (65, '2', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'textarea', '', 14, '', '2022-04-11 11:31:15', '', '2022-04-11 12:16:49');
INSERT INTO `gen_table_column` VALUES (66, '4', 'del_flag', '删除标志（0代表存在 2代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 5, '', '2022-04-11 11:31:17', '', NULL);
INSERT INTO `gen_table_column` VALUES (67, '4', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 6, '', '2022-04-11 11:31:17', '', NULL);
INSERT INTO `gen_table_column` VALUES (68, '4', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 8, '', '2022-04-11 11:31:17', '', NULL);
INSERT INTO `gen_table_column` VALUES (69, '4', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 10, '', '2022-04-11 11:31:17', '', NULL);
INSERT INTO `gen_table_column` VALUES (70, '6', 'id', '主键', 'bigint(20)', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-04-26 15:02:19', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (71, '6', 'sys_name', '系统名称', 'varchar(255)', 'String', 'sysName', '0', '0', NULL, '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-04-26 15:02:19', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (72, '6', 'ip', 'IP地址', 'varchar(255)', 'String', 'ip', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (73, '6', 'user_name', '用户名', 'varchar(255)', 'String', 'userName', '0', '0', '1', '1', '1', NULL, NULL, 'LIKE', 'input', '', 4, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (74, '6', 'user_password', '用户密码', 'varchar(255)', 'String', 'userPassword', '0', '0', '1', '1', '1', NULL, NULL, 'EQ', 'input', '', 5, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (75, '6', 'ip_port', '系统端口', 'int(255)', 'Long', 'ipPort', '0', '0', '1', '1', '1', NULL, NULL, 'EQ', 'input', '', 6, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (76, '6', 'rsa_addr', '公钥地址', 'varchar(500)', 'String', 'rsaAddr', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'textarea', '', 7, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (77, '6', 'is_online', '是否在线 0在线 1离线', 'int(2)', 'Integer', 'isOnline', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'select', 'sys_notice_type', 8, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (78, '6', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (79, '6', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (80, '6', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 11, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (81, '6', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 12, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (82, '6', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'textarea', '', 13, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (83, '6', 'tenant_id', '租户id', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2022-04-26 15:02:20', '', '2022-04-26 15:07:06');
INSERT INTO `gen_table_column` VALUES (84, '7', 'id', '主键', 'bigint(20)', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2022-04-26 16:26:36', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (85, '7', 'ip', 'IP地址', 'varchar(255)', 'String', 'ip', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 'admin', '2022-04-26 16:26:36', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (86, '7', 'cpu_info', 'cpu信息', 'varchar(255)', 'String', 'cpuInfo', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-04-26 16:26:36', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (87, '7', 'mem_info', '内存信息', 'varchar(255)', 'String', 'memInfo', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2022-04-26 16:26:36', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (88, '7', 'disk_info', '硬盘信息', 'varchar(255)', 'String', 'diskInfo', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 5, 'admin', '2022-04-26 16:26:36', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (89, '7', 'cpu_core_info', 'cpu核心信息', 'varchar(255)', 'String', 'cpuCoreInfo', '0', '0', NULL, '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2022-04-26 16:26:36', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (90, '7', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', '', 7, 'admin', '2022-04-26 16:26:36', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (91, '7', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 8, 'admin', '2022-04-26 16:26:37', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (92, '7', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'input', '', 9, 'admin', '2022-04-26 16:26:37', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (93, '7', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', '1', NULL, NULL, 'EQ', 'datetime', '', 10, 'admin', '2022-04-26 16:26:37', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (94, '7', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 11, 'admin', '2022-04-26 16:26:37', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (95, '7', 'tenant_id', '租户id', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 12, 'admin', '2022-04-26 16:26:37', '', '2022-04-26 16:27:42');
INSERT INTO `gen_table_column` VALUES (96, '8', 'id', '主键', 'bigint(20)', 'Long', 'id', '1', '1', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 1, 'admin', '2022-04-27 09:01:48', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (97, '8', 'cache_name', '缓存应用名称', 'varchar(255)', 'String', 'cacheName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2022-04-27 09:01:48', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (98, '8', 'ip', 'IP地址', 'varchar(255)', 'String', 'ip', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 3, 'admin', '2022-04-27 09:01:48', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (99, '8', 'user_name', '用户名', 'varchar(255)', 'String', 'userName', '0', '0', '1', '1', '1', '1', NULL, 'LIKE', 'input', '', 4, 'admin', '2022-04-27 09:01:48', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (100, '8', 'user_password', '用户密码', 'varchar(255)', 'String', 'userPassword', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 5, 'admin', '2022-04-27 09:01:48', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (101, '8', 'ip_port', '系统端口', 'int(255)', 'Long', 'ipPort', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'input', '', 6, 'admin', '2022-04-27 09:01:48', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (102, '8', 'rsa_addr', '公钥地址', 'varchar(500)', 'String', 'rsaAddr', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'textarea', '', 7, 'admin', '2022-04-27 09:01:49', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (103, '8', 'is_online', '是否在线', 'int(2)', 'Integer', 'isOnline', '0', '0', NULL, '1', NULL, '1', NULL, 'EQ', 'select', 'sys_notice_status', 8, 'admin', '2022-04-27 09:01:49', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (104, '8', 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 9, 'admin', '2022-04-27 09:01:49', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (105, '8', 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', NULL, 10, 'admin', '2022-04-27 09:01:49', NULL, '2022-04-27 09:10:51');
INSERT INTO `gen_table_column` VALUES (106, '8', 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'input', NULL, 11, 'admin', '2022-04-27 09:01:49', NULL, '2022-04-27 09:10:52');
INSERT INTO `gen_table_column` VALUES (107, '8', 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, '1', NULL, NULL, NULL, 'EQ', 'datetime', NULL, 12, 'admin', '2022-04-27 09:01:49', NULL, '2022-04-27 09:10:52');
INSERT INTO `gen_table_column` VALUES (108, '8', 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', NULL, '1', '1', '1', NULL, 'EQ', 'textarea', '', 13, 'admin', '2022-04-27 09:01:49', NULL, '2022-04-27 09:10:52');
INSERT INTO `gen_table_column` VALUES (109, '8', 'tenant_id', '租户id', 'bigint(20)', 'Long', 'tenantId', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2022-04-27 09:01:49', NULL, '2022-04-27 09:10:52');
COMMIT;

-- ----------------------------
-- Table structure for monitor_cache
-- ----------------------------
DROP TABLE IF EXISTS `monitor_cache`;
CREATE TABLE `monitor_cache` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cache_name` varchar(255) DEFAULT NULL COMMENT '缓存应用名称',
  `ip` varchar(255) NOT NULL COMMENT 'IP地址',
  `database_num` int(255) DEFAULT '0' COMMENT '用户名',
  `user_password` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `ip_port` int(255) NOT NULL DEFAULT '6379' COMMENT '系统端口',
  `rsa_addr` varchar(500) DEFAULT NULL COMMENT '公钥地址',
  `user_phone` varchar(255) DEFAULT NULL COMMENT '告警手机',
  `user_email` varchar(255) DEFAULT NULL COMMENT '告警邮件',
  `message_type` int(2) DEFAULT NULL COMMENT '告警类型 0 手机 1邮件',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='缓存列表';

-- ----------------------------
-- Records of monitor_cache
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for monitor_sys
-- ----------------------------
DROP TABLE IF EXISTS `monitor_sys`;
CREATE TABLE `monitor_sys` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `sys_name` varchar(255) DEFAULT NULL COMMENT '系统名称',
  `ip` varchar(255) NOT NULL COMMENT 'IP地址',
  `user_name` varchar(255) NOT NULL COMMENT '用户名',
  `user_password` varchar(255) NOT NULL COMMENT '用户密码',
  `ip_port` int(255) NOT NULL COMMENT '系统端口',
  `rsa_addr` varchar(500) DEFAULT NULL COMMENT '公钥地址',
  `is_online` int(2) NOT NULL DEFAULT '0' COMMENT '是否在线 0在线 1离线',
  `warn_cpu` varchar(255) DEFAULT NULL COMMENT 'cpu使用报警',
  `warn_mem` varchar(255) DEFAULT NULL COMMENT '内存使用报警',
  `warn_disk` varchar(255) DEFAULT NULL COMMENT '硬盘报警',
  `user_phone` varchar(255) DEFAULT NULL COMMENT '告警手机',
  `user_email` varchar(255) DEFAULT NULL COMMENT '告警邮件',
  `message_type` int(2) DEFAULT NULL COMMENT '告警类型 0 手机 1邮件',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='系统监控表';

-- ----------------------------
-- Records of monitor_sys
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for monitor_sys_info
-- ----------------------------
DROP TABLE IF EXISTS `monitor_sys_info`;
CREATE TABLE `monitor_sys_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `ip_id` bigint(255) NOT NULL COMMENT 'IP_id',
  `cpu_info` varchar(255) DEFAULT NULL COMMENT 'cpu信息',
  `mem_info` varchar(255) DEFAULT NULL COMMENT '内存信息',
  `disk_info` varchar(255) DEFAULT NULL COMMENT '硬盘信息',
  `disk_percent` varchar(255) DEFAULT NULL COMMENT '硬盘占比',
  `cpu_core_info` varchar(255) DEFAULT NULL COMMENT 'cpu核心信息',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_monitor_sysinfo_ipid` (`ip_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='系统监控信息记录表';

-- ----------------------------
-- Records of monitor_sys_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config` (
  `config_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='参数配置表';

-- ----------------------------
-- Records of sys_config
-- ----------------------------
BEGIN;
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-orange', 'Y', 'admin', '2022-03-07 15:41:18', '', NULL, '橘色 skin-orange、蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-03-07 15:41:18', '', NULL, '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-light', 'Y', 'admin', '2022-03-07 15:41:18', '', NULL, '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (4, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-03-07 15:41:18', '', NULL, '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (5, '通知管理-通知方式', 'sys.message.type', 'false', 'Y', 'admin', '2022-09-14 20:59:08', 'admin', '2022-09-14 20:59:24', '是否开启短信通知(开启后会替代所有通知模块)');
COMMIT;

-- ----------------------------
-- Table structure for sys_demo
-- ----------------------------
DROP TABLE IF EXISTS `sys_demo`;
CREATE TABLE `sys_demo` (
  `demo_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '测试ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  `demo_name` varchar(30) NOT NULL COMMENT '测试账号',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  PRIMARY KEY (`demo_id`) USING BTREE,
  KEY `idx_demo_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8mb4 COMMENT='测试表';


-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=110 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
BEGIN;
INSERT INTO `sys_dept` VALUES (100, 0, '0', '菜盟科技', 0, '数智化部管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '0', 'admin', '2022-03-07 15:41:18', 'admin', '2022-06-11 00:49:10', 9999);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '菜盟集团', 1, '数智化部管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '0', 'admin', '2022-03-07 15:41:18', 'admin', '2022-06-11 00:49:02', 9999);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '斯尔邦石化', 2, '斯尔邦石化管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '1', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-07 18:32:14', 9999);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '信息部', 1, '数智化部管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '0', 'admin', '2022-03-07 15:41:18', 'admin', '2022-06-11 00:48:50', 9999);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '人力资源部', 2, '人力资源部管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '0', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-07 18:22:53', 9999);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '商务部', 3, '商务部管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '0', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-07 18:24:01', 9999);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部', 4, '财务部管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '0', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-07 18:24:29', 9999);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '总裁办', 5, '总裁办管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '0', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-07 18:31:05', 9999);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '数智化部', 1, '数智化部管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '1', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-07 18:33:04', 9999);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部', 2, '财务部管理员', '13851202705', 'donghaoran@shenghongpec.com', '0', '1', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-07 18:33:13', 9999);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data` (
  `dict_code` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int(11) DEFAULT '0' COMMENT '字典排序',
  `dict_label` varchar(100) DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COMMENT='字典数据表';

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (8, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (9, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (10, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (11, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (12, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (13, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (14, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (15, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (16, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (17, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (18, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (19, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (20, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (21, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (22, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (23, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (24, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (100, 0, '开启', '0', 'sys_tenant_status', 'primary', 'primary', 'N', '0', 'admin', '2022-03-15 16:30:32', 'admin', '2022-03-15 18:42:34', '租户开启状态');
INSERT INTO `sys_dict_data` VALUES (101, 1, '关闭', '1', 'sys_tenant_status', NULL, 'danger', 'N', '0', 'admin', '2022-03-15 16:30:44', 'admin', '2022-03-15 18:42:59', '租户关闭状态');
INSERT INTO `sys_dict_data` VALUES (102, 2, '短信通知', '1', 'sys_message_type', NULL, 'info', 'N', '0', 'admin', '2022-04-28 10:59:57', 'admin', '2022-04-28 11:00:41', '');
INSERT INTO `sys_dict_data` VALUES (103, 1, '邮件通知', '0', 'sys_message_type', NULL, 'info', 'N', '0', 'admin', '2022-04-28 11:01:00', '', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type` (
  `dict_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) DEFAULT '' COMMENT '字典类型',
  `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COMMENT='字典类型表';

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
BEGIN;
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (5, '系统是否', 'sys_yes_no', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (6, '通知类型', 'sys_notice_type', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (7, '通知状态', 'sys_notice_status', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (8, '操作类型', 'sys_oper_type', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (9, '系统状态', 'sys_common_status', '0', 'admin', '2022-03-07 15:41:18', '', NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (100, '租户状态', 'sys_tenant_status', '0', 'admin', '2022-03-15 16:17:01', '', NULL, '租户状态列表');
INSERT INTO `sys_dict_type` VALUES (101, '报警通知', 'sys_message_type', '0', 'admin', '2022-04-28 10:59:12', '', NULL, '报警通知列表');
COMMIT;

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor` (
  `info_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) DEFAULT '' COMMENT '登录IP地址',
  `status` char(1) DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) DEFAULT '' COMMENT '提示信息',
  `access_time` datetime DEFAULT NULL COMMENT '访问时间',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`info_id`) USING BTREE,
  KEY `idx_logininfo_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='系统访问记录';

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) NOT NULL COMMENT '菜单名称',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
  `path` varchar(200) DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) DEFAULT NULL COMMENT '路由参数',
  `is_frame` int(11) DEFAULT '1' COMMENT '是否为外链（0是 1否）',
  `is_cache` int(11) DEFAULT '0' COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2044 DEFAULT CHARSET=utf8mb4 COMMENT='菜单权限表';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2022-03-07 15:41:18', '', NULL, '系统管理目录');
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2022-03-07 15:41:18', '', NULL, '系统监控目录');
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2022-03-07 15:41:18', '', NULL, '系统工具目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 2, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-15 16:00:35', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 3, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-15 16:00:47', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2022-03-07 15:41:18', '', NULL, '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2022-03-07 15:41:18', '', NULL, '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2022-03-07 15:41:18', '', NULL, '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2022-03-07 15:41:18', '', NULL, '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2022-03-07 15:41:18', '', NULL, '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2022-03-07 15:41:18', '', NULL, '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2022-03-07 15:41:18', '', NULL, '日志管理菜单');
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2022-03-07 15:41:18', '', NULL, '在线用户菜单');
INSERT INTO `sys_menu` VALUES (113, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2022-03-07 15:41:18', '', NULL, '表单构建菜单');
INSERT INTO `sys_menu` VALUES (114, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2022-03-07 15:41:18', '', NULL, '代码生成菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'system/operlog/index', '', 1, 0, 'C', '0', '0', 'system:operlog:list', 'form', 'admin', '2022-03-07 15:41:18', '', NULL, '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'system/logininfor/index', '', 1, 0, 'C', '0', '0', 'system:logininfor:list', 'logininfor', 'admin', '2022-03-07 15:41:18', '', NULL, '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:operlog:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:operlog:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:operlog:export', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:logininfor:export', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1049, '生成查询', 114, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '生成修改', 114, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1051, '生成删除', 114, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1052, '导入代码', 114, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1053, '预览代码', 114, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (1054, '生成代码', 114, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2022-03-07 15:41:18', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2013, '租户管理', 1, 1, 'tenant', 'system/tenant/index', NULL, 1, 0, 'C', '0', '0', 'system:tenant:list', 'tree', 'admin', '2022-03-15 16:21:49', 'admin', '2022-03-15 16:24:59', '租户管理菜单');
INSERT INTO `sys_menu` VALUES (2014, '租户管理查询', 2013, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenant:query', '#', 'admin', '2022-03-15 16:21:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2015, '租户管理新增', 2013, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenant:add', '#', 'admin', '2022-03-15 16:21:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2016, '租户管理修改', 2013, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenant:edit', '#', 'admin', '2022-03-15 16:21:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2017, '租户管理删除', 2013, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenant:remove', '#', 'admin', '2022-03-15 16:21:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2018, '租户管理导出', 2013, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenant:export', '#', 'admin', '2022-03-15 16:21:49', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2019, '租户套餐', 1, 1, 'tenantpackage', 'system/tenantpackage/index', NULL, 1, 0, 'C', '0', '0', 'system:tenantpackage:list', 'shopping', 'admin', '2022-03-25 15:44:09', 'admin', '2022-03-25 15:45:16', '租户套餐菜单');
INSERT INTO `sys_menu` VALUES (2020, '租户套餐查询', 2019, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenantpackage:query', '#', 'admin', '2022-03-25 15:44:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2021, '租户套餐新增', 2019, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenantpackage:add', '#', 'admin', '2022-03-25 15:44:09', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2022, '租户套餐修改', 2019, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenantpackage:edit', '#', 'admin', '2022-03-25 15:44:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2023, '租户套餐删除', 2019, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenantpackage:remove', '#', 'admin', '2022-03-25 15:44:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2024, '租户套餐导出', 2019, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:tenantpackage:export', '#', 'admin', '2022-03-25 15:44:10', '', NULL, '');
INSERT INTO `sys_menu` VALUES (2025, 'Debug菜单', 3, 4, 'demo', 'system/demo/index', NULL, 1, 0, 'C', '0', '0', 'system:demo:list', 'bug', 'admin', '2022-04-09 22:21:59', 'admin', '2022-04-12 11:37:41', '测试菜单');
INSERT INTO `sys_menu` VALUES (2026, 'Debug查询', 2025, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:demo:query', '#', 'admin', '2022-04-09 22:21:59', 'admin', '2022-04-12 11:47:39', '');
INSERT INTO `sys_menu` VALUES (2027, 'Debug新增', 2025, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:demo:add', '#', 'admin', '2022-04-09 22:21:59', 'admin', '2022-04-12 11:48:01', '');
INSERT INTO `sys_menu` VALUES (2028, 'Debug修改', 2025, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:demo:edit', '#', 'admin', '2022-04-09 22:21:59', 'admin', '2022-04-12 11:48:09', '');
INSERT INTO `sys_menu` VALUES (2029, 'Debug删除', 2025, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:demo:remove', '#', 'admin', '2022-04-09 22:21:59', 'admin', '2022-04-12 11:48:13', '');
INSERT INTO `sys_menu` VALUES (2030, 'Debug导出', 2025, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:demo:export', '#', 'admin', '2022-04-09 22:21:59', 'admin', '2022-04-12 11:48:19', '');
INSERT INTO `sys_menu` VALUES (2031, '服务器管理', 2, 1, 'sys', 'monitor/sys/index', NULL, 1, 0, 'C', '0', '0', 'monitor:sys:list', 'server', 'admin', '2022-04-26 15:12:09', 'admin', '2022-04-27 09:24:22', '服务器管理菜单');
INSERT INTO `sys_menu` VALUES (2032, '服务器管理查询', 2031, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:sys:query', '#', 'admin', '2022-04-26 15:12:09', 'admin', '2022-04-27 09:24:34', '');
INSERT INTO `sys_menu` VALUES (2033, '服务器管理新增', 2031, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:sys:add', '#', 'admin', '2022-04-26 15:12:09', 'admin', '2022-04-27 09:24:44', '');
INSERT INTO `sys_menu` VALUES (2034, '服务器管理修改', 2031, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:sys:edit', '#', 'admin', '2022-04-26 15:12:09', 'admin', '2022-04-27 09:24:58', '');
INSERT INTO `sys_menu` VALUES (2035, '服务器管理删除', 2031, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:sys:remove', '#', 'admin', '2022-04-26 15:12:09', 'admin', '2022-04-27 09:27:10', '');
INSERT INTO `sys_menu` VALUES (2036, '服务器管理导出', 2031, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:sys:export', '#', 'admin', '2022-04-26 15:12:09', 'admin', '2022-04-27 09:27:31', '');
INSERT INTO `sys_menu` VALUES (2037, '缓存管理', 2, 1, 'cache', 'monitor/cache/index', NULL, 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2022-04-27 09:12:20', 'admin', '2022-04-27 09:24:05', '缓存管理菜单');
INSERT INTO `sys_menu` VALUES (2038, '缓存管理查询', 2037, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:cache:query', '#', 'admin', '2022-04-27 09:12:20', 'admin', '2022-04-27 09:27:48', '');
INSERT INTO `sys_menu` VALUES (2039, '缓存管理新增', 2037, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:cache:add', '#', 'admin', '2022-04-27 09:12:20', 'admin', '2022-04-27 09:27:58', '');
INSERT INTO `sys_menu` VALUES (2040, '缓存管理修改', 2037, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:cache:edit', '#', 'admin', '2022-04-27 09:12:20', 'admin', '2022-04-27 09:28:09', '');
INSERT INTO `sys_menu` VALUES (2041, '缓存管理删除', 2037, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:cache:remove', '#', 'admin', '2022-04-27 09:12:20', 'admin', '2022-04-27 09:28:18', '');
INSERT INTO `sys_menu` VALUES (2042, '缓存管理导出', 2037, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'monitor:cache:export', '#', 'admin', '2022-04-27 09:12:20', 'admin', '2022-04-27 09:28:26', '');
COMMIT;

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice` (
  `notice_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) NOT NULL COMMENT '公告标题',
  `notice_type` char(1) NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob COMMENT '公告内容',
  `status` char(1) DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`notice_id`) USING BTREE,
  KEY `idx_notice_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COMMENT='通知公告表';

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
BEGIN;
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 Vctgo新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2022-03-07 15:41:18', 'admin', '2022-03-07 18:36:11', '管理员', 9999);
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 Vctgo系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2022-03-07 15:41:18', '', NULL, '管理员', 9999);
INSERT INTO `sys_notice` VALUES (10, '测试通知功能', '1', 0x3C703EE68891E698AFE4B880E4B8AAE9809AE79FA5E58A9FE883BDE79A84E6B58BE8AF95E4BFA1E681AF3C2F703E, '0', 'admin', '2022-03-07 18:37:27', '', NULL, NULL, 9999);
COMMIT;

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log` (
  `oper_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) DEFAULT '' COMMENT '模块标题',
  `business_type` int(11) DEFAULT '0' COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) DEFAULT '' COMMENT '请求方式',
  `operator_type` int(11) DEFAULT '0' COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) DEFAULT '' COMMENT '返回参数',
  `status` int(11) DEFAULT '0' COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime DEFAULT NULL COMMENT '操作时间',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`oper_id`) USING BTREE,
  KEY `idx_operlog_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COMMENT='操作日志记录';

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post` (
  `post_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) NOT NULL COMMENT '岗位名称',
  `post_sort` int(11) NOT NULL COMMENT '显示顺序',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  PRIMARY KEY (`post_id`) USING BTREE,
  KEY `idx_post_menu` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COMMENT='岗位信息表';

-- ----------------------------
-- Records of sys_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2022-03-07 15:41:18', '', NULL, '', 9999);
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2022-03-07 15:41:18', '', NULL, '', 9999);
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2022-03-07 15:41:18', '', NULL, '', 9999);
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2022-03-07 15:41:18', '', NULL, '', 9999);
COMMIT;

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) NOT NULL COMMENT '角色权限字符串',
  `role_sort` int(11) NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) DEFAULT '1' COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) DEFAULT '1' COMMENT '部门树选择项是否关联显示',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `admin_role` int(1) NOT NULL DEFAULT '0' COMMENT '是否管理员角色（0 不是 1是）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户ID',
  PRIMARY KEY (`role_id`) USING BTREE,
  KEY `idx_role_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COMMENT='角色信息表';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 1, 'admin', '2022-03-07 15:41:18', '', NULL, '超级管理员', 9999);
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, '4', 1, 0, '0', '0', 0, 'admin', '2022-03-07 15:41:18', 'admin', '2022-04-27 15:37:00', '普通角色', 9999);
COMMIT;

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `dept_id` bigint(20) NOT NULL COMMENT '部门ID',
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`dept_id`) USING BTREE,
  KEY `idx_roledept_menu` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和部门关联表';

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `menu_id` bigint(20) NOT NULL COMMENT '菜单ID',
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`role_id`,`menu_id`) USING BTREE,
  KEY `idx_rolemenu_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='角色和菜单关联表';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
BEGIN;
INSERT INTO `sys_role_menu` VALUES (2, 1, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 2, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 100, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 101, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 103, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 104, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 113, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 114, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 500, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 501, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1001, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1002, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1003, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1004, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1005, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1006, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1007, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1008, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1009, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1010, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1011, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1012, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1013, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1014, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1015, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1016, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1017, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1018, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1019, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1020, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1021, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1022, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1023, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1024, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1025, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1026, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1027, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1028, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1029, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1030, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1031, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1032, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1033, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1034, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1035, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1040, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1041, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1042, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1043, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1044, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1045, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1046, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1047, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1048, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1049, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1050, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1051, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1052, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1053, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 1054, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 2037, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 2038, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 2039, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 2040, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 2041, 9999);
INSERT INTO `sys_role_menu` VALUES (2, 2042, 9999);
COMMIT;

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_name` varchar(50) NOT NULL COMMENT '租户名称',
  `user_name` varchar(20) DEFAULT NULL COMMENT '管理员账号',
  `user_phone` varchar(20) DEFAULT NULL COMMENT '手机号码',
  `user_email` varchar(200) DEFAULT NULL COMMENT '邮箱地址',
  `tenant_package` bigint(20) DEFAULT NULL COMMENT '租户套餐',
  `tenant_time` datetime DEFAULT NULL COMMENT '租赁结束时间',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8mb4 COMMENT='租户表';

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE `sys_tenant_package` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '套餐编号',
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '套餐名',
  `menu_ids` varchar(2048) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关联的菜单编号',
  `status` char(1) CHARACTER SET utf8mb4 NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='租户套餐表';

-- ----------------------------
-- Records of sys_tenant_package
-- ----------------------------
BEGIN;
INSERT INTO `sys_tenant_package` VALUES (18, '基础管理套餐', '100,1001,1002,1003,1004,1005,1006,1007,101,1008,1009,1010,1011,1012,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,1', '0', '0', 'admin', '2022-04-08 10:07:31', 'admin', '2022-04-08 10:07:31', '');
INSERT INTO `sys_tenant_package` VALUES (100, '系统监控套餐', '2025,2026,2027,2028,2029,2030', '0', '0', 'admin', '2022-04-24 16:28:08', NULL, NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '10' COMMENT '用户类型（00系统用户,默认10 非管理员）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint(20) NOT NULL COMMENT '租户id',
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `idx_user_tenant` (`tenant_id`) USING BTREE,
  KEY `idx_user_name` (`user_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=104 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
BEGIN;
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '管理员', '00', 'dhr92@163.com', '13888888888', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2022-03-07 15:41:18', 'admin', '2022-03-07 15:41:18', '', '2022-06-10 23:59:24', '管理员', 9999);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `post_id` bigint(20) NOT NULL COMMENT '岗位ID',
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`post_id`) USING BTREE,
  KEY `idx_sysuserpost_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户与岗位关联表';

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_post` VALUES (1, 1, 9999);
COMMIT;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `user_id` bigint(20) NOT NULL COMMENT '用户ID',
  `role_id` bigint(20) NOT NULL COMMENT '角色ID',
  `tenant_id` bigint(20) NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  KEY `idx_sysuserrole_tenant` (`tenant_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户和角色关联表';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
BEGIN;
INSERT INTO `sys_user_role` VALUES (1, 1, 9999);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
