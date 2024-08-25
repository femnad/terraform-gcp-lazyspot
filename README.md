# terraform-gcp-lazyspot

A Terraform module for lazy GCP spot instances.

## Example Usage

### Minimal

```terraform
provider "google" {
    # Google provider configuration here.
}

module "instance" {
  source  = "femnad/lazyspot/gcp"
  version = "0.6.3"

  github_user = "femnad"

  provider {
    google = google
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 5.39.1 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | >= 5.39.1 |
| <a name="provider_http"></a> [http](#provider\_http) | >= 3.4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_firewall.other](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.self](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_compute_network.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_network) | resource |
| [google_compute_subnetwork.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_subnetwork) | resource |
| [google_dns_record_set.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [google_compute_image.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [http_http.github](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.ipinfo](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_user"></a> [github\_user](#input\_github\_user) | A GitHub user to lookup allowed SSH keys | `string` | n/a | yes |
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | When creating a network, auto create subnetworks? | `bool` | `false` | no |
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Root disk size in GiB | `number` | `10` | no |
| <a name="input_disks"></a> [disks](#input\_disks) | List of disks to attach | <pre>list(object({<br>    source = string,<br>    name   = string,<br>  }))</pre> | `[]` | no |
| <a name="input_dns"></a> [dns](#input\_dns) | DNS properties for the record to associate with the instance | <pre>object({<br>    name = string<br>    ttl  = optional(number)<br>    type = optional(string)<br>    zone = string<br>  })</pre> | `null` | no |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | Firewall specification, passing null will prevent adding default rules | <pre>object({<br>    other = optional(map(map(list(string))), {})<br>    self = optional(object({<br>      allow   = optional(map(list(string)))<br>      ip_mask = optional(number)<br>      ip_num  = optional(number)<br>      }), {<br>      allow = {<br>        icmp = []<br>        tcp  = ["22"]<br>      }<br>      }<br>    )<br>  })</pre> | `{}` | no |
| <a name="input_image"></a> [image](#input\_image) | Image specification | <pre>object({<br>    project = string<br>    family  = string<br>  })</pre> | <pre>{<br>  "family": "ubuntu-2404-lts-amd64",<br>  "project": "ubuntu-os-cloud"<br>}</pre> | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Instance type | `string` | `"e2-micro"` | no |
| <a name="input_max_run_seconds"></a> [max\_run\_seconds](#input\_max\_run\_seconds) | Maximum run duration in seconds | `number` | `86400` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | A map of metadata values | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the instance | `string` | `null` | no |
| <a name="input_network"></a> [network](#input\_network) | Network name | `string` | `null` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Optional service account to associate with the instance | <pre>object({<br>    name   = string<br>    scopes = optional(list(string), ["cloud-platform"])<br>  })</pre> | `null` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | A user name to set for authorized SSH keys, defaults to `github_user` | `string` | `""` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | n/a | <pre>list(object({<br>    cidr = string<br>    name = optional(string)<br>    tier = optional(string, "PREMIUM")<br>    })<br>  )</pre> | <pre>[<br>  {<br>    "cidr": "10.1.0.0/24"<br>  }<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
