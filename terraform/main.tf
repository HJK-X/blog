locals {
  domain       = "justinkim.app"
  github_owner = "HJK-X"
  github_repo  = "blog"
}

data "cloudflare_zone" "main" {
  filter = {
    name = local.domain
  }
}

resource "cloudflare_pages_project" "landing_cfp" {
  account_id        = var.cloudflare_account_id
  name              = "landing"
  production_branch = "main"

  build_config = {
    build_command   = "hugo"
    destination_dir = "public"
    root_dir        = "landing"
  }

  source = {
    config = {
      owner             = local.github_owner
      production_branch = "main"
      repo_name         = local.github_repo
    }
    type = "github"
  }
}

resource "cloudflare_pages_domain" "landing_cfp_domain" {
  account_id   = var.cloudflare_account_id
  project_name = cloudflare_pages_project.landing_cfp.name
  name         = local.domain
}

resource "cloudflare_dns_record" "landing_cfp_cname" {
  comment = "Landing Page redirect CNAME for ${cloudflare_pages_project.landing_cfp.subdomain}"
  content = cloudflare_pages_project.landing_cfp.subdomain
  name    = local.domain
  proxied = true
  ttl     = 1
  type    = "CNAME"
  zone_id = data.cloudflare_zone.main.id
}
