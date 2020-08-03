provider "tencentcloud" {
  region = "ap-guangzhou" // GAAP doesn't care region
}

resource "tencentcloud_gaap_proxy" "default" {
  count = var.proxy_id == "" ? 1 : 0

  access_region     = var.access_region
  bandwidth         = var.bandwidth
  concurrent        = var.concurrent
  name              = var.proxy_name
  realserver_region = var.realserver_region
  project_id        = var.project_id

  tags = var.tags
}

resource "tencentcloud_gaap_security_policy" "default" {
  count = var.policy_id == "" ? 1 : 0

  action   = var.policy_action
  proxy_id = var.proxy_id != "" ? var.proxy_id : tencentcloud_gaap_proxy.default[0].id
}

resource "tencentcloud_gaap_security_rule" "default" {
  count = length(var.policy_rules)

  action    = lookup(var.policy_rules[count.index], "action", null)
  cidr_ip   = lookup(var.policy_rules[count.index], "cidr_ip", null)
  policy_id = var.policy_id != "" ? var.policy_id : tencentcloud_gaap_security_policy.default[0].id
  name      = var.policy_rule_name
  port      = lookup(var.policy_rules[count.index], "port", "ALL")
  protocol  = lookup(var.policy_rules[count.index], "protocol", "ALL")
}

resource "tencentcloud_gaap_layer4_listener" "default" {
  proxy_id        = var.proxy_id != "" ? var.proxy_id : tencentcloud_gaap_proxy.default[0].id
  name            = var.proxy_name
  protocol        = var.protocol
  port            = var.port
  realserver_type = var.realserver_type
  connect_timeout = var.connect_timeout
  health_check    = var.health_check
  interval        = var.health_check_interval
  scheduler       = var.scheduler

  dynamic "realserver_bind_set" {
    for_each = var.realservers
    content {
      id     = var.create_realserver ? tencentcloud_gaap_realserver.default[index(var.realservers, realserver_bind_set.value)].id : lookup(realserver_bind_set.value, "id", "")
      ip     = var.realserver_type == "IP" ? lookup(realserver_bind_set.value, "ip", "") : lookup(realserver_bind_set.value, "domain", "")
      port   = lookup(realserver_bind_set.value, "port", 0)
      weight = lookup(realserver_bind_set.value, "weight", 1)
    }
  }
}

resource "tencentcloud_gaap_realserver" "default" {
  count = var.create_realserver && length(var.realservers) > 0 ? length(var.realservers) : 0

  project_id = var.project_id
  name       = var.realserver_name
  ip         = var.realserver_type == "IP" ? lookup(var.realservers[count.index], "ip", null) : null
  domain     = var.realserver_type == "DOMAIN" ? lookup(var.realservers[count.index], "domain", null) : null
  tags       = var.tags
}
