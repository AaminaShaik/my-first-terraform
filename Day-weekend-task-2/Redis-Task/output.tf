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

output "redis_endpoint" {
  value = module.redis.redis_endpoint
}
output "redis_port" {
  value = module.redis.redis_port
}



# output "name" {

# }