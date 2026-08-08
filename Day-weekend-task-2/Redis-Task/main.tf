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
module "redis" {

  source = "./modules/redis"
  replication_group_id          = var.replication_group_id
  replication_group_description = var.replication_group_description
  engine                = var.engine
  engine_version        = var.engine_version
  node_type             = var.node_type
  num_cache_clusters    = var.num_cache_clusters
  automatic_failover_enabled = var.automatic_failover_enabled
  parameter_group_name  = var.parameter_group_name
  port                  = var.port
  subnet_group_name = var.subnet_group_name
  subnet_ids = [
    module.vpc.subnet_id_1,
    module.vpc.subnet_id_2
  ]
  security_group_id = module.sg.sg_id
}
# terraform apply -target=module.redis -auto-approve
module "ec2" {
    source = "./modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    #sg= module.sg.sg_id
    instance_name = var.instance_name
    redis_endpoint = module.redis.redis_endpoint
    redis_port = module.redis.redis_port
}
# terraform apply -target=module.ec2 -auto-approve