module "hello" {
  source = "git::ssh://git@github.com/POps-Rox/tf-gh-actions//tests/workflows/test-ssh/test-module"
}

output "word" {
  value = module.hello.my-output
}
