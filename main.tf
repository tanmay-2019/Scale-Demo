resource "aws_lambda_function" "test_lambda" {
  filename      = "create.py"
  function_name = "create"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  lambda_timeout= "80"
  source_code_hash = filebase64sha256("testcr.py")
  runtime = "python3.8"

}

resource "aws_lambda_function" "test_lambda2" {
  filename      = "read.py"
  function_name = "read"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  lambda_timeout= "80"
  source_code_hash = filebase64sha256("testre.py")
  runtime = "python3.8"

}

resource "aws_lambda_function" "test_lambda3" {
  filename      = "update.py"
  function_name = "update"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  lambda_timeout= "80"
  source_code_hash = filebase64sha256("testup.py")
  runtime = "python3.8"

}

resource "aws_lambda_function" "test_lambda3" {
  filename      = "delete.py"
  function_name = "delete"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  lambda_timeout= "80"
  source_code_hash = filebase64sha256("testdl.py")
  runtime = "python3.8"

}

resource "aws_s3_bucket" "bucket" {

  bucket = "tt-demo-09"
  acl    = "private"   
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = aws_s3_bucket.bucket.id
  key    = "profile"
  acl    = "private" 
  source = "myfiles/tt-demo.csv"
  etag = filemd5("myfiles/tt-demo.csv")

}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.test_lambda.arn
    events              = ["s3:ObjectCreated:*"]
  }

}

resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "tt-demo"
  hash_key       = "id"
}

resource "aws_api_gateway_rest_api" "test" {
  name = "api-test"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}


resource "aws_iam_role" "iam_for_lambda" {
  name = "lambda_demo"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy1" {
  name        = "tt-policy-1"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "policy2" {
  name        = "tt-policy-2"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "dynamodb:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "attach1" {
  name       = "file1"
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy1.arn
}

resource "aws_iam_policy_attachment" "attach2" {
  name       = "file2"
  roles      = [aws_iam_role.role.name]
  policy_arn = aws_iam_policy.policy2.arn
}

