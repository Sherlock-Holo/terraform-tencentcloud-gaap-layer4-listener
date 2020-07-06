# TencentCloud GAAP layer4 listener Module for Terraform

## terraform-tencentcloud-gaap-layer4-listener

A terraform module used to create TencentCloud GAAP layer4 resources.

The following resources are supported.

* [GAAP proxy](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_proxy.html)
* [GAAP security policy](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_security_policy.html)
* [GAAP security policy rule](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_security_rule.html)
* [GAAP realserver](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_realserver.html)
* [GAAP layer4 listener](https://www.terraform.io/docs/providers/tencentcloud/r/gaap_layer4_listener.html)

## Usage

```hcl
module "simple-layer4" {
  source = "terraform-tencentcloud-modules/gaap-layer4-listener/tencentcloud"

  tags = {
    "test" = "test"
  }

  access_region     = "NorthChina"
  realserver_region = "EastChina"
  bandwidth         = 10
  concurrent        = 2

  listener_name   = "simple-TCP-listener"
  protocol        = "TCP"
  port            = 80
  realserver_type = "IP"

  scheduler = "wrr"

  realservers = [
    {
      id     = tencentcloud_gaap_realserver.rs1.id
      ip     = tencentcloud_gaap_realserver.rs1.ip
      port   = 80
      weight = 10
    },
    {
      id     = tencentcloud_gaap_realserver.rs2.id
      ip     = tencentcloud_gaap_realserver.rs2.ip
      port   = 80
      weight = 15
    }
  ]

  policy_rules = [
    {
      action  = "ACCEPT"
      cidr_ip = "192.168.0.0/16"
    }
  ]
}

resource "tencentcloud_gaap_realserver" "rs1" {
  ip   = "2.3.3.3"
  name = "tf-module-realserver"
}

resource "tencentcloud_gaap_realserver" "rs2" {
  ip   = "6.6.6.6"
  name = "tf-module-realserver"
}
```

## Conditional Creation

This module can create GAAP proxy and GAAP layer4 listener. It is possible to use existing GAAP proxy when specify `proxy_id` parameter.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| proxy_id | The GAAP proxy ID use to launch resources. | string | "" | no
| tags | A map of tags to add to all resources. | map(string) | {} | no
| proxy_name | The proxy name used to launch a new proxy when `proxy_id` is not specified. | string | tf-modules-proxy | no
| access_region | The proxy access region used to launch a new proxy when `proxy_id` is not specified. | string | "" | no
| realserver_region | The proxy realserver region used to launch a new proxy when `proxy_id` is not specified. | string | "" | no
| bandwidth | The proxy bandwidth used to launch a new proxy when `proxy_id` is not specified. | integer | null | no
| concurrent | The proxy concurrent used to launch a new proxy when `proxy_id` is not specified. | integer | null | no
| project_id | The proxy project ID used to launch a new proxy when `proxy_id` is not specified. | integer | 0 | no
| policy_id | The GAAP proxy security policy ID use to launch resources. | string | "" | no
| policy_action | Specify action of the GAAP proxy security policy to launch resources when `policy_id` is not specified, available values: `ACCEPT` and `DROP`. | string | "ACCEPT" | no
| policy_rule_name | Specify the GAAP proxy security policy rule name to launch resources. | string | "tf-modules-policy-rule" | no
| policy_rules | Specify the GAAP proxy security policy rule config, each map contains `action`, `cidr_ip`, `port` and `protocol`. If `port` omitted, will use default value `ALL`; if `protocol` is omitted, will use default value `ALL`. | list(map(string)) | [] | no
| protocol | The GAAP layer4 listener protocol used to launch a new layer4 listener, available values: `TCP` and `UDP`. | string | "" | yes
| listener_name | The GAAP layer4 listener name used to launch a new layer4 listener. | string | "tf-module-layer4-listener" | no
| port | The GAAP layer4 listener port used to launch a new layer4 listener. | integer | null | yes
| realserver_type | The GAAP layer4 listener realserver type used to launch a new layer4 listener, available values: `IP` and `DOMAIN`. | string | "" | no
| connect_timeout | The GAAP layer4 listener connect timeout used to launch a new layer4 listener. | integer | null | no
| health_check | Enable the GAAP layer4 listener health check or not used to launch a new layer4 listener. | bool | false | no
| health_check_interval | The GAAP layer4 listener health check interval used to launch a new layer4 listener. | integer | null | no
| scheduler | The GAAP layer4 listener scheduler used to launch a new layer4 listener, available values: `rr`, `wrr` and `lc`. | string | "rr" | no
| create_realserver | Specify create new realservers with specified config in `realservers` or not. | bool | false | no
| realserver_name | Specify the realserver name when `create_realserver` is `true`. | string | "tf-module-realserver" | no
| realservers | The list of GAAP layer4 listener binding realserver config, each map contains `id`, `ip`, `domain` and `port`. If not specify `weight`, will use default value `1`; If `create_realserver` is `true`, `id` will be ignored. | list(map(string)) | [] | no

## Outputs

| Name | Description |
|------|-------------|
| proxy_id | The list of GAAP proxy ID. |
| policy_id | The list of GAAP proxy policy ID. |
| policy_rule_ids | The list of GAAP proxy policy rule ID. |
| listener_id | The GAAP layer4 listener ID. |
| realserver_ids | The list of GAAP realserver ID. |

## Authors

Created and maintained by [TencentCloud](https://github.com/terraform-providers/terraform-provider-tencentcloud)

## License

Mozilla Public License Version 2.0.
See LICENSE for full details.
