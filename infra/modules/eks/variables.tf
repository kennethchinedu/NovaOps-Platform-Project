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