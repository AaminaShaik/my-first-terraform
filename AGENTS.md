# AI Agent Instructions for my-first-terraform

This workspace is a **progressive Terraform learning repository** with AWS infrastructure examples organized by learning topic across Day 1–Day 6.

## Project Structure

```
my-first-terraform/
├── Day-1-installations/          # Setup steps only
├── Day-2-terraform-configuration/ # HCL basics: VPC + Subnet
├── Day-3-input-variables/         # Variable declaration patterns
├── Day-3-statefile/               # Local state management
├── Day-3-terraform.tfvars/        # Multiple tfvars files (dev.tfvars)
├── Day-4-statelocking/            # Remote S3 backend + DynamoDB locking
├── Day-6-custom-network-configure/ # Active development (WIP)
└── README.md
```

**Key convention**: Each Day is independent with its own state—read from Day-2 onward to understand progression.

## Terraform Patterns & Conventions

### File Organization (per Day folder)
Every Terraform directory uses this standard layout:
```
├── main.tf              # Resource definitions (aws_vpc, aws_subnet, aws_ec2, aws_s3_bucket)
├── provider.tf          # AWS provider config
├── variable.tf          # Input variable declarations
├── backend.tf           # Remote state backend (S3 in Day 4+)
├── terraform.tfvars     # Variable values
├── dev.tfvars          # Environment-specific overrides
├── terraform.tfstate    # Generated state (do not edit)
└── terraform.tfstate.backup # Generated backup (do not edit)
```

### Variable Declaration Pattern
All variables follow this structure in `variable.tf`:
```hcl
variable "variable_name" {
  description = "human-readable description"
  type        = string
  default     = ""
}
```
- **Naming**: snake_case with semantic suffixes (`_vpc`, `_subnet`, `_ec2`)
- **Types**: Primarily strings (keep it simple for learning)
- **Defaults**: Empty strings allow runtime override via `-var` or tfvars files

### Resource Naming Convention
Generic logical names (intentional for teaching):
```hcl
resource "aws_vpc" "name" {
  cidr_block = var.cidr_block_vpc
  tags = {
    Name = var.tags_vpc
  }
}
```
Note: Production projects would use descriptive names like `prod_vpc`, `api_subnet`.

### CIDR Block Strategy
- **VPC**: `10.0.0.0/16` (65,536 addresses)
- **Subnet**: `10.0.0.0/24` (256 addresses)
- These are private RFC 1918 ranges for production readiness

### Backend & State Management
Remote state configuration appears in `backend.tf` (Day 3b onward):
```hcl
terraform {
  backend "s3" {
    bucket         = "bucket-name"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true  # DynamoDB locking for team concurrency
  }
}
```

## Standard Terraform Workflow

```bash
terraform init          # Initialize (download providers)
terraform plan          # Preview changes
terraform apply         # Apply infrastructure
terraform destroy       # Tear down resources
terraform apply -var-file="dev.tfvars"  # Apply with env-specific values
```

## Key Points for Agents

1. **State files are generated** — never edit `.tfstate` or `.tfstate.backup` manually
2. **Learning progression matters** — Day-2 is foundational; later days build on concepts
3. **Variables are parametrized** — always use `var.variable_name` for flexibility
4. **Tag every resource** — follow the `Name = var.tags_*` pattern
5. **Naming is intentionally simple** — resource logical names like "name" are teaching choices, not production patterns
6. **Day 6 is WIP** — the custom-network-configure folder is under development
7. **No cross-Day dependencies** — each Day is independent (separate state)

## AWS Resources Covered

| Day | Primary Resources |
|-----|-------------------|
| Day 2 | `aws_vpc`, `aws_subnet` |
| Day 3a | `aws_instance` (EC2) |
| Day 3b | State management (no new resources) |
| Day 4 | `aws_s3_bucket` (for Terraform state), EC2 + S3 for locking |
| Day 6 | VPC customization (in progress) |

---

**For more details**, see [README.md](README.md)
