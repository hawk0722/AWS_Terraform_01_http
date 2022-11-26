# instance
data "aws_ssm_parameter" "amzn2_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "ec2" {
  ami           = data.aws_ssm_parameter.amzn2_ami.value
  instance_type = "t2.micro"
  subnet_id     = var.public_subnet_1a_id
  user_data     = file("../../modules/instance/user_data.sh")

  vpc_security_group_ids = [
    var.sg_web_id
  ]

  tags = {
    Name = "${var.project}-${var.env}-ec2"
  }
}
