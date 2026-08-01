What is Terragrunt?

Terragrunt is a wrapper around Terraform.

It does not replace Terraform.

It simply makes Terraform easier to manage.

Think of it like this:

Without Terragrunt

terraform init
terraform plan
terraform apply


With Terragrunt

terragrunt init
terragrunt plan
terragrunt apply

Terragrunt internally calls Terraform.

User
   ↓
Terragrunt
   ↓
Terraform
   ↓
AWS
Why was Terragrunt created?

Imagine a company has

Development
Testing
Staging
Production

Without Terragrunt,

every environment needs

terraform.tfvars

provider.tf

backend.tf

variables.tf

main.tf

You'll have lots of duplicate files.

Example

dev/
   terraform.tfvars

qa/
   terraform.tfvars

prod/
   terraform.tfvars

Only values change.

Everything else is same.

This becomes difficult to maintain.

Problem with terraform.tfvars

Suppose you have

dev

instance_type = "t2.micro"

project = "shopping"


qa

instance_type = "t2.small"

project = "shopping"


prod

instance_type = "t3.large"

project = "shopping"

Every folder contains

provider.tf

backend.tf

variables.tf

outputs.tf

Huge duplication.

Terragrunt Solution

Keep Terraform code only once.

terraform-modules/

ec2/
    main.tf
    variables.tf
    outputs.tf

Now create

live/

dev/
qa/
prod/

Only values exist there.

Terragrunt injects those values.

Folder Structure
project/

├── modules
│     └── ec2
│            main.tf
│            variables.tf
│            outputs.tf
│
└── live
      ├── dev
      │      terragrunt.hcl
      │
      ├── qa
      │      terragrunt.hcl
      │
      └── prod
             terragrunt.hcl

Notice

No

terraform.tfvars
Terraform Module

modules/ec2/main.tf

resource "aws_instance" "web" {

  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

}

variables.tf

variable "ami" {}

variable "instance_type" {}

variable "instance_name" {}

outputs.tf

output "public_ip" {

  value = aws_instance.web.public_ip

}
Terragrunt Configuration

live/dev/terragrunt.hcl

terraform {

  source = "../../modules/ec2"

}

inputs = {

  ami = "ami-084568db4383264d4"

  instance_type = "t2.micro"

  instance_name = "dev-server"

}

QA

terraform {

  source = "../../modules/ec2"

}

inputs = {

  ami = "ami-084568db4383264d4"

  instance_type = "t2.small"

  instance_name = "qa-server"

}

Production

terraform {

  source = "../../modules/ec2"

}

inputs = {

  ami = "ami-084568db4383264d4"

  instance_type = "t3.large"

  instance_name = "prod-server"

}

See?

No tfvars.

Only

inputs
How does it work?

When you execute

terragrunt apply

Terragrunt automatically sends

ami

instance_type

instance_name

to Terraform.

Exactly like

terraform apply -var ...

but automatically.

Installing Terragrunt

Windows

winget install Terragrunt.Terragrunt

or

choco install terragrunt

Linux

wget https://github.com/gruntwork-io/terragrunt/releases/latest/download/terragrunt_linux_amd64

chmod +x terragrunt_linux_amd64

sudo mv terragrunt_linux_amd64 /usr/local/bin/terragrunt

Verify

terragrunt --version

Example

Terragrunt version v0.89.x
Commands

Initialize

terragrunt init

Plan

terragrunt plan

Apply

terragrunt apply

Destroy

terragrunt destroy

Format

terragrunt hclfmt

Validate

terragrunt validate
Execution

Go inside

live/dev

Run

terragrunt init

Then

terragrunt plan

Then

terragrunt apply

For Production

cd live/prod
terragrunt apply

Same Terraform code.

Different inputs.

Advantages

✅ No terraform.tfvars

✅ No duplicate backend files

✅ No duplicate provider files

✅ Reusable modules

✅ Easier multi-environment management

✅ Better folder organization

✅ Supports dependencies between modules

✅ Generates backend configuration automatically

Difference
Terraform	Terragrunt
Uses terraform.tfvars	Uses terragrunt.hcl
Duplicate code	Reuses modules
Backend repeated	Backend can be generated automatically
Provider repeated	Shared configuration
Good for small projects	Better for large/multi-environment projects
Interview Answer (2–3 minutes)

