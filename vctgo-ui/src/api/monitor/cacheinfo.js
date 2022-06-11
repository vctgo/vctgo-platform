import request from '@/utils/request'

// 查询缓存详细
export function getCache(query) {
  return request({
    url: '/monitor/cache/info',
    method: 'get',
    params: query
  })
}
