output "website_url" {
  value = "http://${aws_s3_bucket.my_static_website.bucket}.s3-website.${var.region}.amazonaws.com"
}