Terragrunt is a wrapper around Terraform that helps manage infrastructure across multiple environments such as development, QA, and production. Instead of maintaining separate terraform.tfvars, backend, and provider files for each environment, Terragrunt centralizes the Terraform module and passes environment-specific values through terragrunt.hcl. This reduces code duplication, improves maintainability, and makes it easier to manage remote state and module dependencies. We use the standard Terraform workflow through Terragrunt commands like terragrunt init, terragrunt plan, and terragrunt apply, while Terragrunt invokes Terraform under the hood.

This example is sufficient to complete your assignment and also gives you a solid understanding of what Terragrunt is, why it's used, how it replaces terraform.tfvars, the folder structure, commands, and execution flow.

You have given the example for EC2. So what if there are other modules also? Other resources also, VPC, instance, security group, RDS, and how it works, how to call it from, first of all, how to modules, modules will be separate, right? VPC one folder, EC2 one folder, RDS one folder, okay? So while giving inputs, how we call? Do we call multiple sources in Terraform block, inside input? So give me examples for that, small example, no lengthy, okay?

Excellent question. This is actually how Terragrunt is used in real companies.

The answer is No. One terragrunt.hcl points to only one Terraform module.

You cannot do this:

terraform {
  source = "../../modules/vpc"
  source = "../../modules/ec2"   # ❌ Not allowed
  source = "../../modules/rds"   # ❌ Not allowed
}

Only one source is allowed.

Real Project Structure
project/

modules/
├── vpc/
│     main.tf
│     variables.tf
│
├── ec2/
│     main.tf
│     variables.tf
│
├── rds/
│     main.tf
│     variables.tf
│
└── security-group/
      main.tf
      variables.tf

live/
└── dev/
      ├── vpc/
      │      terragrunt.hcl
      │
      ├── security-group/
      │      terragrunt.hcl
      │
      ├── ec2/
      │      terragrunt.hcl
      │
      └── rds/
             terragrunt.hcl

Notice that every module has its own terragrunt.hcl.

Example 1 - VPC
live/dev/vpc/terragrunt.hcl
terraform {
  source = "../../../modules/vpc"
}

inputs = {
  vpc_cidr = "10.0.0.0/16"
}
Example 2 - Security Group
live/dev/security-group/terragrunt.hcl
terraform {
  source = "../../../modules/security-group"
}

inputs = {
  sg_name = "web-sg"
}
Example 3 - EC2
live/dev/ec2/terragrunt.hcl
terraform {
  source = "../../../modules/ec2"
}

inputs = {
  instance_type = "t2.micro"
}
Example 4 - RDS
live/dev/rds/terragrunt.hcl
terraform {
  source = "../../../modules/rds"
}

inputs = {
  db_name = "mydb"
}
Then how does EC2 know the VPC ID?

This is where Terragrunt's dependency feature is used.

VPC module outputs
output "vpc_id" {
  value = aws_vpc.main.id
}
EC2 terragrunt.hcl
dependency "vpc" {
  config_path = "../vpc"
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}

Terragrunt automatically reads the output from the VPC module and passes it as an input to the EC2 module.

RDS using VPC output
dependency "vpc" {
  config_path = "../vpc"
}

terraform {
  source = "../../../modules/rds"
}

inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}
EC2 using Security Group output

Security group module:

output "sg_id" {
  value = aws_security_group.web.id
}

EC2:

dependency "sg" {
  config_path = "../security-group"
}

terraform {
  source = "../../../modules/ec2"
}

inputs = {
  security_group_id = dependency.sg.outputs.sg_id
}
Final flow
modules/
    vpc/
    ec2/
    rds/
    security-group/

           ↑
           │
   terragrunt source

live/
    dev/
       vpc/
       ec2/
       rds/
       security-group/

Each terragrunt.hcl:

Points to one module using source.
Passes values through inputs.
Reads outputs from other modules using dependency when needed.

This is the pattern you'll see in most production Terragrunt repositories. It keeps modules independent while allowing them to share information like VPC IDs, subnet IDs, or security group IDs without hardcoding values.