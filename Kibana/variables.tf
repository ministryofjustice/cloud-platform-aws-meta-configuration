variable "test_domain" {
  default = "cloud-platform-test"
}

# for clusters, allow all 3 NAT GW IPs
variable "allowed_test_ips" {
  type = "map"

  default = {
    "54.229.250.233/32" = "test-1-a"
    "54.229.139.68/32"  = "test-1-b"
    "34.246.149.106/32" = "test-1-c"
  }
}

variable "live_domain" {
  default = "cloud-platform-live"
}

variable "allowed_live_ips" {
  type = "map"

  default = {
    "81.134.202.29/32"  = "office"
    "52.17.133.167/32"  = "live-0-a"
    "34.247.134.240/32" = "live-0-b"
    "34.251.93.81/32"   = "live-0-c"
  }
}

variable "audit_domain" {
  default = "cloud-platform-audit"
}

variable "allowed_audit_ips" {
  type = "map"

  default = {
    "81.134.202.29/32"  = "office"
    "52.17.133.167/32"  = "live-0-a"
    "34.247.134.240/32" = "live-0-b"
    "34.251.93.81/32"   = "live-0-c"
  }
}
