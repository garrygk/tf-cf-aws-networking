resource "aws_instance" "tfpublicInstance" {
  ami = "ami-098c93bd9d119c051"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.tfpubsubnet.id

  associate_public_ip_address = true

  key_name = "jumpbox-kp"

  security_groups = [ aws_security_group.tfsg_public.id ]

  availability_zone = aws_subnet.tfpubsubnet.availability_zone

  tags = {
    Name = "tf_instance"
  }
}

resource "aws_security_group" "tfsg_public" {
  name = "tfsg_public"
  vpc_id = aws_vpc.tfvpc.id

  tags = {
    Name = "tf_securitygroup"
  }
}
