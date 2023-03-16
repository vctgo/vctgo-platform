import request from '@/utils/request'

// 查询定时任务日志列表
export function listLog(query) {
  return request({
    url: '/job/log/list',
    method: 'get',
    params: query
  })
}

// 查询定时任务日志详细
export function getLog(id) {
  return request({
    url: '/job/log/' + id,
    method: 'get'
  })
}

// 新增定时任务日志
export function addLog(data) {
  return request({
    url: '/job/log',
    method: 'post',
    data: data
  })
}

// 修改定时任务日志
export function updateLog(data) {
  return request({
    url: '/job/log',
    method: 'put',
    data: data
  })
}

// 删除定时任务日志
export function delLog(id) {
  return request({
    url: '/job/log/' + id,
    method: 'delete'
  })
}

// 查询定时任务日志详细
export function logDetailCat(data) {
  return request({
    url: '/job/log/logDetailCat',
    method: 'post',
    data: data
  })
}

export function clearLog(data) {
  return request({
    url: '/job/log/clearLog',
    method: 'post',
    data: data
  })
}
