output "proxy_id" {
  description = "The list of GAAP proxy ID."
  value       = module.simple-layer4.proxy_id
}

output "policy_id" {
  description = "The list of GAAP proxy policy ID."
  value       = module.simple-layer4.policy_id
}

output "policy_rule_ids" {
  description = "The list of GAAP proxy policy rule ID."
  value       = module.simple-layer4.policy_rule_ids
}

output "listener_id" {
  description = "The GAAP layer4 listener ID."
  value       = module.simple-layer4.listener_id
}

output "realserver_ids" {
  description = "The list of GAAP realserver ID."
  value       = module.simple-layer4.realserver_ids
}
