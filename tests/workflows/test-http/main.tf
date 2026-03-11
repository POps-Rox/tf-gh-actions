module "git_https_source" {
  source = "git::https://github.com/POps-Rox/tf-gh-actions.git//tests/workflows/test-http/test-module"
}

output "git_https" {
  value = module.git_https_source.my-output
}
