module "simple-layer4" {
  source = "../../"

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
