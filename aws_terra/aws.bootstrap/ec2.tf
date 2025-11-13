# Get all private subnets by Name tag
data "aws_subnets" "private" {
  filter {
    name   = "tag:Name"
    values = ["*Private Subnet*"]
  }
}

# Fetch details for each subnet (to get AZ)
data "aws_subnet" "private_detail" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.key
}

# Map subnets by AZ
locals {
  subnets_by_az = {
    for s in data.aws_subnet.private_detail :
    s.availability_zone => s.id
  }
}

# Randomly pick 2 AZs
resource "random_shuffle" "azs" {
  input        = keys(local.subnets_by_az)
  result_count = 2
}

# Create a map of selected subnets with unique keys for for_each
locals {
  selected_subnets_map = {
    "ec2-1" = local.subnets_by_az[random_shuffle.azs.result[0]]
    "ec2-2" = local.subnets_by_az[random_shuffle.azs.result[1]]
  }
}

# Deploy 2 EC2 instances
resource "aws_instance" "test_env_ec2" {
  for_each      = local.selected_subnets_map

  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = each.value

  tags = {
    Name = each.key
  }
}
