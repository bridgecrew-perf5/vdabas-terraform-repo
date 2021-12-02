provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "C:/Users/vivek/.aws/credentials"
  profile                 = "dtisbx"
}

variable server_port {
  description = "This is the server port on which you want to run the webserver"
  type        = number
  default     = 8080
}

resource "aws_instance" "example" {
  ami                     = "ami-09e67e426f25ce0d7"
  instance_type           = "t2.micro"
  vpc_security_group_ids  = [aws_security_group.instance.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  tags = {
  Name = "HTTPDEC2"
  ManagedBy = "Terraform"
  }
}

resource "aws_security_group" "instance" {
  name = "terraform-example-instance"

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output PUBLIC_IP {
  value = aws_instance.example.public_ip
}
