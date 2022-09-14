variable "subnet" {
  description = "Subnet id for ALB"
  type        = list(any)
  default     = []
}

variable "sg_id" {
  description = "Security group id for ALB"
  type        = list(any)
  default     = []
}

variable "tg_vpc" {
  description = "VPC id for target group"
  type        = string
}

variable "internal" {
  description = "Is internal ALB?"
  type        = bool
  default     = false
}

variable "enable_deletion_protection_state" {
  type    = bool
  default = false
}

variable "drop_invalid_header_fields_state" {
  type    = bool
  default = false
}

variable "connection_termination_state" {
  type    = bool
  default = false
}

variable "preserve_host_header_state" {
  type    = bool
  default = false
}

variable "idle_timeout_value" {
  type    = number
  default = 60
}

variable "enable_cross_zone_load_balancing_state" {
  type    = bool
  default = false
}

variable "enable_http2_state" {
  type    = bool
  default = true
}

variable "enable_waf_fail_open_state" {
  type    = bool
  default = false
}

variable "ip_add_type" {
  description = "IP Address type"
  type        = string
  default     = "ipv4"
}

variable "port" {
  type    = number
  default = 80
}

variable "protocol" {
  type    = string
  default = "HTTP"
}

variable "target_type" {
  type    = string
  default = "ip"
}

variable "health_check_path" {
  type    = string
  default = "/"
}

variable "health_check_port" {
  type    = number
  default = 80
}

variable "health_check_protocol" {
  type    = string
  default = "HTTP"
}

variable "health_check_timeout" {
  type    = number
  default = 5
}

variable "health_check_interval" {
  type    = number
  default = 30
}

variable "alpn_policy" {
  type    = string
  default = "None"
}

variable "ssl_policy" {
  type = string
}

variable "certificate_arn" {
  type = string
}

variable "Target_ids" {
  description = "Target ids(instance ids/ips/ALB) to be attached with target group"
  type        = list(any)
  default     = []
}

variable "Target_Group_Name" {
  description = "List of target group names"
  type        = list(any)
  default     = []
}

variable "ALB_Name" {
  description = "List of ALB names"
  type        = list(any)
  default     = []
}
