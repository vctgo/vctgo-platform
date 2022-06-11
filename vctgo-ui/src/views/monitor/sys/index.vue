<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
                  <el-form-item label="系统名称" prop="sysName">
                    <el-input
                        v-model="queryParams.sysName"
                        placeholder="请输入系统名称"
                        clearable
                        @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="IP地址" prop="ip">
                    <el-input
                        v-model="queryParams.ip"
                        placeholder="请输入IP地址"
                        clearable
                        @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="是否在线" prop="isOnline">
                    <el-select v-model="queryParams.isOnline" placeholder="请选择是否在线" clearable>
                      <el-option
                          v-for="dict in dict.type.sys_notice_status"
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
            v-hasPermi="['monitor:sys:add']"
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
            v-hasPermi="['monitor:sys:edit']"
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
            v-hasPermi="['monitor:sys:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="warning"
            plain
            icon="el-icon-download"
            size="mini"
            @click="handleExport"
            v-hasPermi="['monitor:sys:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="sysList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column fixed label="序号" width="55"   align="center">
        <template slot-scope="scope">
          <span>{{(queryParams.pageNum-1)*queryParams.pageSize+(scope.$index + 1)}} </span>
        </template>
      </el-table-column>
      <el-table-column   label="图标" align="center" width="100">
          <svg-icon icon-class="linux" />
      </el-table-column>
              <el-table-column label="主键" align="center" prop="id"  v-if="false" />
              <el-table-column label="系统名称" align="center" prop="sysName" />
              <el-table-column label="IP地址" align="center" prop="ip" />
              <el-table-column label="CPU(%)" align="center" prop="cpuInfo" />
              <el-table-column label="CPU核心" align="center" prop="cpuCoreInfo" />
              <el-table-column label="内存(%)" align="center" prop="memInfo" />
              <el-table-column label="硬盘大小" align="center" prop="diskInfo" />
              <el-table-column label="硬盘(%)" align="center" prop="diskPercent" />
              <el-table-column label="是否在线" align="center" prop="isOnline">
                <template slot-scope="scope">
                      <dict-tag :options="dict.type.sys_notice_status" :value="scope.row.isOnline"/>
                </template>
              </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
              size="mini"
              type="text"
              icon="el-icon-edit"
              @click="handleUpdate(scope.row)"
              v-hasPermi="['monitor:sys:edit']"
          >修改</el-button>
          <el-button
              size="mini"
              type="text"
              icon="el-icon-delete"
              @click="handleDelete(scope.row)"
              v-hasPermi="['monitor:sys:remove']"
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

    <!-- 添加或修改服务器管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
                        <el-form-item label="系统名称" prop="sysName">
                          <el-input v-model="form.sysName" placeholder="请输入系统名称" />
                        </el-form-item>
                        <el-form-item label="IP地址" prop="ip">
                          <el-input v-model="form.ip" placeholder="请输入IP地址" />
                        </el-form-item>
                        <el-form-item label="用户名" prop="userName">
                          <el-input v-model="form.userName" placeholder="请输入用户名" />
                        </el-form-item>
                        <el-form-item label="用户密码" prop="userPassword" >
                          <el-input v-model="form.userPassword" placeholder="请输入用户密码" type="password" />
                        </el-form-item>
                        <el-form-item label="系统端口" prop="ipPort">
                          <el-input v-model="form.ipPort" placeholder="请输入系统端口" />
                        </el-form-item>
                        <el-form-item label="通知方式" prop="messageType">
                          <el-select v-model="form.messageType"  placeholder="请选通知类型"  size="small"
                          @change="chanageMessageType">
                            <el-option
                              v-for="dict in dict.type.sys_message_type"
                              :key="parseInt(dict.value)"
                              :label="dict.label"
                              :value="parseInt(dict.value)"
                            />
                          </el-select>
                        </el-form-item>
                        <el-form-item label="手机号码" prop="userPhone" v-if=phoneshow>
                          <el-input v-model="form.userPhone"   placeholder="请输入内容" />
                        </el-form-item>
                        <el-form-item label="邮箱地址" prop="userEmail" v-if=emailshow>
                          <el-input v-model="form.userEmail"   placeholder="请输入内容" />
                        </el-form-item>
                        <el-form-item label="备注" prop="remark">
                          <el-input v-model="form.remark" type="textarea" placeholder="请输入内容" />
                        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="testLink">测试连接</el-button>
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import { listSys, getSys, delSys, addSys, updateSys ,testLink } from "@/api/monitor/sys";
  import {parseTime} from "@/utils/vctgo";

  export default {
    name: "Sys",
    dicts: ['sys_notice_status','sys_message_type'],
    data() {
      return {
        //通知展示栏目
        phoneshow: true,
        emailshow: false,
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
        // 服务器管理表格数据
        sysList: [],
        // 弹出层标题
        title: "",
        // 是否显示弹出层
        open: false,
        // 查询参数
        queryParams: {
          pageNum: 1,
          pageSize: 10,
                        sysName: null,
                        ip: null,
                        isOnline: null,
        },
        // 表单参数
        form: {},
        // 表单校验
        rules: {
                        ip: [
                    { required: true, message: "IP地址不能为空", trigger: "blur" }
                  ],
                        userName: [
                    { required: true, message: "用户名不能为空", trigger: "blur" }
                  ],
                        userPassword: [
                    { required: true, message: "用户密码不能为空", trigger: "blur" }
                  ],
                        ipPort: [
                    { required: true, message: "系统端口不能为空", trigger: "blur" }
                  ],
                        isOnline: [
                    { required: true, message: "是否在线 0在线 1离线不能为空", trigger: "change" }
                  ],
                    userPhone: [
                      { required: true, message: "手机号码不能为空", trigger: "blur" },
                      {
                        pattern: /^1[3|4|5|6|7|8|9][0-9]\d{8}$/,
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
                   ]
        }
      };
    },
    created() {
      this.getList();
    },
    methods: {
      /** 通知改变 */
      chanageMessageType(row){
          this.phoneshow=row==1?false:true;
          this.emailshow=row==1?true:false;
      },
      /** 查询服务器管理列表 */
      getList() {
        this.loading = true;
        listSys(this.queryParams).then(response => {
          this.sysList = response.data;
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
          sysName: null,
          ip: null,
          userName: null,
          userPassword: null,
          ipPort: null,
          rsaAddr: null,
          isOnline: null,
          createBy: null,
          createTime: null,
          updateBy: null,
          updateTime: null,
          remark: null,
          tenantId: null,
          messageType: 0,
          userPhone: null,
          userEmail: null
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
        this.title = "添加服务器管理";
        this.phoneshow=this.form.messageType==1?false:true;
        this.emailshow=this.form.messageType==1?true:false;
      },
      /** 修改按钮操作 */
      handleUpdate(row) {
        this.reset();
        const id = row.id || this.ids
        getSys(id).then(response => {
          this.form = response.data;
          this.open = true;
          this.title = "修改服务器管理";
          this.phoneshow=this.form.messageType==1?false:true;
          this.emailshow=this.form.messageType==1?true:false;
        });
      },
      /** 提交按钮 */
      submitForm() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.id != null) {
              updateSys(this.form).then(response => {
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            } else {
              addSys(this.form).then(response => {
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
        this.$modal.confirm('是否确认删除当前服务器管理数据项？').then(function() {
          return delSys(ids);
        }).then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        }).catch(() => {});
      },
      /** 导出按钮操作 */
      handleExport() {
        this.download('monitor/sys/export', {
            ...this.queryParams
        }, `服务器管理_${parseTime(new Date().getTime(), '{y}-{m}-{d}') }.xlsx`)
      },
      testLink(){
        testLink(this.form).then(response => {
          if (response.data == "error"){
            this.$modal.msgError("连接失败!");
          }else {
            this.$modal.msgSuccess("连接成功!");
          }
        });
      }
   }
  };
</script>
