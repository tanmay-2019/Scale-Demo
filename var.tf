variable "role_name" {
    default = "lambda-demo"
  }
variable "lambda_timeout" {
  description = "Lambda timeout"
  default = "80"
}
variable "bucket_name" {
  description = "Bucket Name"
  default = "tt-demo-09"
}
variable "table_name" {
  description = "Dynamo DB table name"
  default = "tt-demo"
}
variable "api_name" {
  description = "API name"
  default = "api-test"
}