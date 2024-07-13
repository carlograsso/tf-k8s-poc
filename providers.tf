provider "aws" {
    region = "eu-south-1"
    profile = var.profile

    default_tags {
        tags = {
            environment     = "Demo"
            terraform       = "True"
            carlo           = "True"
        }
    }
}
