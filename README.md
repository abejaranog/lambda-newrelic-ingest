# lambda-newrelic-ingest
Terragrunt repository to deploys a empty lambda ready to ingest logs to a New Relic Account

## Requirements

- Terraform 0.14
- Terragrunt >= 0.27.0

You need to use terragrunt instead of terraform to init, apply and destroy commands.

Also, as a consideration, you _MUST_ leave blank the License Key variable and fill it in a secure form before lambda runs.
## Terraform Docs
### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_iam_policy.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.integration_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.lambda_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.integrations_config_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.lambda_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.read_only_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.test_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_secretsmanager_secret.new_relic_license_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.new_relic_license_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_iam_policy_document.integrations_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AWS_account"></a> [AWS\_account](#input\_AWS\_account) | AWS Account to be deployed the stack in | `string` | n/a | yes |
| <a name="input_AWS_region"></a> [AWS\_region](#input\_AWS\_region) | AWS Region | `string` | `"us-west-2"` | no |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Lambda Name | `string` | n/a | yes |
| <a name="input_newrelic_account_id"></a> [newrelic\_account\_id](#input\_newrelic\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_newrelic_keymap"></a> [newrelic\_keymap](#input\_newrelic\_keymap) | New Relic API key | `map(string)` | <pre>{<br>  "LicenseKey": ""<br>}</pre> | no |

## Additional Documentation
[Terragrunt](https://terragrunt.gruntwork.io/docs/#getting-started)

[New Relic Lambda Layer](https://newrelic.com/blog/nerdlog/aws-lambda-layer-serverless-monitoring-instrumentation)