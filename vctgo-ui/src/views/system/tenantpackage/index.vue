<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="90px">
                  <el-form-item label="套餐名" prop="name">
                    <el-input
                        v-model="queryParams.name"
                        placeholder="请输入套餐名"
                        clearable
                        @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="套餐状态" prop="status">
                    <el-select v-model="queryParams.status" placeholder="请选择租户套餐状态" clearable>
                      <el-option
                          v-for="dict in dict.type.sys_tenant_status"
                          :key="dict.value"
                          :label="dict.label"
                          :value="dict.value"
                      />
                    </el-select>
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
            v-hasPermi="['system:tenantpackage:add']"
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
            v-hasPermi="['system:tenantpackage:edit']"
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
            v-hasPermi="['system:tenantpackage:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="el-icon-download"
            size="mini"
            @click="handleExport"
            v-hasPermi="['system:tenantpackage:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="tenantpackageList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column fixed label="序号" min-width="20%"   align="center">
        <template slot-scope="scope">
          <span>{{(queryParams.pageNum-1)*queryParams.pageSize+(scope.$index + 1)}} </span>
        </template>
      </el-table-column>
              <el-table-column label="套餐编号" align="center" prop="id" v-if="false"/>
              <el-table-column label="套餐名" align="center" prop="name" />
              <el-table-column label="创建时间" align="center" prop="createTime" width="180">
                <template slot-scope="scope">
                  <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
                </template>
              </el-table-column>
              <el-table-column label="租户套餐状态" align="center" prop="status">
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
              v-hasPermi="['system:tenantpackage:edit']"
          >修改</el-button>
          <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['system:tenantpackage:remove']"
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

    <!-- 对话框(添加 / 修改) -->
    <el-dialog :title="title" :visible.sync="open" width="550px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="套餐名" prop="name">
          <el-input v-model="form.name" placeholder="请输入套餐名" />
        </el-form-item>
        <el-form-item label="菜单权限">
          <el-checkbox v-model="menuExpand" @change="handleCheckedTreeExpand($event)">展开/折叠</el-checkbox>
          <el-checkbox v-model="menuNodeAll" @change="handleCheckedTreeNodeAll($event)">全选/全不选</el-checkbox>
          <el-tree class="tree-border" :data="menuOptions" show-checkbox ref="menu" node-key="id"
                   :check-strictly="menuCheckStrictly" empty-text="加载中，请稍后" :props="defaultProps"></el-tree>
        </el-form-item>

        <el-form-item label="套餐状态">
          <el-radio-group v-model="form.status">
            <el-radio
              v-for="dict in dict.type.sys_tenant_status"
              :key="dict.value"
              :label="parseInt(dict.value)"
            >{{dict.label}}</el-radio>
          </el-radio-group>
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
  import { listTenantpackage, getTenantpackage, delTenantpackage, addTenantpackage, updateTenantpackage } from "@/api/system/tenantpackage";
  import {listSimpleMenus} from "@/api/system/menu";
  import {parseTime} from "@/utils/vctgo";

  export default {
    name: "Tenantpackage",
        dicts: ['sys_tenant_status'],
    data() {
      return {
        defaultProps: {
          label: "name",
          children: "children"
        },
        menuOptions: [], // 菜单列表
        //展开参数
        menuExpand: false,
        menuNodeAll: false,
        menuCheckStrictly: true,
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
        // 租户套餐表格数据
              tenantpackageList: [],
        // 弹出层标题
        title: "",
        // 是否显示弹出层
        open: false,
        // 查询参数
        queryParams: {
          pageNum: 1,
          pageSize: 10,
                        name: null,
                        status: null
        },
        // 表单参数
        form: {},
        // 表单校验
        rules: {
          name: [{ required: true, message: "套餐名不能为空", trigger: "blur" }],
          status: [{ required: true, message: "状态不能为空", trigger: "blur" }],
          menuIds: [{ required: true, message: "关联的菜单编号不能为空", trigger: "blur" }],
        }
      };
    },
    created() {
      this.getList();
      this.getMenus();
    },
    methods: {
      /** 查询租户套餐列表 */
      getList() {
        this.loading = true;
        listTenantpackage(this.queryParams).then(response => {
          this.tenantpackageList = response.data;
          this.total = response.total;
          this.loading = false;
        });
      },
      /** 获得菜单 */
      getMenus() {
        listSimpleMenus().then(response => {
          // 处理 menuOptions 参数
          this.menuOptions = [];
          // 只需要配置
          this.menuOptions.push(...this.handleTree(response.data, "id"));
        });
      },
      // 取消按钮
      cancel() {
        this.open = false;
        this.reset();
      },
      // 表单重置

      reset() {
        if (this.$refs.menu !== undefined) {
          this.$refs.menu.setCheckedKeys([]);
        }
        this.menuExpand = false;
        this.menuNodeAll = false;
        this.menuCheckStrictly = true;
        this.form = {
                        id: null,
                        name: null,
                        menuIds: null,
                        createBy: null,
                        createTime: null,
                        updateBy: null,
                        updateTime: null,
                    status: 0
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
        this.title = "添加租户套餐";
        this.menuCheckStrictly = false;
      },
      /** 修改按钮操作 */
      handleUpdate(row) {
        this.reset();
        const id = row.id;
        this.open = true;
        this.title = "修改租户套餐";
        // 获得菜单列表
        getTenantpackage(id).then(response => {
          this.form = response.data;
          // 设置菜单项
          // 设置为严格，避免设置父节点自动选中子节点，解决半选中问题
          this.menuCheckStrictly = true
          // 设置选中
          this.$refs.menu.setCheckedKeys(response.data.menuIds.split(','));
          // 设置为非严格，继续使用半选中
          this.menuCheckStrictly = false
        });
      },
      /** 提交按钮 */
      submitForm() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.id != null) {
              updateTenantpackage({...this.form,
                menuIds: [...this.$refs.menu.getCheckedKeys(), ...this.$refs.menu.getHalfCheckedKeys()].toString()
              }).then(response => {
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            } else {
              addTenantpackage({
                ...this.form,
                menuIds: [...this.$refs.menu.getCheckedKeys(), ...this.$refs.menu.getHalfCheckedKeys()].toString()
              }).then(response => {
                this.$modal.msgSuccess("新增成功");
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
        this.$modal.confirm('是否确认删除当前租户套餐数据项？').then(function() {
          return delTenantpackage(ids);
        }).then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        }).catch(() => {});
      },
      /** 导出按钮操作 */
      handleExport() {
        this.download('system/tenantpackage/export', {
          ...this.queryParams
        }, `租户套餐_${parseTime(new Date().getTime(), '{y}-{m}-{d}') }.xlsx`)
      },
      // 树权限（展开/折叠）
      handleCheckedTreeExpand(value, type) {
        let treeList = this.menuOptions;
        for (let i = 0; i < treeList.length; i++) {
          this.$refs.menu.store.nodesMap[treeList[i].id].expanded = value;
        }
      },
      // 树权限（全选/全不选）
      handleCheckedTreeNodeAll(value) {
        this.$refs.menu.setCheckedNodes(value ? this.menuOptions: []);
      },
      // 树权限（父子联动）
      handleCheckedTreeConnect(value) {
        this.form.menuCheckStrictly = value;
      }
    }
  };
</script>
