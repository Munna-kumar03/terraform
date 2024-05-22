resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "log"
    enabled = true

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    expiration {
      days = 365
    }
  }
}

resource "aws_iam_policy" "s3_access_policy" {
  name        = "${var.bucket_name}-access-policy"
  description = "Policy to allow specific user access to a folder in the bucket"
  policy      = data.aws_iam_policy_document.s3_access_policy.json
}

data "aws_iam_policy_document" "s3_access_policy" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      "arn:aws:s3:::${var.bucket_name}/${var.folder_name}/*"
    ]

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [var.user_arn]
    }
  }
}

resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = var.user_name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}
