# # 

# output "subnet_cidr" {
#   value = aws_subnet.pubsub1.cidr_block
# }

output "pri_sub1" {
  value = aws_subnet.pri_sub1.id
}

output "pri_sub2" {
  value = aws_subnet.pri_sub2.id
}


output "public_sub1" {
  value = aws_subnet.public_sub1.id
}
output "public_sub2" {
  value = aws_subnet.public_sub2.id
}

# output "vpc_cidr" {
#   value = var.vpc_cidr
# }

output "vpc_id" {
  value = aws_vpc.main.id
}