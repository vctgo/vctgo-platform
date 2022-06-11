import request from '@/utils/request'

// 查询服务器管理列表
export function listSys(query) {
  return request({
    url: '/monitor/sys/list',
    method: 'get',
    params: query
  })
}

// 查询服务器管理详细
export function getSys(id) {
  return request({
    url: '/monitor/sys/' + id,
    method: 'get'
  })
}

// 新增服务器管理
export function addSys(data) {
  return request({
    url: '/monitor/sys',
    method: 'post',
    data: data
  })
}

// 修改服务器管理
export function updateSys(data) {
  return request({
    url: '/monitor/sys',
    method: 'put',
    data: data
  })
}

// 删除服务器管理
export function delSys(id) {
  return request({
    url: '/monitor/sys/' + id,
    method: 'delete'
  })
}

// 测试连接
export function testLink(data) {
  return request({
    url: '/monitor/sys/testlink',
    method: 'post',
    data: data
  })
}
