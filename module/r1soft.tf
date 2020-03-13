data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }
}

resource "aws_instance" "r1soft"         {
  depends_on                  = ["aws_key_pair.r1soft"]
  instance_type               = "${var.instance_type}"
  ami                         = "${data.aws_ami.centos.id}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_r1soft"]


  provisioner "file" {
   connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host     = "${self.public_ip}"
    }

    source      = "~/.ssh"
    destination = "/tmp/"
  }



  provisioner "file" {
   connection {
      type     = "ssh"
    user     = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host     = "${self.public_ip}"
    }

    source      = "./module/r1soft.repo"
    destination = "/tmp/r1soft.repo"
  }






  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
      host     = "${self.public_ip}"
    }
    

    inline = [
	      "sudo cp /tmp/r1soft.repo /etc/yum.repos.d/",          
        "sudo  yum install r1soft-cdp-enterprise-server -y",
        "sudo r1soft-setup --user tanea --pass p1as2sword3 --http-port 80",
        "sudo systemctl restart cdp-server"
    ]
  }


  tags = {
    Name = "r1soft"                     
  }
}