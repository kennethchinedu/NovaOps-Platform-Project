
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


locals {
  public_subnet_ids = {
   pubsub1 = aws_subnet.public_sub1.id,
   pubsub2 = aws_subnet.public_sub2.id
  }
}

locals {
  private_subnet_ids = {
   prisub1 = aws_subnet.pri_sub1.id,
   prisub2 = aws_subnet.pri_sub2.id
  }
}