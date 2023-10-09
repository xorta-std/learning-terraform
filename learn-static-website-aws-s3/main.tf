terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}


provider "aws" {
  region = var.region
  profile = var.deploy_profile
}

resource "aws_s3_bucket" "my_static_website" {
  bucket = var.bucket_name

  tags = {
    Name = "my-static-website"
  }
}

resource "aws_s3_bucket_website_configuration" "my-static-website" {
  bucket = aws_s3_bucket.my_static_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# S3 bucket ACL access

resource "aws_s3_bucket_ownership_controls" "my_static_website" {
  bucket = aws_s3_bucket.my_static_website.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "my_static_website" {
  bucket = aws_s3_bucket.my_static_website.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "my_static_website" {
  depends_on = [
    aws_s3_bucket_ownership_controls.my_static_website,
    aws_s3_bucket_public_access_block.my_static_website,
  ]

  bucket = aws_s3_bucket.my_static_website.id
  acl    = "public-read"
}



resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = aws_s3_bucket.my_static_website.id

  policy = <<POLICY
{
  "Id": "Policy",
  "Statement": [
    {
      "Action": [
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.my_static_website.bucket}/*",
      "Principal": {
        "AWS": [
          "*"
        ]
      }
    }
  ]
}
POLICY
}
