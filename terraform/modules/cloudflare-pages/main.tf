resource "cloudflare_pages_project" "this" {
  account_id        = var.account_id
  name              = var.name
  production_branch = var.production_branch

  source {
    type = "github"
    config {
      owner             = var.github_owner
      repo_name         = var.github_repo
      production_branch = var.production_branch
    }
  }

  build_config {
    root_dir        = var.root_dir
    build_command   = "hugo"
    destination_dir = var.destination_dir
  }
}
