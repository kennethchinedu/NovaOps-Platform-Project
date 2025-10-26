variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_id" {
  type = string
}


variable "private_subnet_ids" {
  description = "Private  subnets "
  type        = list(string)
}
variable "public_subnet_ids" {
  description = "Public   subnets "
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

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  
}

variable "subnet_cidr" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
  
}