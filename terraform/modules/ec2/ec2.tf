resource "aws_instance" "web" {
  ami           = var.aws_ami
  instance_type = "t3.micro"
  # subnet_id   = "subnet-0aa7a2a3113c46086"
  # subnet_id   = module.vpc.public_subnet_ids
  subnet_id     = var.private_subnet_ids
  key_name = "udacity"
  tags = {
    Name = "ubuntu"
  }
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  vpc_id      = var.vpc_id
  # vpc_id    = module.vpc.vpc_id

  ingress {    
    description = "web port"
    from_port   = 80    
    to_port     = 80
    protocol    = "tcp"    
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "ssh port"
    from_port   = 22    
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "monitoring"
    from_port   = 9100    
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2_sg"
  }
}