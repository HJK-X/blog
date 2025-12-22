variable "account_id" {
  type = string
}

variable "name" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "production_branch" {
  type    = string
  default = "main"
}

variable "root_dir" {
  type = string
}

variable "destination_dir" {
  type = string
}
