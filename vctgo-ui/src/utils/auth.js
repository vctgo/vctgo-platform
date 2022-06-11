import Cookies from 'js-cookie'

const TokenKey = 'Admin-Token'

const ExpiresInKey = 'Admin-Expires-In'

const TenantKey = 'Admin-Tenant'

export function getTenant() {
  return Cookies.get(TenantKey)
}

export function setTenant(tenantid) {
  return Cookies.set(TenantKey, tenantid)
}

export function removeTenant() {
  return Cookies.remove(TenantKey)
}
export function getToken() {
  return Cookies.get(TokenKey)
}

export function setToken(token) {
  return Cookies.set(TokenKey, token)
}

export function removeToken() {
  return Cookies.remove(TokenKey)
}

export function getExpiresIn() {
  return Cookies.get(ExpiresInKey) || -1
}

export function setExpiresIn(time) {
  return Cookies.set(ExpiresInKey, time)
}

export function removeExpiresIn() {
  return Cookies.remove(ExpiresInKey)
}
