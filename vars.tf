variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of key-value pair to associate with resources"
}

# IAM Password Policy
variable "enable_password_policy" {
  type        = bool
  default     = true
  description = "Whether to enable AWS account level password policy for users"
}

variable "minimum_password_length" {
  type        = number
  default     = 16
  description = "Minimum length of a user's console login password"
}

variable "require_uppercase_characters" {
  type        = bool
  default     = true
  description = "Whether atleast one uppercase character is required in the password"
}

variable "require_lowercase_characters" {
  type        = bool
  default     = true
  description = "Whether atleast one lowercase character is required in the password"
}

variable "require_numbers" {
  type        = bool
  default     = true
  description = "Whether atleast one number is required in the password"
}

variable "require_symbols" {
  type        = bool
  default     = true
  description = "Whether atleast one symbol is required in the password"
}

variable "allow_users_to_change_password" {
  type        = bool
  default     = true
  description = "Whether to let users to change their own password"
}

variable "password_reuse_prevention" {
  type        = bool
  default     = 25
  description = "Number of previous passwords user should not be allowed to use"
}

variable "max_password_age" {
  type        = number
  default     = 90
  description = "Days after which password will expire and needs to be reset either by admin or user"
}

variable "hard_expiry" {
  type        = bool
  default     = false
  description = "Prevent users from resetting their own password upon expiration. Only allow admin to reset the password"
}

# S3 Public Access Block
variable "enable_s3_account_public_access_block" {
  type        = bool
  default     = true
  description = "Whether to enable S3 public access block at account level"
}

variable "block_public_acls" {
  type        = bool
  default     = true
  description = "Whether to prevent users from adding public ACLs to any bucket in this account"
}

variable "block_public_policy" {
  type        = bool
  default     = true
  description = "Whether to prevent users from adding a public policy to any bucket in this account"
}

variable "ignore_public_acls" {
  type        = bool
  default     = true
  description = "Whether to ignore existing public ACLs set for any existing bucket in this account"
}

variable "restrict_public_buckets" {
  type        = bool
  default     = true
  description = "Whether to restrict public bucket policies for buckets in this account"
}

# EBS Encryption
variable "enable_ebs_encryption" {
  type        = bool
  default     = true
  description = "Whether to enable EBS encryption by default at account level"
}

variable "ebs_encryption_key" {
  type        = string
  default     = "alias/aws/ebs"
  description = "ID/Alias/ARN of the KMS key to use by default for EBS encryption"
}
