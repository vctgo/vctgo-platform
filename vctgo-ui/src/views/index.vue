<template>
  <div class="app-container home">
    <el-row :gutter="20">
      <el-col :sm="24" :lg="24">
          <p style="text-align: center;">
            <img src="https://img.shields.io/badge/Release-V1.1.0-green.svg" alt="Downloads"/>
            <img src="https://img.shields.io/badge/JDK-1.8+-green.svg" alt="Build Status"/>
            <img src="https://img.shields.io/badge/Spring%20Cloud-2021-blue.svg" alt="Coverage Status"/>
            <img src="https://img.shields.io/badge/Spring%20Boot-2.6.6.RELEASE-blue.svg" alt="Downloads"/>
            <a target="_blank" href="https://www.vctgo.cn">
              <img src="https://img.shields.io/badge/Copyright%20-@vctgo-%23ff3f59.svg" alt="Downloads"/>
            </a>
          </p>
        <hr />
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :sm="24" :lg="12" style="padding-left: 20px">
        <h2>菜盟快速开发平台</h2>
        <p>
          基于Ruoyi-Cloud版本改进而来,吸收了其他项目类似于pig,spring blade,ruo-vue-pro,xueyi-vue等等优秀的开源架构,目标做出一套属于菜盟内部的快速开发平台,集成租户,低代码,监控,分布式,限流,容器化编排等多种功能集成的企业级开发平台!期待大家的加入,一起开发!后续会出一个开源的版本放到gitee上,到时候欢迎大家一起pr!
        </p>
        <p>
          <b>当前版本:</b>
          <el-tag type="danger">v{{ version }}</el-tag>
        </p>
<!--        <p>-->
<!--          <el-tag type="danger">&yen;免费开源</el-tag>-->
<!--        </p>-->
        <p>
          <el-button
            type="primary"
            size="mini"
            icon="el-icon-cloudy"
            plain
            @click="goTarget('https://gitee.com/dhr92/')"
          >访问码云</el-button
          >
          <el-button
            size="mini"
            icon="el-icon-s-home"
            plain
            @click="goTarget('https://www.vctgo.cn')"
          >访问主页</el-button
          >
        </p>
      </el-col>

      <el-col :sm="24" :lg="12" style="padding-left: 50px">
        <el-row>
          <el-col :span="12">
            <h2>技术选型</h2>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="6">
            <h4>后端技术</h4>
            <ul>
              <li>SpringBoot</li>
              <li>SpringCloud</li>
              <li>Nacos</li>
              <li>Sentinel</li>
              <li>Seata</li>
              <li>Minio</li>
              <li>...</li>
            </ul>
          </el-col>
          <el-col :span="6">
            <h4>前端技术</h4>
            <ul>
              <li>Vue</li>
              <li>Vuex</li>
              <li>Element-ui</li>
              <li>Axios</li>
              <li>Echarts</li>
              <li>Quill</li>
              <li>...</li>
            </ul>
          </el-col>
        </el-row>
      </el-col>
    </el-row>
    <el-divider />
  </div>
</template>

<script>
export default {
  name: "Index",
  data() {
    return {
      // 版本号
      version: "1.1.0",
    };
  },
  methods: {
    goTarget(href) {
      window.open(href, "_blank");
    },
  },
};
</script>

<style scoped lang="scss">
.home {
  blockquote {
    padding: 10px 20px;
    margin: 0 0 20px;
    font-size: 17.5px;
    border-left: 5px solid #eee;
  }
  hr {
    margin-top: 20px;
    margin-bottom: 20px;
    border: 0;
    border-top: 1px solid #eee;
  }
  .col-item {
    margin-bottom: 20px;
  }

  ul {
    padding: 0;
    margin: 0;
  }

  font-family: "open sans", "Helvetica Neue", Helvetica, Arial, sans-serif;
  font-size: 13px;
  color: #676a6c;
  overflow-x: hidden;

  ul {
    list-style-type: none;
  }

  h4 {
    margin-top: 0px;
  }

  h2 {
    margin-top: 10px;
    font-size: 26px;
    font-weight: 100;
  }

  p {
    margin-top: 10px;

    b {
      font-weight: 700;
    }
  }

  .update-log {
    ol {
      display: block;
      list-style-type: decimal;
      margin-block-start: 1em;
      margin-block-end: 1em;
      margin-inline-start: 0;
      margin-inline-end: 0;
      padding-inline-start: 40px;
    }
  }
}
</style>

