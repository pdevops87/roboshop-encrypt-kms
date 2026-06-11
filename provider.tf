# provider is a plugin which is used to interact with aws cloud services
# terraform uses provider plugin to interact with aws

provider "aws" {
  region = "us-east-1"
}

#  terraform connects to kubernetes
#  helm read kubernetes config and connect to eks cluster
provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}
