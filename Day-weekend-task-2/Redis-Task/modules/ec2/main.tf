resource "aws_instance" "ec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
      "Name" =var.instance_name 
    }
    user_data = <<-EOF
    #!/bin/bash

    # Install Redis CLI dependencies/tools
    dnf install -y redis6

    # Test connectivity to ElastiCache Redis
    redis-cli -h ${var.redis_endpoint} -p ${var.redis_port} ping

    # Store Redis connection details
    echo "REDIS_HOST=${var.redis_endpoint}" > /home/ec2-user/redis.env
    echo "REDIS_PORT=${var.redis_port}" >> /home/ec2-user/redis.env
  EOF
}
