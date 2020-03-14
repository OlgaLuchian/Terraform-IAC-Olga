provider "aws" {
  region  = "${var.region}"
  version = "~> 2.52"
}

terraform {
  required_version = "0.11.14"
}
