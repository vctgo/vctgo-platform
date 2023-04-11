<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
                  <el-form-item label="执行器" prop="jobGroup">
                    <el-select v-model="queryParams.jobGroup" placeholder="请选择">
                      <el-option
                        v-for="item in jobGroupOptions"
                        :key="item.id"
                        :label="item.title"
                        :value="item.id">
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="任务ID" prop="jobId">
                    <el-input
                      v-model="queryParams.jobId"
                      placeholder="请输入任务ID"
                      clearable
                      @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="状态" prop="logStatus">
                    <el-select v-model="queryParams.logStatus" placeholder="请选择">
                      <el-option
                        v-for="item in dict.type.sys_job_log_status"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="调度时间" prop="triggerTimeArr">
                    <el-date-picker
                      v-model="queryParams.triggerTimeArr"
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
            type="danger"
            plain
            icon="el-icon-delete"
            size="mini"
            @click="handleDelete"
            v-hasPermi="['job:log:clearLog']"
        >清理</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="logList" @selection-change="handleSelectionChange">
<!--      <el-table-column type="selection" width="55" align="center" />-->
      <el-table-column label="任务ID" align="center" prop="jobId" />
      <el-table-column label="调度时间" align="center" prop="triggerTime" />
      <el-table-column label="调度结果" align="center" prop="triggerCode" >
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_job_trigger_code" :value="scope.row.triggerCode"/>
        </template>
      </el-table-column>
      <el-table-column label="调度备注" align="center" prop="triggerMsg">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            @click="handleRowDialog(scope.row, 1)"
          >查看</el-button>
        </template>
      </el-table-column>
      <el-table-column label="执行时间" align="center" prop="handleTime" />
      <el-table-column label="调度结果" align="center" prop="handleCode" >
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_job_trigger_code" :value="scope.row.handleCode"/>
        </template>
      </el-table-column>
      <el-table-column label="执行备注" align="center" prop="handleMsg">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            @click="handleRowDialog(scope.row, 2)"
          >查看</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            v-if="scope.row.handleCode === 200"
            @click="handleRowDialog(scope.row, 3)"
            v-hasPermi="['job:log:remove']"
          >执行日志</el-button>
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


    <el-dialog title="调度备注" :visible.sync="showViewTriggerMsgFlag">
      <div v-html="selectRow.triggerMsg"></div>
    </el-dialog>

    <el-dialog title="执行备注" :visible.sync="showRemarkFlag">
      <div v-html="selectRow.handleMsg"></div>
    </el-dialog>

    <el-dialog title="执行日志" :visible.sync="showExecLogFlag">
      <div v-html="logData.logContent"></div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="showExecLogFlag = false">关 闭</el-button>
        <el-button type="primary" @click="getExecLog">刷 新</el-button>
      </span>
    </el-dialog>

    <el-dialog title="日志清理" :visible.sync="showClearLogFlag">
      <el-form ref="clearForm" :model="clearForm" :rules="clearFormRules" label-width="180px">
        <el-form-item label="执行器:" prop="jobGroup">
          <el-select v-model="clearForm.jobGroup" placeholder="请选择" size="" :disabled="true">
            <el-option
              v-for="item in jobGroupOptions"
              :key="item.id"
              :label="item.title"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="任务:" prop="jobId">
          <el-select v-model="clearForm.jobId" placeholder="请选择" :disabled="true">
            <el-option
              v-for="item in jobIdList"
              :key="item.id"
              :label="item.title"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="清理方式:" prop="type">
          <el-select v-model="clearForm.type" placeholder="请选择">
            <el-option
              v-for="item in dict.type.sys_job_log_clear_type"
              :key="item.value"
              :label="item.label"
              :value="item.value">
            </el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="showClearLogFlag = false">取 消</el-button>
        <el-button type="primary" @click="clearLog">确 定</el-button>
      </span>
    </el-dialog>

  </div>
</template>

