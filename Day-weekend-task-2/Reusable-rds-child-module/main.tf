module "vpc" {
    source = "./modules/vpc"
    vpc_name = var.vpc_name
    vpc_cidr = var.vpc_cidr_block
    subnet_cidr_1 = var.subnet_cidr_1
    subnet_name_1 = var.subnet_name_1
    availability_zone_1a = var.availability_zone_1a
    subnet_cidr_2 = var.subnet_cidr_2
    subnet_name_2 = var.subnet_name_2
    availability_zone_1b = var.availability_zone_1b
    route_table_name = var.route_table_name
    nat_gateway_name = var.nat_gateway_name
}
# terraform apply -target=module.vpc

module "sg" {
    source = "./modules/sg"
    sg_name = var.sg_name
    vpc_id = module.vpc.vpc_id
}
# terraform apply -target=module.sg
module "rds" {
    source = "./modules/rds"
    db_name = var.db_name
    db_username = var.db_username
    db_password = var.db_password
    vpc_id = module.vpc.vpc_id
    subnet_ids = [module.vpc.subnet_id_1, module.vpc.subnet_id_2]
    sg_id = module.sg.sg_id
    db_subnet_group_name = var.db_subnet_group_name
    db_allocated_storage = var.db_allocated_storage
    db_storage_type = var.db_storage_type
    db_engine = var.db_engine
    db_engine_version = var.db_engine_version
    db_instance_class = var.db_instance_class
    db_parameter_group_name = var.db_parameter_group_name  
    db_name_replica = var.db_name_replica 
}
# terraform apply -target=module.rds
module "ec2" {
    source = "./modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    instance_name = var.instance_name
    db_endpoint = module.rds.db_endpoint
    db_port = module.rds.db_port
    db_username = var.db_username
    db_password = var.db_password
}
# terraform apply -target=module.ec2