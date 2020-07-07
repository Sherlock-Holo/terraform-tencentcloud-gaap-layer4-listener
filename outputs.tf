output "proxy_id" {
  description = "The list of GAAP proxy ID."
  value       = compact(concat(tencentcloud_gaap_proxy.default.*.id, [var.proxy_id]))
}

output "policy_id" {
  description = "The list of GAAP proxy policy ID."
  value       = compact(concat(tencentcloud_gaap_security_policy.default.*.id, [var.policy_id]))
}

output "policy_rule_ids" {
  description = "The list of GAAP proxy policy rule ID."
  value       = compact(tencentcloud_gaap_security_rule.default.*.id)
}

output "listener_id" {
  description = "The GAAP layer4 listener ID."
  value       = tencentcloud_gaap_layer4_listener.default.id
}

output "realserver_ids" {
  description = "The list of GAAP realserver ID."
  value       = compact(concat(tencentcloud_gaap_realserver.default.*.id, [for res in var.realservers : lookup(res, "id", null)]))
}
