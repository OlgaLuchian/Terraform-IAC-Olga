# data "aws_ami" "centos" {
#   most_recent = true
#   owners      = ["679593333241"]

#   filter {
#     name   = "state"
#     values = ["available"]
#   }

#   filter {
#     name   = "name"
#     values = ["CentOS Linux 7 x86_64 HVM EBS *"]
#   }
# }

resource "aws_instance" "r1soft" {
  depends_on                  = ["aws_key_pair.r1soft"]
  instance_type               = "${var.instance_type}"
  ami                         = "${var.ami_id}"
  key_name                    = "${var.key_name}"
  associate_public_ip_address = "true"
  security_groups             = ["allow_ssh_and_r1soft"]

  provisioner "file" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    source      = "~/.ssh"
    destination = "/tmp/"
  }

  provisioner "file" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    source      = "./module/r1soft-repo.repo"
    destination = "/tmp/r1soft-repo.repo"
  }

  provisioner "remote-exec" {
    connection {
      host        = "${self.public_ip}"
      type        = "ssh"
      user        = "${var.user}"
      private_key = "${file(var.ssh_key_location)}"
    }

    inline = [
      "sudo cp /tmp/r1soft-repo.repo /etc/yum.repos.d/",
      "sudo yum install r1soft-cdp-enterprise-server -y",
      "sudo r1soft-setup --user tanea --pass p1ssw2rd --http-port 80",
      "sudo systemctl restart cdp-server",
    ]
  }

  tags = {
    Name = "r1soft"
  }
}