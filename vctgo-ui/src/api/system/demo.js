import request from '@/utils/request'

// 查询测试列表
export function listDemo(query) {
  return request({
    url: '/system/demo/list',
    method: 'get',
    params: query
  })
}

// 查询测试详细
export function getDemo(demoId) {
  return request({
    url: '/system/demo/' + demoId,
    method: 'get'
  })
}

// 新增测试
export function addDemo(data) {
  return request({
    url: '/system/demo',
    method: 'post',
    data: data
  })
}

// 修改测试
export function updateDemo(data) {
  return request({
    url: '/system/demo',
    method: 'put',
    data: data
  })
}

// 删除测试
export function delDemo(demoId) {
  return request({
    url: '/system/demo/' + demoId,
    method: 'delete'
  })
}
