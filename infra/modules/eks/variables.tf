variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  type = string
}


variable "private_subnet_ids" {
  description = "CIDR block for subnets "
  type        = list(string)
}
variable "public_subnet_ids" {
  description = "CIDR block for subnets "
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for the nodes"
  type        = string
}

variable "ami" {
  description = "AMI ID for the nodes"
  type        = string
  
}

variable "authentication_mode" {
  description = "Authentication mode for the EKS cluster"
  type        = string
}