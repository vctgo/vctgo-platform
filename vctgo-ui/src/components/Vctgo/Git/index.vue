<template>
  <div>
    <svg-icon icon-class="github" @click="goto" />
  </div>
</template>

<script>
export default {
  name: 'VctgoGit',
  data() {
    return {
      url: 'https://gitee.com/vctgo/vctgo-platform'
    }
  },
  methods: {
    goto() {
      window.open(this.url)
    }
  }
}
</script>
