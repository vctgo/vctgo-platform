<template>
  <el-row :gutter="40" class="panel-group">
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" >
        <div class="card-panel-icon-wrapper icon-people">
          <svg-icon icon-class="peoples" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            当前在线
          </div>
          <animate-number
            from="0"
            :to="onlineCount"
            duration="1000"
            from-color="#44CC00"
            to-color="#666"
            :key="onlineCount"
            style="font-size:20px;text-align:center;display:block;"></animate-number>
        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" >
        <div class="card-panel-icon-wrapper icon-register">
          <svg-icon icon-class="logininfor" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            注册用户
          </div>
          <animate-number
            from="0"
            :to="registerCount"
            duration="1000"
            from-color="#44CC00"
            to-color="#666"
            :key="registerCount"
            style="font-size:20px;text-align:center;display:block;"></animate-number>        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel" >
        <div class="card-panel-icon-wrapper icon-tree">
          <svg-icon icon-class="tree" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            租户入驻
          </div>
          <animate-number
            from="0"
            :to="tenantCount"
            duration="1000"
            from-color="#44CC00"
            to-color="#666"
            :key="tenantCount"
            style="font-size:20px;text-align:center;display:block;"></animate-number>        </div>
      </div>
    </el-col>
    <el-col :xs="12" :sm="12" :lg="6" class="card-panel-col">
      <div class="card-panel">
        <div class="card-panel-icon-wrapper icon-chart">
          <svg-icon icon-class="chart" class-name="card-panel-icon" />
        </div>
        <div class="card-panel-description">
          <div class="card-panel-text">
            累积访问
          </div>
          <animate-number
            from="0"
            :to="loginCount"
            duration="1000"
            from-color="#44CC00"
            to-color="#666"
            :key="loginCount"
            style="font-size:20px;text-align:center;display:block;"></animate-number>        </div>
      </div>
    </el-col>
  </el-row>
</template>

<script>
import {getLoginInfoList} from "@/api/system/logininfor";

export default {
  data() {
    return {
      //统计信息
      loginCount: "0",
      onlineCount: "0",
      registerCount: "0",
      tenantCount: "0"
    };
  },
  created() {
    this.getLoginInfo();
  },
  methods: {
    /** 获取登陆信息,后续考虑加速自动刷新 */
    getLoginInfo() {
      getLoginInfoList().then(response => {
        this.loginCount = response.data.loginCount;
        this.onlineCount = response.data.onlineCount;
        this.registerCount = response.data.registerCount;
        this.tenantCount = response.data.tenantCount;
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.panel-group {
  margin-top: 18px;

  .card-panel-col {
    margin-bottom: 32px;
  }

  .card-panel {
    height: 108px;
    cursor: pointer;
    font-size: 12px;
    position: relative;
    overflow: hidden;
    color: #666;
    background: #fff;
    box-shadow: 4px 4px 40px rgba(0, 0, 0, .05);
    border-color: rgba(0, 0, 0, .05);

    &:hover {
      .card-panel-icon-wrapper {
        color: #fff;
      }

      .icon-people {
        background: #40c9c6;
      }

      .icon-register {
        background: #36a3f7;
      }

      .icon-chart {
        background: #f4516c;
      }

      .icon-tree {
        color: #34bfa3
      }
    }

    .icon-people {
      color: #40c9c6;
    }

    .icon-register {
      color: #36a3f7;
    }

    .icon-chart {
      color: #f4516c;
    }

    .icon-tree {
      color: #34bfa3
    }

    .card-panel-icon-wrapper {
      float: left;
      margin: 14px 0 0 14px;
      padding: 16px;
      transition: all 0.38s ease-out;
      border-radius: 6px;
    }

    .card-panel-icon {
      float: left;
      font-size: 48px;
    }

    .card-panel-description {
      float: right;
      font-weight: bold;
      margin: 26px;
      margin-left: 0px;

      .card-panel-text {
        line-height: 18px;
        color: rgba(0, 0, 0, 0.45);
        font-size: 16px;
        margin-bottom: 12px;
      }

      .card-panel-num {
        font-size: 20px;
      }
    }
  }
}

@media (max-width:550px) {
  .card-panel-description {
    display: none;
  }

  .card-panel-icon-wrapper {
    float: none !important;
    width: 100%;
    height: 100%;
    margin: 0 !important;

    .svg-icon {
      display: block;
      margin: 14px auto !important;
      float: none !important;
    }
  }
}
</style>
