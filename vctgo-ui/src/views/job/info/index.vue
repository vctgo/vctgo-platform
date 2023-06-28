<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="85px">
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
                  <el-form-item label="运行状态" prop="triggerStatus">
                    <el-select v-model="queryParams.triggerStatus" placeholder="请选择">
                      <el-option
                        v-for="item in dict.type.sys_job_trigger_status"
                        :key="item.value"
                        :label="item.label"
                        :value="item.value">
                      </el-option>
                    </el-select>
                  </el-form-item>
                  <el-form-item label="任务描述" prop="jobDesc">
                    <el-input
                        v-model="queryParams.jobDesc"
                        placeholder="请输入任务描述"
                        clearable
                        @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="JobHandler" prop="executorHandler">
                    <el-input
                      v-model="queryParams.executorHandler"
                      placeholder="请输入JobHandler"
                      clearable
                      @keyup.enter.native="handleQuery"
                    />
                  </el-form-item>
                  <el-form-item label="负责人" prop="author">
                    <el-input
                      v-model="queryParams.author"
                      placeholder="请输入负责人"
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
            v-hasPermi="['job:info:add']"
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
            type="danger"
            plain
            icon="el-icon-delete"
            size="mini"
            :disabled="multiple"
            @click="handleDelete"
            v-hasPermi="['job:info:remove']"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="infoList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
              <el-table-column label="任务ID" align="center" prop="jobGroup" />
              <el-table-column label="任务描述" align="center" prop="jobDesc" />
              <el-table-column label="调度类型" align="center" >
                <template v-slot:="scope">
                  {{ scope.row.scheduleType + '：' + scope.row.scheduleConf }}
                </template>
              </el-table-column>
              <el-table-column label="运行模式" align="center" >
                <template v-slot:="scope">
                  {{ scope.row.glueType + '：' + scope.row.executorHandler }}
                </template>
              </el-table-column>
              <el-table-column label="负责人" align="center" prop="author" />
              <el-table-column label="状态" align="center" prop="triggerStatus" >
                <template slot-scope="scope">
                  <dict-tag :options="dict.type.sys_job_trigger_status" :value="scope.row.triggerStatus"/>
                </template>
              </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template v-slot:="scope">
          <el-button
              size="mini"
              type="text"
              icon="el-icon-caret-right"
              @click="executeOnce(scope.row)"
              v-hasPermi="['job:info:trigger']"
          >执行一次</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['job:info:edit']"
          >修改</el-button>
<!--          <el-button-->
<!--            size="mini"-->
<!--            type="text"-->
<!--            @click="viewRegisterNode(scope.row)"-->
<!--          >注册节点</el-button>-->
          <el-button
            v-if="scope.row.triggerStatus === 0"
            size="mini"
            type="text"
            icon="el-icon-video-play"
            @click="start(scope.row)"
            v-hasPermi="['job:info:start']"
          >开启</el-button>
          <el-button
            v-if="scope.row.triggerStatus === 1"
            size="mini"
            type="text"
            icon="el-icon-video-pause"
            @click="stop(scope.row)"
            v-hasPermi="['job:info:stop']"
          >停止</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-document-copy"
            @click="copy(scope.row)"
            v-hasPermi="['job:info:copy']"
          >复制</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-view"
            @click="viewNextTriggerTime(scope.row)"
            v-hasPermi="['job:info:nextTriggerTime']"
          >查看下次执行时间</el-button>
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

    <!-- 添加或修改任务对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="1000px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="120px">
        <p class="form-left-title">基础配置</p>
        <el-row>
          <el-col :span="12">
            <el-form-item label="执行器" prop="jobGroup">
              <el-select v-model="form.jobGroup" placeholder="请选择">
                <el-option
                  v-for="item in jobGroupOptions"
                  :key="item.id"
                  :label="item.title"
                  :value="item.id">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="任务描述" prop="jobDesc">
              <el-input v-model="form.jobDesc" placeholder="请输入任务描述" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="负责人" prop="author">
              <el-input v-model="form.author" placeholder="请输入负责人姓名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="报警邮件" prop="alarmEmail">
              <el-input v-model="form.alarmEmail" placeholder="请输入报警邮件地址，多个邮件则逗号分开" />
            </el-form-item>
          </el-col>
        </el-row>
        <p class="form-left-title">调度配置</p>
        <el-row>
          <el-col :span="12">
            <el-form-item label="调度类型" prop="scheduleType">
              <el-select v-model="form.scheduleType" placeholder="请选择">
                <el-option
                  v-for="item in dict.type.sys_job_schedule_type"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="Cron" prop="scheduleConf" v-if="form.scheduleType === 'CRON'">
