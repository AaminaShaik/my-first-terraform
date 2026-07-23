provider "aws" {
    profile = "dev"
    alias = "dev-account"
    region = "us-east-1"
}
# aws configure --profile dev

# Tip: You can deliver temporary credentials to the AWS CLI using your AWS Console session by running the command 'aws login'.

# AWS Access Key ID [None]: xxxxxxxxxxxxxxxxx
# AWS Secret Access Key [None]: Xxxxxxxxxxxxxxxxx
# Default region name [None]: us-east-1
# Default output format [None]: json


provider "aws" {
    profile = "test"
    alias = "test-account"
    region = "us-west-2"
}
# aws configure --profile test

# Tip: You can deliver temporary credentials to the AWS CLI using your AWS Console session by running the command 'aws login'.

# AWS Access Key ID [None]: xxxxxxxxxxxxxxxxx
# AWS Secret Access Key [None]: xxxxxxxxxxxxxxxxxxxxxx
# Default region name [None]: us-west-2
# Default output format [None]: json
#  aws configure list-profiles
# default
# dev
# test