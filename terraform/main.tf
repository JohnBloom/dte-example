provider "aws" {
  region = "us-east-1"
}

variable "region" {
  description = "Region of setup"
  default = "us-east-1"
}
resource "aws_dynamodb_table" "wordvice" {
  name = "wordvice-posts"
  read_capacity = 5
  write_capacity = 5
  hash_key = "date"
  attribute {
    name = "date"
    type = "N"
  }
}
