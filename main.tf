provider "aws" {
  alias  = "east"
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

# EC2 Instance in us-east-1
resource "aws_instance" "east_server" {
  provider = aws.east

  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Nginx-East-Server"
  }
}

# EC2 Instance in us-west-2
resource "aws_instance" "west_server" {
  provider = aws.west

  ami           = "ami-0d081196e3df05f4d"
  instance_type = "t3.micro"

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y
              sudo systemctl start nginx
              sudo systemctl enable nginx
              EOF

  tags = {
    Name = "Nginx-West-Server"
  }
}