# terraform-gcp-lazyspot

A Terraform module for lazy GCP spot instances.

Requires [google-beta](https://registry.terraform.io/providers/hashicorp/google-beta/latest) provider in order to set [max_run_duration](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#max_run_duration) for instances.

## Required Input Variables

* `github_user`: A GitHub user to lookup allowed SSH keys

## Optional Input Variables

* `attached_disks`: List of disks to attach, default empty, each item is an object with attributes `source` and `name`
* `image`: Image of the instance, default `fedora-cloud/fedora-cloud-38`
* `machine_type`: Instance type, default `e2-micro`
* `max_run_seconds`: Duration of the instance, in seconds, default 86400 (24 hours).
* `metadata`: Metadata values
* `name`: Name of the instance, random if null
* `network_name`: Name of the instance's network, if null derived from instance name or random if no instance name is given
* `network_tier`: Network tier for the instance, default `STANDARD`
* `service_account_scopes`: List of service account scopes, default `["cloud-platform"]`
* `service_account`: Optional service account to associate with the instance
* `size`: Image size in GiB, default `10`
* `ssh_user`: A user name to set for authorized SSH keys, defaults to `github_user`
* `subnetwork_name`: Name of the instance's subnetwork, if null derived from instance name or random if no instance name is given

## Example Usage

### Minimal

```
provider "google" {
  project = <project>
  zone    = <zone>
}

module "instance" {
  source  = "femnad/lazyspot/gcp"
  version = "0.1.0"

  github_user     = "femnad"

  providers = {
    google = google
  }
}
```
