# ---------------------------------------------------------------------
# KMS
# ---------------------------------------------------------------------
resource "aws_kms_key" "kms_key_sac" {
  description              = "KMS key template"
  deletion_window_in_days  = 10
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  key_usage                = "GENERATE_VERIFY_MAC"
  enable_key_rotation      = false
  is_enabled               = false

  policy = <<EOF
  # oak9: KMS key policy allows any action using * (wildcards)
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Describe the policy statement",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "*",
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "kms:KeySpec": "SYMMETRIC_DEFAULT"
        }
      }
    }
  ]
}
EOF
}


resource "aws_kms_alias" "kms_alias_sac" {
  name          = "kms-alias-sac"
  target_key_id = aws_kms_key.kms_key_sac.key_id
  
}