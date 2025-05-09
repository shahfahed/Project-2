provider "aws" {
    region = var.region
}

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    tags = {
        Name = "project-2"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = "10.0.0.0/24"
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "igw"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public-rt"
    }
}

resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "sg_all" {
    name = "allows-all"
    description = "allows all traffic"
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = "sg-all"
    }

    ingress {
        to_port = 0
        from_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        to_port = 0
        from_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }    
}

resource "aws_instance" "j-master" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.sg_all.id]
    tags = {
        Name = "j-master"
    }
}

resource "aws_instance" "j-slave" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.sg_all.id]
    tags = {
        Name = "j-slave"
    }
}

resource "aws_instance" "k-master" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.sg_all.id]
    tags = {
        Name = "k-master"
    }
}

resource "aws_instance" "k-slave" {
    ami = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = aws_subnet.public_subnet.id
    vpc_security_group_ids = [aws_security_group.sg_all.id]
    tags = {
        Name = "k-slave"
    }
}