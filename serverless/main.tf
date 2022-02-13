resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

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

resource "aws_iam_policy_attachment" "dynamo-attach" {
  name       = "dynamodb-attachment"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_policy_attachment" "s3-attach" {
  name       = "dynamodb-attachment"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}
resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.func.arn
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket.arn
}

resource "aws_lambda_function" "func" {
  filename      = "your-functio.zip"
  function_name = "s3todynamodb"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "main.lambda_handler"
  runtime       = "python3.8"
  timeout       = 900
  environment {
    variables = {
      bucket = "serverless-csvapp-bucket"
      key = "testfile.csv"
      table = "csvdetail"
    }
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "serverless-csvapp-bucket"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.func.arn
    events              = ["s3:ObjectCreated:*"]
    #filter_prefix       = "AWSLogs/"
    filter_suffix       = ".csv"
  }

  depends_on = [aws_lambda_permission.allow_bucket]
}


resource "aws_dynamodb_table" "my_first_table" {
  name        = "csvdetail"
  billing_mode = "PAY_PER_REQUEST"
  hash_key       = "uuid"
  attribute {
    name = "uuid"
    type = "S"
  }
   tags = {
    environment       = "dev"
  }
}