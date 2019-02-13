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

module "us-east" {
  source                  = "lnx"
  region                  = "us-east-1"

  ln_banner               = "1.ln.glass"
  public_hostname         = "1.ln.glass"
  availability_zones      = ["us-east-1a", "us-east-1b"]
  environment             = "${var.environment}"
  ssh_public_key          = "${var.ssh_public_key}"
  iam_instance_profile_id = "${aws_iam_instance_profile.ecs.id}"
  instance_type           = "m5a.large"
}

module "us-west" {
  source                  = "lnx"
  region                  = "us-west-1"

  providers = {
    aws = "aws.us-west-1"
  }

  ln_banner               = "2.ln.glass"
  public_hostname         = "2.ln.glass"
  availability_zones      = ["us-west-1a", "us-west-1c"]
  environment             = "${var.environment}"
  ssh_public_key          = "${var.ssh_public_key}"
  iam_instance_profile_id = "${aws_iam_instance_profile.ecs.id}"
  instance_type           = "m5.large"                           # m5a not available
}

module "ap-southeast" {
  source                  = "lnx"
  region                  = "ap-southeast-1"

  providers = {
    aws = "aws.ap-southeast-1"
  }

  ln_banner               = "3.ln.glass"
  public_hostname         = "3.ln.glass"
  availability_zones      = ["ap-southeast-1b", "ap-southeast-1c"]
  environment             = "${var.environment}"
  ssh_public_key          = "${var.ssh_public_key}"
  iam_instance_profile_id = "${aws_iam_instance_profile.ecs.id}"
  instance_type           = "m5a.large"
}

module "eu-central" {
  source                  = "lnx"
  region                  = "eu-central-1"

  providers = {
    aws = "aws.eu-central-1"
  }

  ln_banner               = "4.ln.glass"
  public_hostname         = "4.ln.glass"
  availability_zones      = ["eu-central-1b", "eu-central-1c"]
  environment             = "${var.environment}"
  ssh_public_key          = "${var.ssh_public_key}"
  iam_instance_profile_id = "${aws_iam_instance_profile.ecs.id}"
  instance_type           = "m5.large"                           # m5a not available
}

module "sa-east" {
  source                  = "lnx"
  region                  = "sa-east-1"

  providers = {
    aws = "aws.sa-east-1"
  }

  ln_banner               = "5.ln.glass"
  public_hostname         = "5.ln.glass"
  availability_zones      = ["sa-east-1b", "sa-east-1c"]
  environment             = "${var.environment}"
  ssh_public_key          = "${var.ssh_public_key}"
  iam_instance_profile_id = "${aws_iam_instance_profile.ecs.id}"
  instance_type           = "m5.large"                           # m5a not available
}
