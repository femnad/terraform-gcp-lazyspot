# terraform-gcp-lazyspot

A Terraform module for lazy GCP spot instances.

## Example Usage

### Minimal

```terraform
module "instance" {
  source  = "femnad/lazyspot/gcp"
  version = "0.2.0"

  github_user = "femnad"
}
```

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
| [google_compute_firewall.self](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_firewall.world](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [google_compute_instance.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
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
| <a name="input_disk_size"></a> [disk\_size](#input\_disk\_size) | Root disk size in GiB | `number` | `10` | no |
| <a name="input_disks"></a> [disks](#input\_disks) | List of disks to attach | <pre>list(object({<br>    source = string,<br>    name   = string,<br>  }))</pre> | `[]` | no |
| <a name="input_dns"></a> [dns](#input\_dns) | DNS properties for the record to associate with the instance | <pre>object({<br>    name = string<br>    ttl  = optional(number)<br>    type = optional(string)<br>    zone = string<br>  })</pre> | `null` | no |
| <a name="input_firewall"></a> [firewall](#input\_firewall) | Firewall specification | <pre>object({<br>    ip_mask = optional(number)<br>    ip_num  = optional(number)<br>  })</pre> | `null` | no |
| <a name="input_github_user"></a> [github\_user](#input\_github\_user) | A GitHub user to lookup allowed SSH keys | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Image specification | <pre>object({<br>    project = string<br>    family  = string<br>  })</pre> | <pre>{<br>  "family": "ubuntu-2404-lts-amd64",<br>  "project": "ubuntu-os-cloud"<br>}</pre> | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Instance type | `string` | `"e2-micro"` | no |
| <a name="input_max_run_seconds"></a> [max\_run\_seconds](#input\_max\_run\_seconds) | Maximum run duration in seconds | `number` | `86400` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | A map of metadata values | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the instance | `string` | `null` | no |
| <a name="input_network_tier"></a> [network\_tier](#input\_network\_tier) | Network tier for the instance | `string` | `"PREMIUM"` | no |
| <a name="input_self_reachable"></a> [self\_reachable](#input\_self\_reachable) | Map of protocol to comma separated ports, reachable from current IP | `map(string)` | `{}` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Optional service account to associate with the instance | `string` | `null` | no |
| <a name="input_service_account_scopes"></a> [service\_account\_scopes](#input\_service\_account\_scopes) | List of service account scopes | `list(string)` | <pre>[<br>  "cloud-platform"<br>]</pre> | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | A user name to set for authorized SSH keys, defaults to `github_user` | `string` | `""` | no |
| <a name="input_world_reachable"></a> [world\_reachable](#input\_world\_reachable) | n/a | <pre>object({<br>    remote_ips = optional(list(string))<br>    port_map   = map(string)<br>  })</pre> | `null` | no |

## Outputs

No outputs.
