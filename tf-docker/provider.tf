provider "aws" {
  # aqui eu chamo uma variável que está no arquivo variables.tf
  region = var.aws_region
}
