resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${file ("~/.ssh/id_rsa.pub")}" #interpolation # take key from home and use it
}