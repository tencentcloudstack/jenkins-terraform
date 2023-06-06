output "cos_bucket" {
  value = concat(tencentcloud_cos_bucket.cos.*.id, [""])[0]
}

output "bucket_url" {
  value = concat(tencentcloud_cos_bucket.cos.*.cos_bucket_url, [""])[0]
}