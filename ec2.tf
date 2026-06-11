resource "aws_instance" "instance" {
  ami           = var.ami
  instance_type = "t3.micro"
 vpc_security_group_ids = ["sg-00200ecf86b9b6868"]
  root_block_device {
    encrypted = true
    kms_key_id = var.kms
  }
  tags = {
    Name = "test"
  }
}