<script>
  import { listLog, getLog, addLog, updateLog, logDetailCat, clearLog } from "@/api/job/log";
  import {parseTime} from "@/utils/vctgo";
  import {getSelectAll} from "@/api/job/group";

  export default {
    name: "Log",
    dicts: [
      'sys_job_trigger_code',
      'sys_job_log_status',
      'sys_job_log_clear_type',
    ],
    data() {
      return {
        clearForm: {
          jobGroup: null,
          jobId: null,
          type: null,
        },
        jobIdList: [
          {id: '',title: '全部'}
        ],
        clearFormRules: {
          // jobGroup: [
          //   { required: true, message: "请选择执行器", trigger: "blur" }
          // ],
          // jobId: [
          //   { required: true, message: "请选择任务", trigger: "blur" }
          // ],
          type: [
            { required: true, message: "请选择清理方式", trigger: "blur" }
          ]
        },
        // 日志清理
        showClearLogFlag: false,
        // 执行器选择
        jobGroupOptions: [],
        // 日志对象
        logData: {
          logContent: ''
        },
        // 执行日志
        showExecLogFlag: false,
        // 选择行
        selectRow: {},
        // 调度备注弹框
        showViewTriggerMsgFlag: false,
        // 执行备注
        showRemarkFlag: false,
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
        // 定时任务日志表格数据
              logList: [],
        // 弹出层标题
        title: "",
        // 是否显示弹出层
        open: false,
        // 查询参数
        queryParams: {
          pageNum: 1,
          pageSize: 10,
          jobGroup: null,
          jobId: null,
          executorAddress: null,
          executorHandler: null,
          executorParam: null,
          executorShardingParam: null,
          executorFailRetryCount: null,
          triggerTime: null,
          triggerCode: null,
          triggerMsg: null,
          handleTime: null,
          handleCode: null,
          handleMsg: null,
          alarmStatus: null,
          tenantId: null,
          logStatus: null,
        },
        // 表单参数
        form: {},
        // 表单校验
        rules: {
                        jobGroup: [
                    { required: true, message: "执行器主键ID不能为空", trigger: "blur" }
                  ],
                        jobId: [
                    { required: true, message: "任务，主键ID不能为空", trigger: "blur" }
                  ],
                        executorFailRetryCount: [
                    { required: true, message: "失败重试次数不能为空", trigger: "blur" }
                  ],
                        triggerCode: [
                    { required: true, message: "调度-结果不能为空", trigger: "blur" }
                  ],
                        handleCode: [
                    { required: true, message: "执行-状态不能为空", trigger: "blur" }
                  ],
                        alarmStatus: [
                    { required: true, message: "告警状态：0-默认、1-无需告警、2-告警成功、3-告警失败不能为空", trigger: "blur" }
                  ],
        }
      };
    },
    created() {
      this.getList();
      this.initPageDicData();
    },
    methods: {
      // 日志清理
      clearLog(){
        this.$refs["clearForm"].validate(valid => {
          if (valid) {
            clearLog(this.clearForm).then(() => {
              this.$modal.msgSuccess("操作成功");
              this.showClearLogFlag = false;
              this.getList();
            })
          }
        });
      },
      /** 初始化当前页面的一些字典值 */
      initPageDicData() {
        this.jobGroupOptions = [];
        getSelectAll({title: ''}).then(response => {
          this.jobGroupOptions = response.data;
          this.jobGroupOptions.unshift({
            id: '',
            title: '全部'
          })
        });
      },
      // 行点击事件
      handleRowDialog(row, type) {
        this.selectRow = row;
        if (type === 1) { // 查看调度备注
          this.showViewTriggerMsgFlag = true;
        } else if (type === 2) { // 查看执行备注
          this.showRemarkFlag = true;
        } else if (type === 3) { // 查看执行日志
          this.getExecLog(row);
          this.showExecLogFlag = true;
        } else {
          console.log('未定义的操作')
        }
      },
      getExecLog() {
        let that = this;
        that.logData.logContent = '';
        getLog(that.selectRow.id).then(res => {
          console.log('查看执行日志', res)
          let data = res.data;
          logDetailCat({
            executorAddress: data.executorAddress,
            logDateTim: Date.parse(data.triggerTime),
            id: data.id,
            fromLineNum: 1,
          }).then(res =>{
            console.log('logData', res)
            that.logData = res.data;
          })
        })
      },
      // 表格限制字数展示
      stateFormat(row, column, cellValue) {
        if (!cellValue) return ''
        if (cellValue.length > 10) {       //最长固定显示10个字符
          return cellValue.slice(0, 10) + '...'
        }
        return cellValue
      },
      /** 查询定时任务日志列表 */
      getList() {
        this.loading = true;
        if (this.queryParams.triggerTimeArr && this.queryParams.triggerTimeArr.length === 2) {
          console.log('this.queryParams.triggerTimeArr', this.queryParams.triggerTimeArr)
          this.queryParams.triggerTimeStart = this.queryParams.triggerTimeArr[0];
          this.queryParams.triggerTimeEnd = this.queryParams.triggerTimeArr[1];
        }
        listLog(this.queryParams).then(response => {
          this.logList = response.data;
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
                    jobGroup: null,
                    jobId: null,
                    executorAddress: null,
                    executorHandler: null,
                    executorParam: null,
                    executorShardingParam: null,
                    executorFailRetryCount: null,
                    triggerTime: null,
                    triggerCode: null,
                    triggerMsg: null,
                    handleTime: null,
                    handleCode: null,
                    handleMsg: null,
                    alarmStatus: 0,
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
        this.queryParams.triggerTimeStart = "";
        this.queryParams.triggerTimeEnd = "";
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
        this.title = "添加定时任务日志";
      },
      /** 提交按钮 */
      submitForm() {
        this.$refs["form"].validate(valid => {
          if (valid) {
            if (this.form.id != null) {
              updateLog(this.form).then(response => {
                this.$modal.msgSuccess("修改成功");
                this.open = false;
                this.getList();
              });
            } else {
              addLog(this.form).then(response => {
                this.$modal.msgSuccess("新增成功");
                this.open = false;
                this.getList();
              });
            }
          }
        });
      },
      /** 删除按钮操作 */
      handleDelete() {
        this.clearForm.jobGroup = '';
        this.clearForm.jobId = '';
        this.showClearLogFlag = true;
      },
      /** 导出按钮操作 */
      handleExport() {
        this.download('job/log/export', {
            ...this.queryParams
        }, `定时任务日志_${parseTime(new Date().getTime(), '{y}-{m}-{d}') }.xlsx`)
      }
   }
  };
</script>
