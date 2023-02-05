provider "aws" {
    region = var.region
    access_key = var.access_key
    secret_key = var.secret_key
  
}

resource "aws_vpc" "dgweb-vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = "true"
    enable_dns_support = "true"
    instance_tenancy = "default"
    tags = {
      "Name" = "dgweb-vpc"
    }
  
}


resource "aws_internet_gateway" "dgweb-igw" {
    vpc_id = aws_vpc.dgweb-vpc.id
    tags = {
      "Name" = "dgweb-igw"
    }
  
}


resource "aws_subnet" "dgweb-pub-sn1" {
    cidr_block = var.subnet[0]
    availability_zone = var.az[0]
    vpc_id = aws_vpc.dgweb-vpc.id
    map_public_ip_on_launch = true
    tags = {
      "Name" = "dgweb-pub-sn1"
    }
  
}

resource "aws_subnet" "dgweb-pub-sn2" {
    cidr_block = var.subnet[1]
    availability_zone = var.az[1]
    vpc_id = aws_vpc.dgweb-vpc.id
    map_public_ip_on_launch = true
    tags = {
        Name = "dgweb-pub-sn2"
    }
  
}

resource "aws_subnet" "dgweb-pri-sn1" {
    cidr_block = var.subnet[2]
    availability_zone = var.az[0]
    vpc_id = aws_vpc.dgweb-vpc.id
    tags = {
      "Name" = "dgweb-pri-sn1"
    }
  
}

resource "aws_subnet" "dgweb-pri-sn2" {
    cidr_block = var.subnet[3]
    availability_zone = var.az[1]
    vpc_id = aws_vpc.dgweb-vpc.id
    tags = {
        Name = "dgweb-pri-sn2"
    }
  
}

resource "aws_route_table" "dgweb-rt" {
  vpc_id = aws_vpc.dgweb-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dgweb-igw.id
  }
  tags = {
    Name = "dgweb-rt"

  }
}


resource "aws_route_table_association" "dgweb-pub-rt" {
    subnet_id = aws_subnet.dgweb-pub-sn1.id
    route_table_id = aws_route_table.dgweb-rt.id
  
}

resource "aws_route_table_association" "dgweb-pub-rt2" {
    subnet_id = aws_subnet.dgweb-pub-sn2.id
    route_table_id = aws_route_table.dgweb-rt.id
  
}

