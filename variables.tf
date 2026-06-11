variable "ami"{
default = "ami-0220d79f3f480ecf5"
}
variable "kms" {
default = "arn:aws:kms:us-east-1:041445559784:key/89d045f5-7a12-4a16-86d3-e90719e64048"
}

variable "env" {
  default = "dev"
}