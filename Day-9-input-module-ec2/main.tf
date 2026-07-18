module "dev" {
    source         = "../Day-9-module-ec2"
  ami_id          = "ami-01edba92f9036f76e"
  instance_type   = "t2.micro"
  instance_name   = "DevInstance"
}