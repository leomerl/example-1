# cidrs
variable "public_subnets_cidrs" {
  type = list(string)
  description = "public subnets cidr ranges"
  default = ["192.168.1.1/24", "192.168.2.1/24"]
}

variable "private_subnets_cidrs" {
  type = list(string)
  description = "private subnets cidr ranges"
  default = ["192.168.1.2/24", "192.168.2.2/24"]
}


# azs
variable "azs" {
    type = list(string)
    description = "Availability Zones"
    default = ["eu-central-1a", "ey-central.1b"]
}