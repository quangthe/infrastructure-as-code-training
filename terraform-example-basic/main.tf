# Configure the AWS Provider
provider "aws" {
  region = "ap-southeast-1"
}

# Create an EC2 instance
resource "aws_instance" "example" {
  # AMI ID for Amazon Linux AMI
  ami           = "ami-64260718"
  instance_type = "t2.micro"
  key_name      = "${var.keypair}"
  security_groups = ["${aws_security_group.allow_all.name}"]
  tags {
    Name = "example"
  }
}

resource "aws_eip" "my_eip" {
  instance = "${aws_instance.example.id}"
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}
