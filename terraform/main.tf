provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

provider "aws" {
  alias  = "ap-southeast-1"
  region = "ap-southeast-1"
}

provider "aws" {
  alias  = "eu-central-1"
  region = "eu-central-1"
}

provider "aws" {
  alias  = "sa-east-1"
  region = "sa-east-1"
}

module "us-west" {
  source                  = "lnx"
  region                  = "us-west-1"

  providers = {
    aws = "aws.us-west-1"
  }

  ln_banner               = "1.ln.glass"
  public_hostname         = "1.ln.glass"
  availability_zones      = ["us-west-1a", "us-west-1c"]
  environment             = "${var.environment}"
  ssh_public_key          = "${var.ssh_public_key}"
  iam_instance_profile_id = "${aws_iam_instance_profile.ecs.id}"
  instance_type           = "m5.large"                           # m5a not available
}