<!--              <el-input v-model="form.scheduleConf" placeholder="cron表达式" />-->
              <el-popover v-model="cronPopover">
                <cron @change="changeCron" @close="cronPopover=false" i18n="cn"></cron>
                <el-input slot="reference" @click="cronPopover=true" v-model="form.scheduleConf" placeholder="请输入定时策略"></el-input>
              </el-popover>
            </el-form-item>
          </el-col>
        </el-row>
        <p class="form-left-title">任务配置</p>
        <el-row>
          <el-col :span="12">
            <el-form-item label="运行模式" prop="glueType">
              <el-select v-model="form.glueType" placeholder="请选择">
                <el-option
                  v-for="item in dict.type.sys_job_glue_type"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="JobHandler" prop="executorHandler">
              <el-input :disabled="form.glueType !== 'BEAN'" v-model="form.executorHandler" placeholder="请输入JobHandler" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="24">
            <el-form-item label="任务参数">
              <el-input type="textarea" v-model="form.executorParam"></el-input>
            </el-form-item>
          </el-col>
        </el-row>
        <p class="form-left-title">高级配置</p>
        <el-row>
          <el-col :span="12">
            <el-form-item label="路由策略" prop="executorRouteStrategy">
              <el-select v-model="form.executorRouteStrategy" placeholder="请选择">
                <el-option
                  v-for="item in dict.type.sys_job_executor_route_strategy"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="子任务ID" prop="childJobId">
              <el-input v-model="form.childJobId" placeholder="请输入子任务ID" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="调度过期策略" prop="misfireStrategy">
              <el-select v-model="form.misfireStrategy" placeholder="请选择">
                <el-option
                  v-for="item in dict.type.sys_job_misfire_strategy"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="阻塞处理策略" prop="executorBlockStrategy">
              <el-select v-model="form.executorBlockStrategy" placeholder="请选择">
                <el-option
                  v-for="item in dict.type.sys_job_executor_block_strategy"
                  :key="item.value"
                  :label="item.label"
                  :value="item.value">
                </el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="任务超时时间" prop="executorTimeout">
              <el-input v-model="form.executorTimeout" placeholder="任务超时时间，单位秒，大于零时生效" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="失败重试次数" prop="executorFailRetryCount">
              <el-input v-model="form.executorFailRetryCount" placeholder="失败重试次数，大于零时生效" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>

    <!-- 执行一次添加参数弹框 -->
    <el-dialog :title="executeOnceTitle" :visible.sync="executeOnceOpen" width="500px" append-to-body>
      <el-form ref="form" :model="executeOnceForm" :rules="executeOnceRules" label-width="80px">
        <el-form-item label="任务参数" prop="executorParam">
          <el-input v-model="executeOnceForm.executorParam" placeholder="请输入任务参数" />
        </el-form-item>
        <el-form-item label="机器地址" prop="jobDesc">
          <el-input v-model="executeOnceForm.jobDesc" placeholder="请输入本次执行的机器地址，为空则从执行器获取" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="executeOnceSubmitForm">确 定</el-button>
        <el-button @click="executeOnceCancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
  import { listInfo, getInfo, delInfo, addInfo, updateInfo, trigger, viewRegisterNode, start, stop, nextTriggerTime } from "@/api/job/info";
  import { getSelectAll } from "@/api/job/group";
  import { parseTime } from "@/utils/vctgo";
  import {cron} from 'vue-cron';

  export default {
    name: "Info",
    components: { cron },
    dicts: [
      'sys_job_trigger_status',
      'sys_job_schedule_type',
      'sys_job_glue_type',
      'sys_job_executor_route_strategy',
      'sys_job_misfire_strategy',
      'sys_job_executor_block_strategy'
    ],
    data() {
      return {
        cronPopover:false,
        // 执行器选择
        jobGroupOptions: [],
        // 选中的item
        currItem: {},
        // 执行一次 弹框表单 校验
        executeOnceRules: {
          executorParam: [],
          jobDesc: [],
        },
        // 执行一次 弹框表单
        executeOnceForm: {
          executorParam: null,
          jobDesc: null
        },
        // 执行一次标题
        executeOnceTitle: '执行一次',
        // 是否显示弹出层 执行一次弹框
        executeOnceOpen: false,
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
        // 任务表格数据
        infoList: [],
        // 弹出层标题
        title: "",
        // 是否显示弹出层
        open: false,
        // 查询参数
        queryParams: {
          pageNum: 1,
          pageSize: 10,
                        jobGroup: null,
                        jobDesc: null,
                        addTime: null,
                        author: null,
                        alarmEmail: null,
                        scheduleType: null,
                        scheduleConf: null,
                        misfireStrategy: null,
                        executorRouteStrategy: null,
                        executorHandler: null,
                        executorParam: null,
                        executorBlockStrategy: null,
                        executorTimeout: null,
                        executorFailRetryCount: null,
                        glueType: null,
                        glueSource: null,
                        glueRemark: null,
                        glueUpdatetime: null,
                        childJobid: null,
                        triggerStatus: null,
                        triggerLastTime: null,
                        triggerNextTime: null,
                        tenantId: null
        },
        // 表单参数
        form: {
          jobGroup: null
        },
        // 表单校验
        rules: {
          jobGroup: [
            { required: true, message: "请选择执行器", trigger: "blur" }
          ],
          jobDesc: [
            { required: true, message: "任务描述必填", trigger: "blur" }
          ],
          author: [
            { required: true, message: "负责人必填", trigger: "blur" }
          ],
          alarmEmail: [
            { required: true, message: "报警邮件必填", trigger: "blur" }
          ],
          scheduleType: [
            { required: true, message: "请选择调度类型", trigger: "blur" }
          ],
          scheduleConf: [
            { required: true, message: "调度配置必填", trigger: "blur" }
          ],
          glueType: [
            { required: true, message: "请选择运行模式", trigger: "blur" }
          ],
          executorHandler: [
            { required: true, message: "执行器任务handler必填", trigger: "blur" }
          ],
          executorRouteStrategy: [
            { required: true, message: "请选择路由策略", trigger: "blur" }
          ],
          misfireStrategy: [
            { required: true, message: "请选择调度过期策略", trigger: "blur" }
          ],
          executorBlockStrategy: [
            { required: true, message: "请选择阻塞处理策略", trigger: "blur" }
          ],
          executorTimeout: [
            { required: true, message: "任务超时时间必填", trigger: "blur" }
          ],
          executorFailRetryCount: [
            { required: true, message: "失败重试次数必填", trigger: "blur" }
          ]
        }
      };
    },
    created() {
      this.getList();
      this.initPageDicData();
    },
    methods: {
      changeCron(val){
        this.form.scheduleConf=val
      },
      // 复制
      copy(row) {
        this.reset();
        const id = row.id || this.ids
        getInfo(id).then(response => {
          this.form = response.data;
          this.form.id = null;
          this.open = true;
          this.title = "新增";
        });
      },
      /** 初始化当前页面的一些字典值 */
      initPageDicData() {
        this.jobGroupOptions = [];
        getSelectAll({title: ''}).then(response => {
          this.jobGroupOptions = response.data;
        });
      },
      /** 查看下次执行时间 */
      viewNextTriggerTime(row) {
        nextTriggerTime({
          scheduleType: row.scheduleType,
          scheduleConf: row.scheduleConf
        }).then(response => {
          console.log('查看下次执行时间', response)
          if (response.code === 200) {
            this.$modal.msg('下次执行时间：\n' + response.data)
          } else {
            this.$modal.msgError(response.data)
          }
        })
      },
      /** 停止 */
      stop(row) {
        const id = row.id;
        stop(id).then(response => {
          console.log('停止', response)
          this.$modal.msgSuccess("操作成功");
          this.handleQuery();
        });
      },
      /** 开启 */
      start(row) {
        const id = row.id;
        start(id).then(response => {
          this.$modal.msgSuccess("操作成功");
          console.log('开启', response)
          this.handleQuery();
        });
      },
      /** 注册节点 */
      viewRegisterNode(row) {
        const id = row.id;
        viewRegisterNode(id).then(response => {
          console.log('注册节点', response)
        });
      },
      /** 执行一次 弹框关闭 */
      executeOnceCancel() {
        console.log('弹框关闭')
        this.executeOnceOpen = false;
      },
      /** 执行一次 弹框提交 */
      executeOnceSubmitForm() {
        console.log('弹框提交')
        let params = {
          id: this.currItem.id,
          executorParam: '',
          executorAddress: ''
        }
        trigger(params).then(response => {
          this.$modal.msgSuccess("执行成功");
          this.executeOnceOpen = false;
        })
      },
      /** 执行一次 */
      executeOnce(row) {
        console.log('执行一次', row)
        this.currItem = row;
        this.executeOnceOpen = true;
      },
      /** 查询日志 */
      viewLog(row) {
        console.log('查询日志', row)
        this.$store.dispatch('log')
      },
      /** 查询任务列表 */
      getList() {
        this.loading = true;
        listInfo(this.queryParams).then(response => {
          this.infoList = response.data;
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
          jobDesc: null,
          addTime: null,
          updateTime: null,
          author: null,
          alarmEmail: null,
          scheduleType: null,
          scheduleConf: null,
          misfireStrategy: null,
          executorRouteStrategy: null,
          executorHandler: null,
          executorParam: null,
          executorBlockStrategy: null,
          executorTimeout: null,
          executorFailRetryCount: null,
          glueType: null,
          glueSource: null,
          glueRemark: null,
          glueUpdatetime: null,
          childJobid: null,
          triggerStatus: 0,
          triggerLastTime: null,
          triggerNextTime: null,
          tenantId: null
        };
        this.resetForm("form");
      },
      resetExecuteOnceForm(){
        this.executeOnceForm = {
          jobGroup: null,
          jobDesc: null
        }
        this.resetForm("queryForm");
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
        this.title = "新增";
      },
      /** 修改按钮操作 */
      handleUpdate(row) {
        this.reset();
        const id = row.id || this.ids
        getInfo(id).then(response => {
          this.form = response.data;
          this.open = true;
          this.title = "修改任务";
        });
      },
      /** 提交按钮 */
      submitForm() {
        let that = this;
        that.$refs["form"].validate(valid => {
          if (valid) {
            if (that.form.id != null) {
              updateInfo(this.form).then(response => {
                that.$modal.msgSuccess("修改成功");
                that.open = false;
                that.getList();
              });
            } else {
              addInfo(that.form).then(response => {
                that.$modal.msgSuccess("新增成功");
                that.open = false;
                that.getList();
              });
            }
          }
        });
      },
      /** 删除按钮操作 */
      handleDelete(row) {
        const ids = row.id || this.ids;
        this.$modal.confirm('是否确认删除当前任务数据项？').then(function() {
          return delInfo(ids);
        }).then(() => {
          this.getList();
          this.$modal.msgSuccess("删除成功");
        }).catch(() => {});
      },
      /** 导出按钮操作 */
      handleExport() {
        this.download('job/info/export', {
            ...this.queryParams
        }, `任务_${parseTime(new Date().getTime(), '{y}-{m}-{d}') }.xlsx`)
      }
   }
  };
</script>

<style>
  .form-left-title {
    margin: 0 0 10px;
    text-align: left;
    border-bottom: 1px solid #e5e5e5;
    color: gray;
  }
</style>
