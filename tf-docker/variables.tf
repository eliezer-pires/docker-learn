variable "aws_region" {
  description = "Região da AWS"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Nome do bucket S3 para armazenar o state"
  type        = string
}

variable "dynamodb_table" {
  description = "Nome da tabela DynamoDB para armazenar o lock do state"
  type        = string
}