terraform {
  backend "s3" {
    bucket = "my-tf-test-bucket-tatiana"

    key = "r1soft-project/us-east-1/tools/tower/tower.tfstate"

    region = "us-east-1"
  }
}
