#Pull VPC , subnet, igw informations 
data "terraform_remote_state" "dev" {
    data "terraform_remote_state" "main" {
  backend = "s3"
  config = {
    bucket = "terraform-class-tatiana"
    key    = "tower/us-east-1/tools/virginia/tower.tfstate"
    region = "us-east-1"
  }

}
}

