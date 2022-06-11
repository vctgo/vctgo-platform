import request from '@/utils/request'

// 查询租户套餐列表
export function listTenantpackage(query) {
  return request({
    url: '/system/tenantpackage/list',
    method: 'get',
    params: query
  })
}

// 查询租户套餐详细
export function getTenantpackage(id) {
  return request({
    url: '/system/tenantpackage/' + id,
    method: 'get'
  })
}

// 新增租户套餐
export function addTenantpackage(data) {
  return request({
    url: '/system/tenantpackage',
    method: 'post',
    data: data
  })
}

// 修改租户套餐
export function updateTenantpackage(data) {
  return request({
    url: '/system/tenantpackage',
    method: 'put',
    data: data
  })
}

// 删除租户套餐
export function delTenantpackage(id) {
  return request({
    url: '/system/tenantpackage/' + id,
    method: 'delete'
  })
}

// 获取租户套餐精简信息列表
export function getTenantPackageList() {
  return request({
    url: '/system/tenantpackage/get-simple-list',
    method: 'get'
  })
}

