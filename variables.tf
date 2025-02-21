variable "vpc_config" {
  description = "To get the cidr and name of vpc from user"
  type = object({
    cidr_block = string
    name = string
  })
  validation {
    condition = can(cidrnetmask(var.vpc_config.cidr_block))
    error_message = "Invalid CIDR Format - ${var.vpc_config.cidr_block}"
  }
}

variable "subnet_config" {
  description = "Get the cidr and az from user for the subnets"
  type = map(object({
    cidr_block = string
    az = string
    public = optional(bool, false)
  }))
  validation {
    # sub1={cidr=..} sub2={cidr=..}, [true, true, false]
    condition = alltrue([for config in var.subnet_config : can(cidrnetmask(config.cidr_block))])
    error_message = "Invalid CIDR Format"
  }
}

variable "security_group_config" {
  description = "Security group configuration including ingress and egress rules"
  type = map(object({
    description = string
    ingress = list(object({
      description = string
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_blocks = list(string)
    }))
    egress = list(object({
      description = string
      protocol    = string
      from_port   = number
      to_port     = number
      cidr_blocks = list(string)
    }))
  }))

  validation {
    condition = alltrue([
      for sg_key, config in var.security_group_config :
        alltrue([
          for rule in config.ingress : alltrue([
            for cidr in rule.cidr_blocks : can(cidrnetmask(cidr))
          ])
        ])
    ]) && alltrue([
      for sg_key, config in var.security_group_config :
        alltrue([
          for rule in config.egress : alltrue([
            for cidr in rule.cidr_blocks : can(cidrnetmask(cidr))
          ])
        ])
    ])
    error_message = "Invalid CIDR format in ingress or egress rules."
  }
}

