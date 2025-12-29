provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "k8s-master" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.medium"
  key_name      = "banking-key"

  tags = {
    Name = "k8s-master"
  }
}

resource "aws_instance" "k8s-worker" {
  count         = 2
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t3.medium"
  key_name      = "banking-key"

  tags = {
    Name = "k8s-worker-${count.index}"
  }
}
