#creating a vpc
resource "aws_vpc" "vic_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "vicvpc"
  }

}

#creating a subnet
#publicsubnet1
resource "aws_subnet" "vic_public_subnet1" {
  vpc_id = aws_vpc.vic_vpc.id
  # count = 3
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2a"

  tags = {
    "Name" = "vic-publicsubnet1"
  }

}

#Pu.subnet2
resource "aws_subnet" "vic_public_subnet2" {
  vpc_id = aws_vpc.vic_vpc.id
  # count = 3
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2b"

  tags = {
    "Name" = "vic-publicsubnet2"
  }

}

#Pu.subnet3

resource "aws_subnet" "vic_public_subnet3" {
  vpc_id                  = aws_vpc.vic_vpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-2c"

  tags = {
    "Name" = "vic-publicsubnet3"
  }

}

#creating internet gateway
resource "aws_internet_gateway" "vic_internet_gateway" {
  vpc_id = aws_vpc.vic_vpc.id

  tags = {
    "Name" = "vic-igw"
  }

}

#create route table
resource "aws_route_table" "vic_public_rt" {
  vpc_id = aws_vpc.vic_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vic_internet_gateway.id
  }

  tags = {
    Name = "vic-public-rt"
  }
}

#create route
#resource "aws_route" "default_route" {
# route_table_id         = aws_route_table.vic_public_rt.id
#destination_cidr_block = "0.0.0.0/0"
#gateway_id             = aws_internet_gateway.vic_internet_gateway.id

#}

#create route table associatiom
resource "aws_route_table_association" "vic_route_assoc1" {
  subnet_id      = aws_subnet.vic_public_subnet1.id
  route_table_id = aws_route_table.vic_public_rt.id
}

resource "aws_route_table_association" "vic_route_assoc2" {
  subnet_id      = aws_subnet.vic_public_subnet2.id
  route_table_id = aws_route_table.vic_public_rt.id
}

resource "aws_route_table_association" "vic_route_assoc3" {
  subnet_id      = aws_subnet.vic_public_subnet3.id
  route_table_id = aws_route_table.vic_public_rt.id
}


# Create a security group for the load balancer
resource "aws_security_group" "vic_lb_sg" {
  name        = "vic_lb_sg"
  description = "Allow HTTPS and HTTP inbound traffic for application load balancer"
  vpc_id      = aws_vpc.vic_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#create security group for instance
resource "aws_security_group" "vic_sg" {
  name        = "vic_sgp"
  description = "Allow HTTPS and HTTP inbound traffic for instances"
  vpc_id      = aws_vpc.vic_vpc.id
  
  #incoming traffic
  ingress {
    description     = "HTTPS"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.vic_lb_sg.id]
  }
  ingress {
    description     = "HTTP"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    security_groups = [aws_security_group.vic_lb_sg.id]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  #outgoing traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    # ipv6_cidr_blocks = ["::/0"]
  }
}



#create keypair
#resource "aws_key_pair" "vic_key" {
# key_name   = "vickey"
#public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJgX+1lRSGIxC03wWIsGzgMJ/P6zj3D9SGzAFEMt9Dz5 victoria@Kali"
#}

#create ec2 instances
#ec2.1
resource "aws_instance" "vic_ec21" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.vic_ami.id
  key_name               = "vickey1"
  vpc_security_group_ids = [aws_security_group.vic_sg.id]
  subnet_id              = aws_subnet.vic_public_subnet1.id
  availability_zone      = "us-east-2a"
  #root_block_device {
  # volume_size = 10
  #}

  tags = {
    "Name" = "vic_ec21"
  }
}

#ec2.2
resource "aws_instance" "vic_ec22" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.vic_ami.id
  key_name               = "vickey1"
  vpc_security_group_ids = [aws_security_group.vic_sg.id]
  subnet_id              = aws_subnet.vic_public_subnet2.id
  availability_zone      = "us-east-2b"
  #  root_block_device {
  #   volume_size = 10
  #}

  tags = {
    "Name" = "vic_ec22"
  }
}

#ec2.3
resource "aws_instance" "vic_ec23" {
  instance_type          = "t2.micro"
  ami                    = data.aws_ami.vic_ami.id
  key_name               = "vickey1"
  vpc_security_group_ids = [aws_security_group.vic_sg.id]
  subnet_id              = aws_subnet.vic_public_subnet3.id
  availability_zone      = "us-east-2c"
  #root_block_device {
  # volume_size = 10
  #}

  tags = {
    "Name" = "vic_ec23"
  }
}

#create load balancer
resource "aws_lb" "vic_lb" {
  name               = "vic-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.vic_lb_sg.id]
  subnets            = [aws_subnet.vic_public_subnet1.id, aws_subnet.vic_public_subnet2.id, aws_subnet.vic_public_subnet3.id]
  enable_deletion_protection = false
  depends_on = [aws_instance.vic_ec21, aws_instance.vic_ec22, aws_instance.vic_ec23]

}

# create target group
resource "aws_lb_target_group" "lb_target_group" {
  name        = "vic-tg"
  #target_type = "instance"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vic_vpc.id

  health_check {
    enabled             = true
    interval            = 15
    #port                = 80
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    matcher             = "200"
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }
}


# Attach the target group to the load balancer
resource "aws_lb_target_group_attachment" "vic_targetgroupattachment1" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.vic_ec21.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "vic_targetgroupattachment2" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.vic_ec22.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "vic_targetgroupattachment3" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = aws_instance.vic_ec23.id
  port             = 80
}

# create a listener on port 80 with no redirect action
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.vic_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

#export ip to host-inventory
resource "local_file" "exporting_ip" {
  filename = "/home/vagrant/new/Terraform1/host-inventory"
  content  = <<EOT
${aws_instance.vic_ec21.public_ip}
${aws_instance.vic_ec22.public_ip}
${aws_instance.vic_ec23.public_ip}
  EOT
}
