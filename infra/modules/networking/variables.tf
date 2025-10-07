
variable "tags" {
  type    = map(string)
  default = {}
}

variable "subnet_cidr" {
  description = "CIDR block for subnets "
  type        = list(string)
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = ""
  
}


variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for the VPC"
  type        = list(string)
   
}
