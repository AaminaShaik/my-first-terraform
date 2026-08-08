output "vpc_id" {
  value = module.vpc.vpc_id
}
output "subnet_id_1" {
  value = module.vpc.subnet_id_1
}
output "subnet_id_2" {
  value = module.vpc.subnet_id_2
}
output "sg_id" {
  value = module.sg.sg_id
}
output "instance_id" {
  value = module.ec2.instance_id
}
output "db_endpoint" {
  value = module.rds.db_endpoint
}
output "db_port" {
  value = module.rds.db_port
}
output "db_replica_endpoint" {
  value = module.rds.rds_replica_endpoint
}



# output "name" {

# }