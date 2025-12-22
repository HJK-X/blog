locals {
  domain       = "justinkim.app"
  github_owner = "HJK-X"
  github_repo  = "blog"
}

data "cloudflare_zones" "main" {
  filter {
    name = local.domain
  }
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

resource "cloudflare_pages_domain" "landing_domain" {
  account_id   = var.cloudflare_account_id
  project_name = module.landing_page.name
  domain       = local.domain
}

resource "cloudflare_record" "landing_cname" {
  zone_id = data.cloudflare_zones.main.zones[0].id
  name    = "@"
  type    = "CNAME"
  content = "${module.landing_page.name}.pages.dev"
  ttl     = 1
  proxied = true
}
