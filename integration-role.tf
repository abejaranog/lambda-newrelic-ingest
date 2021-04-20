#########################################
### IAM Role to New Relic Integration ###
#########################################
resource "aws_iam_role" "integration_role" {
  name = "NewRelicLambdaIntegrationRole_${var.newrelic_account_id}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::754728514883:root"
      },
      "Action": "sts:AssumeRole",
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${var.newrelic_account_id}"
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "read_only_attach" {
  role       = aws_iam_role.integration_role.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

resource "aws_iam_role_policy" "integrations_config_policy" {
  name   = "NewRelicAWSConfig"
  role   = aws_iam_role.integration_role.id
  policy = data.aws_iam_policy_document.integrations_policy.json
}

data "aws_iam_policy_document" "integrations_policy" {
  statement {
    sid       = "IntegrationsConfig"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["config:BatchGetResourceConfig"]
  }
}