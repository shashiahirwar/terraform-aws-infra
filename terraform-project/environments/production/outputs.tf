# output "myoutputt" {
#     value = aws_vpc.myvpc.id
  
# }

# output "myvpc_arn" {
#     value = aws_vpc.myvpc.arn
  
# }
# output "vpc_arn" {
#     value = aws_vpc.myvpc.default_security_group_id
  
# }



output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.aws_vpc.selected.id
}

output "subnet_id" {
  description = "The ID of the created Subnet"
  value       = aws_subnet.my_subnet.id
}
