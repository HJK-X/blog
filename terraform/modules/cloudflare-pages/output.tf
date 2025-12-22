output "name" {
  value = var.name
}
output "pages_subdomain" {
  value = cloudflare_pages_project.this.subdomain
}
