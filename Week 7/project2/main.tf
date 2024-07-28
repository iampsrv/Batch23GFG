provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "instance_security_group" {
  name_prefix = "instance_security_group"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

  ingress {
    from_port   = 8080
    to_port     = 8080
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

resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "my-route-table"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "subnet2"
  }
}


resource "aws_route_table_association" "rta1" {

  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.my_route_table.id
}
resource "aws_route_table_association" "rta2" {

  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_instance" "instance1" {
  ami = "ami-04b70fa74e45c3917"
  instance_type               = "t2.micro"
  security_groups = [aws_security_group.instance_security_group.id]
  subnet_id       = aws_subnet.subnet1.id
  user_data       = file("start.sh")

  tags = {
    Name = "instance1"
  }
}

resource "aws_instance" "instance2" {
  ami = "ami-04b70fa74e45c3917"
  instance_type               = "t2.micro"
  security_groups = [aws_security_group.instance_security_group.id]
  subnet_id       = aws_subnet.subnet2.id
  user_data       = file("start.sh")

  tags = {
    Name = "instance2"
  }
}

resource "aws_lb_target_group" "awslbtg" {
  name        = "awslbtg"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.my_vpc.id
  target_type = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
  }

  tags = {
    Name = "example-tg"
  }
}

resource "aws_lb_target_group_attachment" "registerinstance1" {
  target_group_arn  = aws_lb_target_group.awslbtg.arn
  target_id         = aws_instance.instance1.id
  port              = 8080
  }
resource "aws_lb_target_group_attachment" "registerinstance2" {
  target_group_arn  = aws_lb_target_group.awslbtg.arn
  target_id         = aws_instance.instance2.id
  port              = 8080
  }

resource "aws_lb" "myawslb" {
  name               = "myawsalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.instance_security_group.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  
  tags = {
    Name = "myawsalb"
  }
}

resource "aws_lb_listener" "awslblistener" {
  load_balancer_arn = aws_lb.myawslb.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.awslbtg.arn
  }
}