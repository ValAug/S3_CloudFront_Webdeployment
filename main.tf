# --- main root ---

 # module.stactic_web will be creating resource such aws cloudfront distribution for an S3 bucket with web static files.
module "static_web_01" {
  source = "./s3_module_1"
  s3_count = var.bucket_count
  
}

# module.dns will be creating resource such aws cloudfront origin OAI for an S3 bucket with web static files.
module "static_web_02" {
  source   = "./s3_module_2"
  s3_count = var.bucket_count
  
}