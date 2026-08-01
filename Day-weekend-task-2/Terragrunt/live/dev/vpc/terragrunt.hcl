terraform{
    source ="../../../modules/vpc"
}
inputs = {
    vpc_cidr = "10.0.0.0/16"
    vpc_name = "dev-vpc"
}