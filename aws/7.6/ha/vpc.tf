// AWS VPC 
resource "aws_vpc" "fgtvm-vpc" {
  cidr_block           = var.vpccidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  tags = {
    Name = "terraform demo"
  }
}

resource "aws_subnet" "publicsubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.publiccidraz1
  availability_zone = var.az1
  tags = {
    Name = "public subnet az1"
  }
}

resource "aws_subnet" "publicsubnetaz2" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.publiccidraz2
  availability_zone = var.az2
  tags = {
    Name = "public subnet az2"
  }
}


resource "aws_subnet" "privatesubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.privatecidraz1
  availability_zone = var.az1
  tags = {
    Name = "private subnet az1"
  }
}

resource "aws_subnet" "privatesubnetaz2" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.privatecidraz2
  availability_zone = var.az2
  tags = {
    Name = "private subnet az2"
  }
}

resource "aws_subnet" "hasyncsubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.hasynccidraz1
  availability_zone = var.az1
  tags = {
    Name = "hasync subnet az1"
  }
}

resource "aws_subnet" "hasyncsubnetaz2" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.hasynccidraz2
  availability_zone = var.az2
  tags = {
    Name = "hasync subnet az2"
  }
}

resource "aws_subnet" "hamgmtsubnetaz1" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.hamgmtcidraz1
  availability_zone = var.az1
  tags = {
    Name = "hamgmt subnet az1"
  }
}

resource "aws_subnet" "hamgmtsubnetaz2" {
  vpc_id            = aws_vpc.fgtvm-vpc.id
  cidr_block        = var.hamgmtcidraz2
  availability_zone = var.az2
  tags = {
    Name = "hamgmt subnet az2"
  }
}

# S3 endpoint inside the VPC
resource "aws_vpc_endpoint" "s3-endpoint-fgtvm-vpc" {
  count           = var.bucket ? 1 : 0
  vpc_id          = aws_vpc.fgtvm-vpc.id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = [aws_route_table.fgtvmpublicrt.id]
  policy          = <<POLICY
{
    "Statement": [
        {
            "Action": "*",
            "Effect": "Allow",
            "Resource": "*",
            "Principal": "*"
        }
    ]
}
POLICY
  tags = {
    Name = "fgtvm-endpoint-to-s3"
  }
}
