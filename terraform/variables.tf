variable "default_region" {
  type    = string
  default = "ap-northeast-1"
}

variable "vpc" {
  default = {
    name = "docker-handson"
    cidr = "10.100.0.0/16"
    subnets = {
      pub = {
        a = {
          availability_zone = "ap-northeast-1a"
          cidr              = "10.100.0.0/24"
        }
        c = {
          availability_zone = "ap-northeast-1c"
          cidr              = "10.100.1.0/24"
        }
        d = {
          availability_zone = "ap-northeast-1d"
          cidr              = "10.100.2.0/24"
        }
      }
    }
  }
}

variable "ec2" {
  default = {
    instance = {
      type = "t3.small"
    }
  }
}

variable "users" {
  type = list(string)
  default = [
    "user01",
    "user02"
  ]
}