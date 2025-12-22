locals {
  domain_name  = "justinkim.app"
  github_owner = "HJK-X"
  github_repo  = "blog"
}


module "landing_page" {
  source = "./modules/cloudflare-pages"

  account_id        = var.cloudflare_account_id
  name              = "landing"
  github_owner      = local.github_owner
  github_repo       = local.github_repo
  production_branch = "main"

  root_dir        = "landing"
  destination_dir = "public"
}
