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
  count   = var.var.enable_ebs_encryption ? 1 : 0
  key_arn = data.aws_kms_key.ebs.arn
}
