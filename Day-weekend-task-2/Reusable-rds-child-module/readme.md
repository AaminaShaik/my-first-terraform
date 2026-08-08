Task Requirement

Create a reusable Terraform child module that provisions a production-ready MySQL RDS instance with read replica, encrypted storage, automated backups, a DB subnet group, and security group. The root module should invoke this child module and use its outputs to configure the application servers.