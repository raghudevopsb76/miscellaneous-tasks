terraform {
  backend "s3" {
    bucket = "d76-terraform-state"
    key    = "misc/jenkins-ip-update/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_instance" "jenkins" {
  instance_id = "i-0f39f92b262390f2a"
}

resource "aws_route53_record" "jenkins" {
  name    = "jenkins"
  type    = "A"
  zone_id = "Z0021413JFIQEJP9ZO9Z"
  ttl     = 10
  records = [data.aws_instance.jenkins.public_ip]
}


data "aws_instance" "artifactory" {
  instance_id = "i-0d12debd623d2579b"
}

resource "aws_route53_record" "artifactory" {
  name    = "artifactory"
  type    = "A"
  zone_id = "Z0021413JFIQEJP9ZO9Z"
  ttl     = 10
  records = [data.aws_instance.artifactory.public_ip]
}


