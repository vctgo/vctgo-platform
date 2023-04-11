import request from '@/utils/request'

// 查询定时任务分组列表
export function listGroup(query) {
  return request({
    url: '/job/group/list',
    method: 'get',
    params: query
  })
}

// 查询定时任务分组详细
export function getGroup(id) {
  return request({
    url: '/job/group/' + id,
    method: 'get'
  })
}

// 新增定时任务分组
export function addGroup(data) {
  return request({
    url: '/job/group/add',
    method: 'post',
    data: data
  })
}

// 修改定时任务分组
export function updateGroup(data) {
  return request({
    url: '/job/group/edit',
    method: 'put',
    data: data
  })
}

// 删除定时任务分组
export function delGroup(id) {
  return request({
    url: '/job/group/' + id,
    method: 'delete'
  })
}

// 查询定时任务分组下拉列表
export function getSelectAll(query) {
  return request({
    url: '/job/group/getSelectAll',
    method: 'get',
    params: query
  })
}
