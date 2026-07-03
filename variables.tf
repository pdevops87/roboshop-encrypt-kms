variable "ami"{
default = "ami-0220d79f3f480ecf5"
}
variable "kms" {
default = "arn:aws:kms:us-east-1:041445559784:key/bbcec40c-e637-45dd-8f1a-8fce019cf076"
}

variable "env" {
  default = "dev"
}

