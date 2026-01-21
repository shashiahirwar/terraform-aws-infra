# resource "aws_vpc" "myvpc" {
#     cidr_block = "10.0.0.0/16"

#     tags = {
#       Name =var.name
#     }
#     }
  

resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc"
  }
}

# Fetch the VPC using a data source (pretend it's pre-existing)
data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["my-vpc"]
  }

  depends_on = [aws_vpc.my_vpc]
}

# Use the VPC ID from data source to create a subnet
resource "aws_subnet" "my_subnet" {
  vpc_id                  = data.aws_vpc.selected.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"

  tags = {
    Name = "my-subnet"
  }
}


 resource "aws_instance" "my-instance" {
   ami           = var.ami_id # Example AMI ID, replace with a valid one
   instance_type = var.instance_type
   security_groups = [aws_security_group.my_security_group.id]
   subnet_id     = aws_subnet.my_subnet.id

   tags = {
     Name = "my-instance"
   }

   lifecycle {
     ignore_changes = [
       ami, # Ignore changes to the AMI ID
     ]
   }
   depends_on = [aws_subnet.my_subnet]
 }

 resource "aws_security_group" "my_security_group" {
   name        = "my-security-group"
   description = "Allow SSH and HTTP traffic"
   vpc_id      = data.aws_vpc.selected.id

dynamic "ingress" {
      iterator = port
      for_each = var.ingress_rules
      content {
        from_port   = port.value
        to_port     = port.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Allow traffic from anywhere  
}
}
dynamic "egress" {
      iterator = port
      for_each = var.egress_rules
      content {
        from_port   = port.value
        to_port     = port.value
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] # Allow traffic to anywhere
   }
 }

tags = {
       Name = "ssh-access"
     }

} 


resource "aws_iam_user" "test" {
  name = "test-user"
}
//import "aws_iam_user.test" "test-user1"
resource "aws_iam_user" "test1" {
  name = "user-test1"
}
resource "aws_iam_policy" "ec2-manage" {
  name = "EC2ManagePolicy"
  policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Action": [
          "ec2:AllocateAddress",
          "ec2:AssociateAddress",
          "ec2:AttachInternetGateway",
          "ec2:AttachNetworkInterface",
          "ec2:AuthorizeSecurityGroupEgress",
          "ec2:AuthorizeSecurityGroupIngress",
          "ec2:CreateImage",
          "ec2:CreateInstanceExportTask",
          "ec2:CreateInternetGateway",
          "ec2:CreateKeyPair",
          "ec2:CreateLaunchTemplate",
          "ec2:CreateNetworkInterface",
          "ec2:CreatePlacementGroup",
          "ec2:CreateRoute",
          "ec2:CreateRouteTable",
          "ec2:CreateSecurityGroup",
          "ec2:CreateSnapshot",
          "ec2:CreateSubnet",
          "ec2:CreateTags",
          "ec2:CreateVolume",
          "ec2:CreateVpc",
          "ec2:DeleteKeyPair",
          "ec2:DeleteLaunchTemplate",
          "ec2:DeleteInternetGateway",
          "ec2:DeleteNetworkInterface",
          "ec2:DeletePlacementGroup",
          "ec2:DeleteRoute",
          "ec2:DeleteRouteTable",
          "ec2:DeleteSecurityGroup",
          "ec2:DeleteSnapshot",
          "ec2:DeleteSubnet",
          "ec2:DeleteTags",
          "ec2:DeleteVolume",
          "ec2:DeleteVpc",
          "ec2:Describe*",
          "ec2:DetachInternetGateway",
          "ec2:DetachNetworkInterface",
          "ec2:DisassociateAddress",
          "ec2:ImportKeyPair",
          "ec2:ModifyInstanceAttribute",
          "ec2:ModifyNetworkInterfaceAttribute",
          "ec2:RebootInstances",
          "ec2:RegisterImage",
          "ec2:ReleaseAddress",
          "ec2:RunInstances",
          "ec2:StartInstances",
          "ec2:StopInstances",
          "ec2:TerminateInstances"
        ],
        "Resource": "*"
      }
    ]
  }
  EOF
}
resource "aws_iam_user_policy_attachment" "test_attach" {
  user       = aws_iam_user.test.name
  policy_arn = aws_iam_policy.ec2-manage.arn
}
/* resource "aws_iam_user_access_key" "test_key" {
  user = aws_iam_user.test.name
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [ aws_iam_policy.ec2-manage, aws_iam_user_policy_attachment.test_attach ]

  provisioner "local-exec" {
    command = "echo 'AWS_ACCESS_KEY_ID=${self.id}' >> ~/.aws/credentials && echo 'AWS_SECRET_ACCESS_KEY=${self.secret}' >> ~/.aws/credentials"
  }
}
output "aws_access_key_id" {
  value     = aws_iam_user_access_key.test_key.id
  sensitive = true
  
}
output "aws_secret_access_key" {
  value     = aws_iam_user_access_key.test_key.secret
  sensitive = true
} */
resource "aws_vpc" "my_vpc2" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "my-vpc2"
  }
}