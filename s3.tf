#
# criação do bucket
#
resource "aws_s3_bucket" "bootcamp-s3" {
  bucket = "cloudtreinamentos-bootcamp9"

  tags = {
    Name = "cloudtreinamentos-bootcamp9"
  }
}
#
# definindo de quem é o bucket
#
resource "aws_s3_bucket_ownership_controls" "bootcamp-control_owner" {
  bucket = aws_s3_bucket.bootcamp-s3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
#
# definindo regras de acesso publico
#

resource "aws_s3_bucket_public_access_block" "bootcamp_block_access" {
  bucket = aws_s3_bucket.bootcamp-s3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
#
# ACLs do bucket
#
resource "aws_s3_bucket_acl" "bootcamp-acl" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bootcamp-control_owner,
    aws_s3_bucket_public_access_block.bootcamp_block_access,
  ]

  bucket = aws_s3_bucket.bootcamp-s3.id
  acl    = "public-read"
}
resource "aws_s3_bucket_website_configuration" "bootcamp-config-website" {
  bucket = aws_s3_bucket.bootcamp-s3.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}
#
# politicas do IAM
#
data "aws_iam_policy_document" "allow_access_from_another_account" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.bootcamp-s3.arn,
      "${aws_s3_bucket.bootcamp-s3.arn}/*",
    ]
  }
}
#
# politica do bucket
#
resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.bootcamp-s3.id
  policy = data.aws_iam_policy_document.allow_access_from_another_account.json
}

