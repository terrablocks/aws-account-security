# Setup baseline security as per AWS best practices

![License](https://img.shields.io/github/license/terrablocks/aws-account-security?style=for-the-badge) ![Tests](https://img.shields.io/github/actions/workflow/status/terrablocks/aws-account-security/tests.yml?branch=main&label=Test&style=for-the-badge) ![Checkov](https://img.shields.io/github/actions/workflow/status/terrablocks/aws-account-security/checkov.yml?branch=main&label=Checkov&style=for-the-badge) ![Commit](https://img.shields.io/github/last-commit/terrablocks/aws-account-security?style=for-the-badge) ![Release](https://img.shields.io/github/v/release/terrablocks/aws-account-security?style=for-the-badge)

This terraform module will setup the following services:
- IAM Password Policy
- S3 Account Public Access Block
- EBS Default Encryption

# Usage Instructions
## Example
```terraform
module "security" {
  source = "github.com/terrablocks/aws-account-security.git"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0.2 |
| aws | >= 3.64.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| tags | Map of key-value pair to associate with resources | `map(string)` | `{}` | no |
| enable_password_policy | Whether to enable AWS account level password policy for users | `bool` | `true` | no |
| minimum_password_length | Minimum length of a user's console login password | `number` | `16` | no |
| require_uppercase_characters | Whether atleast one uppercase character is required in the password | `bool` | `true` | no |
| require_lowercase_characters | Whether atleast one lowercase character is required in the password | `bool` | `true` | no |
| require_numbers | Whether atleast one number is required in the password | `bool` | `true` | no |
| require_symbols | Whether atleast one symbol is required in the password | `bool` | `true` | no |
| allow_users_to_change_password | Whether to let users to change their own password | `bool` | `true` | no |
| password_reuse_prevention | Number of previous passwords user should not be allowed to use | `number` | `25` | no |
| max_password_age | Days after which password will expire and needs to be reset either by admin or user | `number` | `90` | no |
| hard_expiry | Prevent users from resetting their own password upon expiration. Only allow admin to reset the password | `bool` | `false` | no |
| enable_s3_account_public_access_block | Whether to enable S3 public access block at account level | `bool` | `true` | no |
| block_public_acls | Whether to prevent users from adding public ACLs to any bucket in this account | `bool` | `true` | no |
| block_public_policy | Whether to prevent users from adding a public policy to any bucket in this account | `bool` | `true` | no |
| ignore_public_acls | Whether to ignore existing public ACLs set for any existing bucket in this account | `bool` | `true` | no |
| restrict_public_buckets | Whether to restrict public bucket policies for buckets in this account | `bool` | `true` | no |
| enable_ebs_encryption | Whether to enable EBS encryption by default at account level | `bool` | `true` | no |
| ebs_encryption_key | ID/Alias/ARN of the KMS key to use by default for EBS encryption | `string` | `"alias/aws/ebs"` | no |
| analyzer_name | Name for access analyzer | `string` | `"permissions-analyzer"` | no |
| analyzer_type | Type of access analyzer to create. **Valid values:** `ACCOUNT` or `ORGANIZATION` | `string` | `"ACCOUNT"` | no |
| enable_macie | Whether to enable Macie and start all the Macie activities for the account | `bool` | `true` | no |
| macie_publishing_frequency | How often to publish findings to CloudWatch Events about the account. **Valid Values: `FIFTEEN_MINUTES`, `ONE_HOUR` or `SIX_HOURS`** | `string` | `"FIFTEEN_MINUTES"` | no |
| enable_guardduty | Enable GuardDuty service for the account | `bool` | `true` | no |
| enable_securityhub | Whether to enable security hub for the account | `bool` | `true` | no |
| enable_securityhub_cis_benchmark | Whether to enable CIS benchmark checks for the account | `bool` | `true` | no |
| enable_securityhub_pci_dss_benchmark | Whether to enable PCI DSS benchmark checks for the account | `bool` | `true` | no |

## Outputs

No outputs.
