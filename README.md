# terraform-gcp-lazyspot

A Terraform module for lazy GCP spot instances.

Requires [google-beta](https://registry.terraform.io/providers/hashicorp/google-beta/latest) provider in order to set [max_run_duration](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#max_run_duration) for instances.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_google-beta"></a> [google-beta](#requirement\_google-beta) | 5.4.0 |
| <a name="requirement_http"></a> [http](#requirement\_http) | >= 3.4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.5.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_google-beta"></a> [google-beta](#provider\_google-beta) | 5.4.0 |
| <a name="provider_http"></a> [http](#provider\_http) | >= 3.4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.5.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google-beta_google_compute_firewall.self-reachable](https://registry.terraform.io/providers/hashicorp/google-beta/5.4.0/docs/resources/google_compute_firewall) | resource |
| [google-beta_google_compute_firewall.world-reachable](https://registry.terraform.io/providers/hashicorp/google-beta/5.4.0/docs/resources/google_compute_firewall) | resource |
| [google-beta_google_compute_instance.instance](https://registry.terraform.io/providers/hashicorp/google-beta/5.4.0/docs/resources/google_compute_instance) | resource |
| [google-beta_google_compute_network.network](https://registry.terraform.io/providers/hashicorp/google-beta/5.4.0/docs/resources/google_compute_network) | resource |
| [google-beta_google_compute_subnetwork.subnetwork](https://registry.terraform.io/providers/hashicorp/google-beta/5.4.0/docs/resources/google_compute_subnetwork) | resource |
| [google-beta_google_dns_record_set.this](https://registry.terraform.io/providers/hashicorp/google-beta/5.4.0/docs/resources/google_dns_record_set) | resource |
| [random_pet.this](https://registry.terraform.io/providers/hashicorp/random/3.5.1/docs/resources/pet) | resource |
| [google_compute_image.this](https://registry.terraform.io/providers/hashicorp/google/latest/docs/data-sources/compute_image) | data source |
| [http_http.github](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |
| [http_http.ipinfo](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_attached_disks"></a> [attached\_disks](#input\_attached\_disks) | List of disks to attach | <pre>list(object({<br>    source = string,<br>    name   = string,<br>  }))</pre> | `[]` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | DNS name to associate with the instance | `string` | n/a | yes |
| <a name="input_dns_ttl"></a> [dns\_ttl](#input\_dns\_ttl) | TTL for the DNS record | `number` | `600` | no |
| <a name="input_dns_zone"></a> [dns\_zone](#input\_dns\_zone) | Name fo the DNS managed zone | `string` | n/a | yes |
| <a name="input_github_user"></a> [github\_user](#input\_github\_user) | A GitHub user to lookup allowed SSH keys | `string` | n/a | yes |
| <a name="input_image"></a> [image](#input\_image) | Image specification | <pre>object({<br>    project = string<br>    family  = string<br>  })</pre> | <pre>{<br>  "family": "ubuntu-2404-lts-amd64",<br>  "project": "ubuntu-os-cloud"<br>}</pre> | no |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | Image family | `string` | `"ubuntu-2404-lts-amd64"` | no |
| <a name="input_image_project"></a> [image\_project](#input\_image\_project) | Image project | `string` | `"ubuntu-os-cloud"` | no |
| <a name="input_ip_mask"></a> [ip\_mask](#input\_ip\_mask) | n/a | `number` | `32` | no |
| <a name="input_ip_num"></a> [ip\_num](#input\_ip\_num) | n/a | `number` | `1` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | Instance type | `string` | `"e2-micro"` | no |
| <a name="input_max_run_seconds"></a> [max\_run\_seconds](#input\_max\_run\_seconds) | Maximum run duration in seconds | `number` | `86400` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | A map of metadata values | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the instance | `string` | `null` | no |
| <a name="input_network_tier"></a> [network\_tier](#input\_network\_tier) | Network tier for the instance | `string` | `"STANDARD"` | no |
| <a name="input_self_reachable_ports"></a> [self\_reachable\_ports](#input\_self\_reachable\_ports) | Map of protocol to comma separated ports, reachable from current IP | `map(string)` | `{}` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | Optional service account to associate with the instance | `string` | `null` | no |
| <a name="input_service_account_scopes"></a> [service\_account\_scopes](#input\_service\_account\_scopes) | List of service account scopes | `list(string)` | <pre>[<br>  "cloud-platform"<br>]</pre> | no |
| <a name="input_size"></a> [size](#input\_size) | Image size in GiB | `number` | `10` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | A user name to set for authorized SSH keys, defaults to `github_user` | `string` | `""` | no |
| <a name="input_world_reachable_spec"></a> [world\_reachable\_spec](#input\_world\_reachable\_spec) | n/a | <pre>object({<br>    remote_ips = optional(list(string))<br>    port_map   = map(string)<br>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | n/a |
| <a name="output_instance_ip_addr"></a> [instance\_ip\_addr](#output\_instance\_ip\_addr) | n/a |
| <a name="output_name"></a> [name](#output\_name) | n/a |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | n/a |

## Example Usage

### Minimal

```
provider "google-beta" {
  project = <project>
  zone    = <zone>
}

module "instance" {
  source  = "femnad/lazyspot/gcp"
  version = "0.1.0"

  github_user = "femnad"

  providers = {
    google-beta = google-beta
  }
}
```
