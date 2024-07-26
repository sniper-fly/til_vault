provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      name = "obsidian_til"
      created_by = "terraform"
    }
  }
}
