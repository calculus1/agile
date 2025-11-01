
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.75.1"
    }
   
  }
}
# ---------------------
# Data sources
# ---------------------

data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["*Private Subnet*"]
  }
}

data "aws_subnet" "subnet" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

# ---------------------
# EC2 resource
# ---------------------

resource "aws_instance" "test_env_ec2" {
  for_each = data.aws_subnet.subnet
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = each.value.id

  tags = {
    Name = "test-env-ec2-${each.key}"
  }
}

# ---------------------
# Outputs
# ---------------------

output "subnet_ids" {
  description = "IDs of all subnets matched by the filter"
  value       = [for s in values(data.aws_subnet.subnet) : s.id]
}

  variable "ami_id" {
    type = string
}
variable "instance_type" {
  type = string
}


/*
resource "aws_instance" "test_env_ec2" {
    ami             = "ami-0e46a6a8d36d6f1f2"
    instance_type   = "t2.micro"
    subnet_id       = data.aws_subnet.subnet[*].id 

    #subnet_id      = data.aws_subnets.destination[*].id


    tags = {
      Name = "test Server"
      Creation_time = time_static.JCRS-e-time.rfc3339
      #Creator       = data.external.aws_username.result["name"]

    }
    user_data = <<-EOF
                #!/bin/bash
                sudo apt update
                sudo apt install nginx -y
                systemctl enable nginx
                systemctl start nginx
                EOF
}

*/