import request from '@/utils/request'

// 查询任务列表
export function listInfo(query) {
  return request({
    url: '/job/info/list',
    method: 'get',
    params: query
  })
}

// 查询任务详细
export function getInfo(id) {
  return request({
    url: '/job/info/' + id,
    method: 'get'
  })
}

// 新增任务
export function addInfo(data) {
  return request({
    url: '/job/info/add',
    method: 'post',
    data: data
  })
}

// 修改任务
export function updateInfo(data) {
  return request({
    url: '/job/info',
    method: 'put',
    data: data
  })
}

// 删除任务
export function delInfo(id) {
  return request({
    url: '/job/info/' + id,
    method: 'delete'
  })
}

// 查询任务详细
export function trigger(data) {
  return request({
    url: '/job/info/trigger',
    method: 'post',
    data: data
  })
}

// 查询注册节点
export function viewRegisterNode(id) {
  return request({
    url: '/job/group/' + id,
    method: 'get'
  })
}

// 开启任务
export function start(id) {
  return request({
    url: '/job/info/start/' + id,
    method: 'get'
  })
}

// 停止任务
export function stop(id) {
  return request({
    url: '/job/info/stop/' + id,
    method: 'get'
  })
}

// 查看下次执行时间
export function nextTriggerTime(data) {
  return request({
    url: '/job/info/nextTriggerTime',
    method: 'post',
    data: data
  })
}
