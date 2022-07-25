locals {
  project_id = "${var.name}-${random_integer.main.result}"
  members    = var.members
}

data "google_client_config" "default" {}

resource "google_project_iam_member" "main" {
  for_each = var.members
  project  = local.project_id
  role     = each.value.role
  member   = each.value.id
}

resource "random_integer" "main" {
  min = 0001
  max = 9999
}

resource "google_project" "main" {
  name            = var.name
  project_id      = local.project_id
  billing_account = var.billing_account
  folder_id       = var.folder_id == "" ? null : var.folder_id
  org_id          = var.org_id == "" ? null : var.org_id
  labels          = var.labels
}

resource "google_project_service" "main" {
  for_each           = toset(var.services)
  project            = google_project.main.id
  service            = each.value
  disable_on_destroy = false
}