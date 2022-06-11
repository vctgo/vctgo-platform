import request from '@/utils/request'

// 查询缓存管理列表
export function listCache(query) {
  return request({
    url: '/monitor/cache/list',
    method: 'get',
    params: query
  })
}

// 查询缓存管理详细
export function getCache(id) {
  return request({
    url: '/monitor/cache/' + id,
    method: 'get'
  })
}

// 新增缓存管理
export function addCache(data) {
  return request({
    url: '/monitor/cache',
    method: 'post',
    data: data
  })
}

// 修改缓存管理
export function updateCache(data) {
  return request({
    url: '/monitor/cache',
    method: 'put',
    data: data
  })
}

// 删除缓存管理
export function delCache(id) {
  return request({
    url: '/monitor/cache/' + id,
    method: 'delete'
  })
}

// 测试连接
export function testLink(data) {
  return request({
    url: '/monitor/cache/testlink',
    method: 'post',
    data: data
  })
}
