variable "public_subnets_cidrs" {
  type = list(string)
  description = "public subnets cidr ranges"
  default = ["192.168.1.0/24", "192.168.2.0/24"]
}

variable "private_subnets_cidrs" {
  type = list(string)
  description = "private subnets cidr ranges"
  default = ["192.168.3.0/24", "192.168.4.0/24"]
}


variable "azs" {
    type = list(string)
    description = "Availability Zones"
    default = ["eu-central-1a", "ey-central.1b"]
}

variable "ami" {
  type = string
  description = "AMI for current Region"
  default = "ami-04e5276ebb8451442"
}

variable "instance_type" {
  type = string
  default = "t2.micro"
}