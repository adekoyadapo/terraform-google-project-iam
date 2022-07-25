# Terraform GCP project with IAM permission module
This module creates a gcp project and assigned groups to with predetermined roles to the project

## Prerequisite
The GCP account needed should have an org level access and notably the following `ROLE`

```
ROLE
roles/owner
roles/resourcemanager.folderAdmin
roles/resourcemanager.organizationAdmin
roles/resourcemanager.projectCreator
roles/billing.user
```

Also the group must exist and already created in google admin console, but neccesarily with members, for users, the user must be specifically invited into the org to avoid errors like

```
│ Error: Request `Create IAM Members roles/owner user:user@domain.com for project "iam-proj-demo"` returned error: Batch request and retried single request "Create IAM Members roles/owner user:user@domain.com for project \"iam-proj-demo\"" both failed. Final error: Error applying IAM policy for project "iam-proj-demo": Error setting IAM policy for project "iam-proj-demo-4022": googleapi: Error 400: Request contains an invalid argument.
│ Details:
│ [
│   {
│     "@type": "type.googleapis.com/google.cloudresourcemanager.v1.ProjectIamPolicyError",
│     "member": "user:user@domain.com",
│     "role": "roles/owner",
│     "type": "ORG_MUST_INVITE_EXTERNAL_OWNERS"
│   }
│ ]
│ , badRequest

```

Usage
```
# main.tf
data "google_client_config" "default" {}

module "prj_iam" {
  source          = "adekoyadapo/project-iam/google"
  name            = "demoprojectiam"
  billing_account = "01XXXX-XXXXXX-XXXXXX"
  org_id          = "1234567890123" # or folder_id = "1234567890123"
  services = [
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
  ]
  members = {
    "contractors" = {
      id   = "group:external-vendors@example.com"
      role = "roles/editor"
    }
  }
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 4.25.0, < 5.0.0 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | >= 4.25.0, < 5.0.0 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.2.3 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.3.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 4.25.0, < 5.0.0 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.3.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_member.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [random_integer.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) | resource |
| [google_client_config.default](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | The billing account ID for the project | `string` | n/a | yes |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | The folder id to create the project under. Only one of `var.org_id` or `var.folder_id` may be set. At least one of them must be set. If both are set, an error will occur. | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A key/value pair for labels to assign to the project | `map(string)` | `{}` | no |
| <a name="input_members"></a> [members](#input\_members) | list of memebers in the format users:<email> or groups:<group-mail-id> with conditions from https://cloud.google.com/iam/docs/conditions-overview | <pre>map(object({<br>    id = string<br>    role = string<br>  }))</pre> | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the project | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The numeric org id to create the project under. If set, the project will be created at the top level of the organization. Only one of `var.org_id` or `var.folder_id` can be set.  At least one must be set. If both are set, an error will occur. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project id for the project. Only use if `var.random_suffix = false` | `string` | `null` | no |
| <a name="input_services"></a> [services](#input\_services) | A list of APIs (services) to enable | `list(string)` | <pre>[<br>  "compute.googleapis.com"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The id for project with the format `projects/{{project}}` |
| <a name="output_project_number"></a> [project\_number](#output\_project\_number) | The numeric identifier for the project. |
<!-- END_TF_DOCS -->