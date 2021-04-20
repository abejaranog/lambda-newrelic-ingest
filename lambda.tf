#######################
### Lambda Creation ###
#######################

resource "aws_lambda_function" "test_lambda" {
  filename      = "./src/lambda.zip"
  function_name = var.lambda_name
  role          = aws_iam_role.lambda_role.arn
  handler       = "newrelic_lambda_wrapper.handler"
  runtime       = "python3.7"
  layers = ["arn:aws:lambda:us-west-2:451483290750:layer:NewRelicPython37:41"]
  environment {
    variables = {
      NEW_RELIC_ACCOUNT_ID = var.newrelic_account_id,
      NEW_RELIC_LAMBDA_HANDLER = "lambda.main",
      NEW_RELIC_EXTENSION_SEND_FUNCTION_LOGS = true,
      NEW_RELIC_LAMBDA_EXTENSION_ENABLED = true
    }
  }
}

##################################
### IAM Roles needed by Lambda ###
##################################
resource "aws_iam_role" "lambda_role" {
  name = "${var.lambda_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "lambda_policy" {
  name        = "${var.lambda_name}-policy"
  description = "Policy used by ${aws_iam_role.lambda_role.name}"
  policy      = data.aws_iam_policy_document.lambda_policy.json
}


resource "aws_iam_role_policy_attachment" "lambda_attach" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}
data "aws_iam_policy_document" "lambda_policy" {
  # statement {
  #   sid       = "CWLogGroup"
  #   effect    = "Allow"
  #   resources = ["arn:aws:logs:${var.AWS_region}:${var.AWS_account}:*"]
  #   actions   = ["logs:CreateLogGroup"]
  # }

  # statement {
  #   sid       = "CWLogStream"
  #   effect    = "Allow"
  #   resources = ["arn:aws:logs:${var.AWS_region}:${var.AWS_account}:log-group:/aws/lambda/${var.lambda_name}:*"]

  #   actions = [
  #     "logs:CreateLogStream",
  #     "logs:PutLogEvents",
  #   ]
  # }

  statement {
    sid       = "SecretsManager"
    effect    = "Allow"
    resources = [aws_secretsmanager_secret.new_relic_license_key.arn]
    actions   = ["secretsmanager:GetSecretValue"]
  }
}
