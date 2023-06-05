# ---------------------------------------------------------------------
# IAM
# ---------------------------------------------------------------------
resource "aws_iam_role" "sac_iam_role" {
  name = "${local.name}-eks-developer-role"
  managed_policy_arns = "arn:aws:iam::aws:policy/AdministratorAccess"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "*"
        Effect = "Allow"
        Resource = "*"
        Principal = "*"
      },
    ]
  })
  inline_policy {
    name = "eks-developer-access-policy"
    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Principal = "*"
          Action   = "*"
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }    
}

resource "aws_iam_role_policy_attachment" "eks-developrole-s3fullaccess" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.sac_iam_role.name
}

data "aws_iam_policy_document" "sac_iam_managed_policy" {
  statement {
    actions = "*"
    resources = ["*"]

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "kms:EncryptionContext:service"
      values   = ["pi"]
    }
  }
}

resource "aws_iam_group" "sac_iam_group" {
  name = "sac-iam-group"
  path = "/users/"
}

resource "aws_iam_group_policy" "sac_iam_group_policy" {
  name  = "sac-iam-group-policy"
  group = aws_iam_group.sac_iam_group.name

  policy = jsonencode({
    # oak9: Explicitly define resources in group policies
    # oak9: Avoid using wildcards ['*'] in IAM actions
    Version = "2012-10-17"
    Statement = [
      {
        Action = "*"
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}