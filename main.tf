# --- main root ---
module "stactic_web" {
  source = "./s3_module"
  s3_count = 1
  
}