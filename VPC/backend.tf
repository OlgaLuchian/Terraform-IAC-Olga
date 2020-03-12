terraform {

backend "s3" {

bucket = "terraform-class-tatiana"

key = "tower/us-east-1/tools/sao paulo/tower.tfstate"

region = "us-east-1"

  }

}
