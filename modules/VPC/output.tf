output "vpc_id" {
  value = aws_vpc.eks_vpc.id
}

# ID of subnet in AZ1 
output "pub_sub_AZ1_id" {
  value = aws_subnet.pub-az1.id
}

# ID of subnet in AZ2 
output "pub_sub_AZ2_id" {
  value = aws_subnet.pub-az2.id
}

# Internet Gateway ID
output "igw_id" {
  value = aws_internet_gateway.myigw.id
}