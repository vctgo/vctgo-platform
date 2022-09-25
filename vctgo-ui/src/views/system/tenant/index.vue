<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="100px">
                  <el-form-item label="租户名称" prop="tenantName">
                    <el-input
                        v-model="queryParams.tenantName"
                        placeholder="请输入租户名称"
                        clearable
                        @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="管理员账号" prop="userName">
                    <el-input
                        v-model="queryParams.userName"
                        placeholder="请输入管理员账号"
                        clearable
                        @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="手机号码" prop="userPhone">
                    <el-input
                        v-model="queryParams.userPhone"
                        placeholder="请输入手机号码"
                        clearable
                        @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="租赁结束时间">
                    <el-date-picker
                        v-model="daterangeTenantTime"
                        style="width: 240px"
                        value-format="yyyy-MM-dd"
                        type="daterange"
                        range-separator="-"
                        start-placeholder="开始日期"
                        end-placeholder="结束日期"
                    ></el-date-picker>
                  </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
            type="primary"
            plain
            icon="el-icon-plus"
            size="mini"
            @click="handleAdd"
            v-hasPermi="['system:tenant:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="success"
            plain
            icon="el-icon-edit"
            size="mini"
            :disabled="single"
            @click="handleUpdate"
            v-hasPermi="['system:tenant:edit']"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="el-icon-delete"
            size="mini"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['system:tenant:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="el-icon-download"
            size="mini"
            @click="handleExport"
            v-hasPermi="['system:tenant:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="tenantList" @selection-change="handleSelectionChange">
        <el-table-column label="租户编码" align="center" prop="id" />
        <el-table-column label="租户名称" align="center" prop="tenantName" />
        <el-table-column label="管理员账号" align="center" prop="userName" />
        <el-table-column label="手机号码" align="center" prop="userPhone" />
        <el-table-column label="邮箱地址" align="center" prop="userEmail" />
      <el-table-column label="租户套餐" align="center" prop="tenantPackage" width="180">
        <template slot-scope="scope">
          <el-tag>{{ getPackageName(scope.row.tenantPackage)}}</el-tag>
        </template>
      </el-table-column>
              <el-table-column label="租赁结束时间" align="center" prop="tenantTime" width="120">
                <template slot-scope="scope">
                  <span>{{ parseTime(scope.row.tenantTime, '{y}-{m}-{d}') }}</span>
                </template>
              </el-table-column>
              <el-table-column label="租户状态" align="center" prop="status">
                <template slot-scope="scope">
                      <dict-tag :options="dict.type.sys_tenant_status" :value="scope.row.status"/>
                </template>
              </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['system:tenant:edit']"
          >修改</el-button>
          <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['system:tenant:remove']"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
        v-show="total>0"
        :total="total"
        :page.sync="queryParams.pageNum"
        :limit.sync="queryParams.pageSize"
        @pagination="getList"
    />

    <!-- 添加或修改租户管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="550px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
                        <el-form-item label="租户编码" prop="id">
                          <el-input v-model="form.id" placeholder="请输入租户编码" :disabled="this.updateOrAdd"  />
                        </el-form-item>
                        <el-form-item label="租户名称" prop="tenantName" >
                          <el-input v-model="form.tenantName" placeholder="请输入租户名称" :disabled="this.updateOrAdd" />
                        </el-form-item>
                        <el-form-item label="管理员账号" prop="userName">
                          <el-input v-model="form.userName" placeholder="请输入管理员账号" :disabled="this.updateOrAdd" />
                        </el-form-item>
                        <el-form-item label="手机号码" prop="userPhone">
                          <el-input v-model="form.userPhone" placeholder="请输入手机号码" />
                        </el-form-item>
                        <el-form-item label="邮箱地址" prop="userEmail">
                          <el-input v-model="form.userEmail" placeholder="请输入邮箱地址" />
                        </el-form-item>
                        <el-form-item label="租户套餐" prop="tenantPackage">
                          <el-select v-model="form.tenantPackage"  placeholder="请选择租户套餐" clearable size="small">
                            <el-option v-for="item in packageList" :key="item.id" :label="item.name" :value="item.id"/>
                          </el-select>
                        </el-form-item>
                        <el-form-item label="租赁结束时间" prop="tenantTime">
                          <el-date-picker clearable
                                          v-model="form.tenantTime"
                                          type="date"
                                          value-format="yyyy-MM-dd"
                                          placeholder="请选择租赁结束时间">
                          </el-date-picker>
                        </el-form-item>
                        <el-form-item label="租户状态">
                          <el-radio-group v-model="form.status">
                            <el-radio
                                v-for="dict in dict.type.sys_tenant_status"
                                :key="dict.value"
:label="parseInt(dict.value)"
                            >{{dict.label}}</el-radio>
                          </el-radio-group>
                        </el-form-item>
                        <el-form-item label="备注" prop="remark">
                          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
                        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import { listTenant, getTenant, delTenant, addTenant, updateTenant } from "@/api/system/tenant";
  import {getTenantPackageList} from "@/api/system/tenantpackage";
  import {parseTime} from "@/utils/vctgo";

  export default {
    name: "Tenant",
        dicts: ['sys_tenant_status'],
    data() {
      return {
        // 遮罩层
        loading: true,
        // 选中数组
        ids: [],
        // 非单个禁用
        single: true,
        // 非多个禁用
        multiple: true,
        // 显示搜索条件
        showSearch: true,
        // 总条数
        total: 0,
        // 租户管理表格数据
              tenantList: [],
        // 弹出层标题
        title: "",
        // 是否显示弹出层
        open: false,
        // 租户套餐列表
        packageList: [],
                // 备注时间范围
                daterangeTenantTime: [],
        // 查询参数
        queryParams: {
          pageNum: 1,
          pageSize: 10,
                        tenantName: null,
                        userName: null,
                        userPhone: null,
                        tenantTime: null,
                        status: null,
        },
        // 表单参数
        form: {},
        // 是否更新 默认是插入 不禁用无法修改的字段
        updateOrAdd: false,
        // 表单校验
        rules: {
                        id: [
                    { required: true, message: "租户编码不能为空", trigger: "blur" },
                          {
                            pattern: /^[1-9]\d*$/,
                            message: "租户编码只能为数字类型",
                            trigger: "blur"
                          }
                  ],
                        tenantName: [
                    { required: true, message: "租户名称不能为空", trigger: "blur" }
                  ],
                        userName: [
                    { required: true, message: "管理员账号不能为空", trigger: "blur" }
                  ],
                        userPhone: [
                    { required: true, message: "手机号码不能为空", trigger: "blur" },
                    {
                      pattern: /^((0\d{2,3}-\d{7,8})|(1[34578]\d{9}))$/,
                      message: "请输入正确的手机号码",
                      trigger: "blur"
                    }
                  ],
                        userEmail: [
                    { required: true, message: "邮箱地址不能为空", trigger: "blur" },
                    {
                      type: "email",
                      message: "请输入正确的邮箱地址",
                      trigger: ["blur", "change"]
                    }
                  ],
                        tenantPackage: [
                    { required: true, message: "租户套餐不能为空", trigger: "blur" }
                  ],
                        tenantTime: [
                    { required: true, message: "租赁结束时间不能为空", trigger: "blur" }
                  ],
                        status: [
                    { required: true, message: "租户状态不能为空", trigger: "blur" }
                  ],
        }
      };
    },
    created() {
      this.getList();
      // 获得租户套餐列表
      getTenantPackageList().then(response => {
        this.packageList = response.data;
      })
    },
    methods: {
      /** 查询租户管理列表 */
      getList() {
        this.loading = true;
                this.queryParams.params = {};
                if (null != this.daterangeTenantTime && '' != this.daterangeTenantTime) {
                  this.queryParams.params["beginTenantTime"] = this.daterangeTenantTime[0];
                  this.queryParams.params["endTenantTime"] = this.daterangeTenantTime[1];
                }
        listTenant(this.queryParams).then(response => {
          this.tenantList = response.data;
          this.total = response.total;
          this.loading = false;
        });
      },
      // 取消按钮
      cancel() {
        this.open = false;
        this.reset();
      },
      // 表单重置
      reset() {
        this.form = {
                        id: null,
                        tenantName: null,
                        userName: null,
                        userPhone: null,
                        userEmail: null,
                        tenantPackage: null,
                        tenantTime: null,
                        status: 0,
                        delFlag: null,
                        createBy: null,
                        createTime: null,
                        updateBy: null,
                        updateTime: null,
                        remark: null
        };
        this.resetForm("form");
      },
      /** 搜索按钮操作 */
      handleQuery() {
        this.queryParams.pageNum = 1;
        this.getList();
      },
      /** 重置按钮操作 */
      resetQuery() {
                this.daterangeTenantTime = [];
        this.resetForm("queryForm");
        this.handleQuery();
      },
      // 多选框选中数据
      handleSelectionChange(selection) {
        this.ids = selection.map(item => item.id)
        this.single = selection.length!==1
        this.multiple = !selection.length
      },
      /** 新增按钮操作 */
      handleAdd() {
        this.reset();
        this.open = true;
        this.updateOrAdd=false;
        this.title = "新增租户";
        //每次修改租户的时候都会添加租户套餐校验
        getTenantPackageList().then(response => {
          this.packageList = response.data;
        })
      },
      /** 修改按钮操作 */
      handleUpdate(row) {
        this.reset();
        getTenantPackageList().then(response => {
          this.packageList = response.data;
        })
        this.updateOrAdd=true;
        const id = row.id || this.ids
        getTenant(id).then(response => {
          this.form = response.data;
          this.open = true;
          this.title = "修改租户";
        });
      },
      /** 提交按钮 */
      submitForm() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.id != null && this.updateOrAdd) {
              updateTenant(this.form).then(response => {
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            } else {
              addTenant(this.form).then(response => {
                this.$modal.msgSuccess("新增成功,密码已发送至邮箱");
                this.open = false;
                this.getList();
              });
            }
          }
        });
      },
      /** 删除按钮操作 */
      handleDelete(row) {
        const ids = row.id || this.ids;
        this.$modal.confirm('是否确认删除当前租户数据项？').then(function() {
          return delTenant(ids);
        }).then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        }).catch(() => {});
      },
      /** 导出按钮操作 */
      handleExport() {
        this.download('system/tenant/export', {
          ...this.queryParams
        }, `租户管理_${parseTime(new Date().getTime(), '{y}-{m}-{d}') }.xlsx`)
      } ,

      getPackageName(packageId) {
        var t_name = "";
        for (const t_item of this.packageList)
        {
          if (t_item.id === parseInt(packageId))
          {
            t_name = t_item.name;
          }
        }
        return t_name;
      }
    },
  };
</script>
