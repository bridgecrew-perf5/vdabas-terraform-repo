provider "aws" {
  region                  = "us-east-1"
  shared_credentials_file = "C:/Users/vivek/.aws/credentials"
  profile                 = "dtisbx"
}

resource "aws_instance" "example" {
  ami           = "ami-087c17d1fe0178315"
  instance_type = "t2.micro"

  tags = {
  Name = "SampleEC2"
  ManagedBy = "Terraform"
  }
}
