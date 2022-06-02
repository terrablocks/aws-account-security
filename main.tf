data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

resource "aws_iam_account_password_policy" "this" {
  count                          = var.enable_password_policy ? 1 : 0
  minimum_password_length        = var.minimum_password_length
  require_uppercase_characters   = var.require_uppercase_characters
  require_lowercase_characters   = var.require_lowercase_characters
  require_numbers                = var.require_numbers
  require_symbols                = var.require_symbols
  allow_users_to_change_password = var.allow_users_to_change_password
  password_reuse_prevention      = var.password_reuse_prevention
  max_password_age               = var.max_password_age
  hard_expiry                    = var.hard_expiry
}

resource "aws_s3_account_public_access_block" "this" {
  count                   = var.enable_s3_account_public_access_block ? 1 : 0
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_ebs_encryption_by_default" "this" {
  enabled = var.enable_ebs_encryption
}

data "aws_kms_key" "ebs" {
  key_id = var.ebs_encryption_key
}

resource "aws_ebs_default_kms_key" "ebs" {
  count   = var.enable_ebs_encryption ? 1 : 0
  key_arn = data.aws_kms_key.ebs.arn
}

# Access Analyzer
resource "aws_accessanalyzer_analyzer" "this" {
  count         = var.enable_accessanalyzer ? 1 : 0
  analyzer_name = var.analyzer_name
  analyzer_type = var.analyzer_type
}

# Macie
resource "aws_macie2_account" "this" {
  count                        = var.enable_macie ? 1 : 0
  finding_publishing_frequency = var.macie_publishing_frequency
  status                       = var.enable_macie ? "ENABLED" : "PAUSED"
}

# GuardDuty
resource "aws_guardduty_detector" "this" {
  count  = var.enable_guardduty ? 1 : 0
  enable = var.enable_guardduty

  datasources {
    s3_logs {
      enable = true
    }
  }
}

# Security Hub
resource "aws_securityhub_account" "this" {
  count = var.enable_securityhub ? 1 : 0
}

resource "aws_securityhub_product_subscription" "macie" {
  count       = var.enable_macie ? 1 : 0
  product_arn = "arn:aws:securityhub:${data.aws_region.current.name}::product/aws/macie"
  depends_on  = [aws_securityhub_account.this]
}

resource "aws_securityhub_product_subscription" "guardduty" {
  count       = var.enable_guardduty ? 1 : 0
  product_arn = "arn:aws:securityhub:${data.aws_region.current.name}::product/aws/guardduty"
  depends_on  = [aws_securityhub_account.this]
}

resource "aws_securityhub_standards_subscription" "cis" {
  count         = var.enable_securityhub_cis_benchmark ? 1 : 0
  standards_arn = "arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0"
  depends_on    = [aws_securityhub_account.this]
}

resource "aws_securityhub_standards_subscription" "pci_dss" {
  count         = var.enable_securityhub_pci_dss_benchmark ? 1 : 0
  standards_arn = "arn:aws:securityhub:us-east-1::standards/pci-dss/v/3.2.1"
  depends_on    = [aws_securityhub_account.this]
}
