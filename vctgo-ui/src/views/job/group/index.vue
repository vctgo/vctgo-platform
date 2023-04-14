<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="138px">
                  <el-form-item label="执行器AppName" prop="appname">
                    <el-input
                        v-model="queryParams.appname"
                        placeholder="请输入执行器AppName"
                        clearable
                        @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="执行器名称" prop="title">
                    <el-input
                        v-model="queryParams.title"
                        placeholder="请输入执行器名称"
                        clearable
                        @keyup.enter.native="handleQuery"
                    />
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
            v-hasPermi="['job:group:add']"
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
            v-hasPermi="['job:group:edit']"
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
            v-hasPermi="['job:group:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="groupList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
              <el-table-column label="执行器AppName" align="center" prop="appname" />
              <el-table-column label="执行器名称" align="center" prop="title" />
              <el-table-column label="执行器地址类型" align="center" prop="addressType" >
                <template slot-scope="scope">
                  <dict-tag :options="dict.type.sys_job_address_type" :value="scope.row.addressType"/>
                </template>
              </el-table-column>
              <el-table-column label="执行器地址列表" align="center" prop="addressList" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['job:group:edit']"
          >修改</el-button>
          <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['job:group:remove']"
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

    <!-- 添加或修改定时任务分组对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="140px">
                        <el-form-item label="执行器AppName" prop="appname">
                          <el-input v-model="form.appname" placeholder="请输入执行器AppName" />
                        </el-form-item>
                        <el-form-item label="执行器名称" prop="title">
                          <el-input v-model="form.title" placeholder="请输入执行器名称" />
                        </el-form-item>
                        <el-form-item label="执行器地址类型" prop="addressType">
                          <el-radio v-model="form.addressType" :label=0>自动注册</el-radio>
                          <el-radio v-model="form.addressType" :label=1>手动录入</el-radio>
                        </el-form-item>
                        <el-form-item label="执行器地址列表" prop="addressList">
                          <el-input v-model="form.addressList" type="textarea" placeholder="执行器地址列表，多地址逗号分隔" />
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
  import { listGroup, getGroup, delGroup, addGroup, updateGroup } from "@/api/job/group";
  import {parseTime} from "@/utils/vctgo";

  export default {
    name: "Group",
    dicts: [
      'sys_job_address_type',
    ],
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
        // 定时任务分组表格数据
              groupList: [],
        // 弹出层标题
        title: "",
        // 是否显示弹出层
        open: false,
        // 查询参数
        queryParams: {
          pageNum: 1,
          pageSize: 10,
                        appName: null,
                        title: null,
                        addressType: null,
                        addressList: null,
                        tenantId: null
        },
        // 表单参数
        form: {},
        // 表单校验
        rules: {
          appname: [
                    { required: true, message: "执行器AppName不能为空", trigger: "blur" }
                  ],
                        title: [
                    { required: true, message: "执行器名称不能为空", trigger: "blur" }
                  ],
                        addressType: [
                    { required: true, message: "请选择执行器地址类型", trigger: "change" }
                  ],
        }
      };
    },
    created() {
      this.getList();
    },
    methods: {
      /** 查询定时任务分组列表 */
      getList() {
        this.loading = true;
        listGroup(this.queryParams).then(response => {
          this.groupList = response.data;
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
                        appName: null,
                        title: null,
                        addressType: null,
                        addressList: null,
                        updateTime: null,
                        tenantId: null
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
        this.title = "添加执行器信息";
      },
      /** 修改按钮操作 */
      handleUpdate(row) {
        this.reset();
        const id = row.id || this.ids
        getGroup(id).then(response => {
          this.form = response.data;
          this.open = true;
          this.title = "修改执行器信息";
        });
      },
      /** 提交按钮 */
      submitForm() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.id != null) {
              updateGroup(this.form).then(response => {
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            } else {
              addGroup(this.form).then(response => {
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
        this.$modal.confirm('是否确认删除当前定时任务分组数据项？').then(function() {
          return delGroup(ids);
        }).then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        }).catch(() => {});
      },
      /** 导出按钮操作 */
      handleExport() {
        this.download('job/group/export', {
            ...this.queryParams
        }, `定时任务分组_${parseTime(new Date().getTime(), '{y}-{m}-{d}') }.xlsx`)
      }
   }
  };
</script>
