# configure aws provider
provider "aws" {
  region  = var.region
  profile = "my_profile"
}