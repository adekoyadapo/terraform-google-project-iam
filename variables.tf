variable "name" {
  type        = string
  description = "The name of the project"
}

variable "billing_account" {
  type        = string
  description = "The billing account ID for the project"
}

variable "project_id" {
  type        = string
  description = "The project id for the project. Only use if `var.random_suffix = false`"
  default     = null
}

variable "org_id" {
  type        = string
  description = "The numeric org id to create the project under. If set, the project will be created at the top level of the organization. Only one of `var.org_id` or `var.folder_id` can be set.  At least one must be set. If both are set, an error will occur."
  default     = null
}

variable "folder_id" {
  type        = string
  description = "The folder id to create the project under. Only one of `var.org_id` or `var.folder_id` may be set. At least one of them must be set. If both are set, an error will occur."
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "A key/value pair for labels to assign to the project"
  default     = {}
}

variable "services" {
  type        = list(string)
  description = "A list of APIs (services) to enable"
  default     = ["compute.googleapis.com"]
}
variable "members" {
  type = map(object({
    id   = string
    role = string
  }))
  description = "list of memebers in the format users:<email> or groups:<group-mail-id> with conditions from https://cloud.google.com/iam/docs/conditions-overview"
  default     = {}
}