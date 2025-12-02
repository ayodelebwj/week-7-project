#============================================
#Provision Web AMI Templates
#============================================

data "amazon-parameterstore" "web_ubuntu_2404" {
  name = "/aws/service/canonical/ubuntu/server/24.04/stable/current/amd64/hvm/ebs-gp3/ami-id"
}

source "amazon-ebs" "web-vm-template-root" {
  region          = "us-east-2"
  instance_type   = "t3.micro"
  ssh_username    = "ubuntu"
  source_ami      = data.amazon-parameterstore.web_ubuntu_2404.value
  ami_name        = "web-ami"
  ami_description = "Amazon Linux 2 custom AMI with java and python"
}

build {
  name    = "web-template-build"
  sources = ["source.amazon-ebs.web-vm-template-root"]

  provisioner "shell" {
    inline_shebang = "/bin/bash -xe"
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl daemon-reload",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx",
      "exit 0"
    ]
  }
}
