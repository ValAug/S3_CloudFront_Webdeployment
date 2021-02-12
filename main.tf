# --- main root ---
module "stactic_web" {
  source = "./s3_module_1"
  s3_count = 1
  
}

module "dns" {
  source   = "./s3_module_2"
  s3_count = 1
  
}