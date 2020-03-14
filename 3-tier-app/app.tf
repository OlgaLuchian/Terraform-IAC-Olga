resource "aws_instance" "web" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     = "${data.terraform_remote_state.dev.Subnet1}"
}



module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  # Launch configuration
  lc_name = "example-lc"

  image_id        = ""${data.aws_ami.ubuntu.id}""
  instance_type   = "t2.micro"
  security_groups = ["sg-12345678"]

  ebs_block_device = [
    {
      device_name           = "/dev/xvdz"
      volume_type           = "gp2"
      volume_size           = "50"
      delete_on_termination = true
    },
  ]

  root_block_device = [
    {
      volume_size = "50"
      volume_type = "gp2"
    },
  ]

  # Auto scaling group
  asg_name                  = "example-asg"
  vpc_zone_identifier       = ["${data.terraform_remote_state.dev.Subnet1}", 
                               "${data.terraform_remote_state.dev.Subnet2}", 
                               "${data.terraform_remote_state.dev.Subnet3}"]

                               
  health_check_type         = "EC2"
  min_size                  = 0
  max_size                  = 1
  desired_capacity          = 1
  wait_for_capacity_timeout = 0

  tags = [
    {
      key                 = "Environment"
      value               = "dev"
      propagate_at_launch = true
    },
    {
      key                 = "Project"
      value               = "megasecret"
      propagate_at_launch = true
    },
  ]
}