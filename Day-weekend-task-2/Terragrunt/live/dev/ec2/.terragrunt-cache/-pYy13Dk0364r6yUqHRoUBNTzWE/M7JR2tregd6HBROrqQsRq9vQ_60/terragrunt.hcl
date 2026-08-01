dependency "vpc" {
    config_path = "../vpc"
}
terraform{
    source ="../../../modules/ec2"
}
inputs = {
    ami_id = "ami-01edba92f9036f76e"
    instance_type = "t2.micro"
    instance_name = "dev-ec2-instance"
    vpc_id = dependency.vpc.outputs.vpc_id
}
