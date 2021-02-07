# --- main root ---
module "stactic_web" {
  source = "./s3_cloudf_module"
  s3_count = 2
}