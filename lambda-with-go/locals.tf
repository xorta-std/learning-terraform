locals {
  dist_path = "dist"
  binary_name  = "my_lambda"
  src_path     = "myapp"

  binary_path  = "${local.dist_path}/${local.binary_name}"
  archive_path = "${local.binary_path}.zip"
}
