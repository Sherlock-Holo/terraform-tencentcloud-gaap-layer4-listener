variable "tags" {
  description = "A map of tags to add to GAAP proxy."
  type        = map(string)
  default     = {}
}

variable "proxy_id" {
  description = "The GAAP proxy ID use to launch resources."
  default     = ""
}

variable "proxy_name" {
  description = "The proxy name used to launch a new proxy when `proxy_id` is not specified."
  default     = "tf-modules-proxy"
}

variable "access_region" {
  description = "The proxy access region used to launch a new proxy when `proxy_id` is not specified."
  default     = ""
}

variable "realserver_region" {
  description = "The proxy realserver region used to launch a new proxy when `proxy_id` is not specified."
  default     = ""
}

variable "bandwidth" {
  description = "The proxy bandwidth used to launch a new proxy when `proxy_id` is not specified."
  type        = number
  default     = null
}

variable "concurrent" {
  description = "The proxy concurrent used to launch a new proxy when `proxy_id` is not specified."
  type        = number
  default     = null
}

variable "project_id" {
  description = "The proxy project ID used to launch a new proxy when `proxy_id` is not specified."
  type        = number
  default     = 0
}

variable "policy_id" {
  description = "The GAAP proxy security policy ID use to launch resources."
  default     = ""
}

variable "policy_action" {
  description = "Specify action of the GAAP proxy security policy to launch resources when `policy_id` is not specified, available values: `ACCEPT` and `DROP`."
  default     = "ACCEPT"
}

variable "policy_rule_name" {
  description = "Specify the GAAP proxy security policy rule name to launch resources."
  default     = "tf-modules-policy-rule"
}

variable "policy_rules" {
  description = "Specify the GAAP proxy security policy rule config, each map contains `action`, `cidr_ip`, `port` and `protocol`. If `port` omitted, will use default value `ALL`; if `protocol` is omitted, will use default value `ALL`."
  type        = list(map(string))
  default     = []
}

variable "protocol" {
  description = "The GAAP layer4 listener protocol used to launch a new layer4 listener, available values: `TCP` and `UDP`."
  type        = string
}

variable "listener_name" {
  description = "The GAAP layer4 listener name used to launch a new layer4 listener."
  default     = "tf-module-layer4-listener"
}

variable "port" {
  description = "The GAAP layer4 listener port used to launch a new layer4 listener."
  type        = number
}

variable "realserver_type" {
  description = "The GAAP layer4 listener realserver type used to launch a new layer4 listener, available values: `IP` and `DOMAIN`."
  type        = string
}

variable "connect_timeout" {
  description = "The GAAP layer4 listener connect timeout used to launch a new layer4 listener."
  type        = number
  default     = null
}

variable "health_check" {
  description = "Enable the GAAP layer4 listener health check or not used to launch a new layer4 listener."
  default     = false
}

variable "health_check_interval" {
  description = "The GAAP layer4 listener health check interval used to launch a new layer4 listener."
  type        = number
  default     = null
}

variable "scheduler" {
  description = "The GAAP layer4 listener scheduler used to launch a new layer4 listener, available values: `rr`, `wrr` and `lc`."
  type        = string
  default     = "rr"
}

variable "create_realserver" {
  description = "Specify create new realservers with specified config in `realservers` or not."
  default     = false
}

variable "realserver_name" {
  description = "Specify the realserver name when `create_realserver` is `true`."
  default     = "tf-module-realserver"
}

variable "realservers" {
  description = "The list of GAAP layer4 listener binding realserver config, each map contains `id`, `ip`, `domain` and `port`. If not specify `weight`, will use default value `1`; If `create_realserver` is `true`, `id` will be ignored."
  type        = list(map(string))
  default     = []
}
