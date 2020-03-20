resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-tatiana"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
