data "http" "github" {
  url = format("https://api.github.com/users/%s/keys", var.github_user)
}

resource "random_pet" "prefix" {
  count = var.name == null ? 1 : 0
}

locals {
  fallback_prefix   = length(random_pet.prefix) > 0 ? random_pet.prefix[0].id : "instance-module"
  ssh_user          = coalesce(var.ssh_user, var.github_user)
  ssh_format_spec   = format("%s:%%s %s@host", local.ssh_user, local.ssh_user)
  ssh_keys_metadata = join("\n", formatlist(local.ssh_format_spec, [for key in jsondecode(data.http.github.response_body) : key.key]))
  ssh_keys_metadata_map = {
    ssh-keys = local.ssh_keys_metadata
  }
}

resource "google_compute_network" "network" {
  name                    = coalesce(var.network_name, var.name, local.fallback_prefix)
  auto_create_subnetworks = false

  provider = google-beta
}

resource "google_compute_subnetwork" "subnetwork" {
  name          = coalesce(var.subnetwork_name, var.name, local.fallback_prefix)
  network       = google_compute_network.network.name
  ip_cidr_range = "10.1.0.0/24"

  provider = google-beta
}

resource "google_compute_instance" "instance" {
  name                      = coalesce(var.name, local.fallback_prefix)
  machine_type              = var.machine_type
  allow_stopping_for_update = true

  metadata = merge(local.ssh_keys_metadata_map, var.metadata)

  network_interface {
    subnetwork = google_compute_subnetwork.subnetwork.name
    access_config {
      network_tier = var.network_tier
    }
  }

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
    }
  }

  lifecycle {
    ignore_changes = [attached_disk]
  }

  scheduling {
    automatic_restart           = false
    instance_termination_action = "DELETE"
    max_run_duration {
      seconds = var.max_run_seconds
    }
    on_host_maintenance = "TERMINATE"
    preemptible         = true
    provisioning_model  = "SPOT"
  }

  dynamic "service_account" {
    for_each = var.service_account == null ? [] : [1]
    content {
      email  = var.service_account
      scopes = var.service_account_scopes
    }
  }

  dynamic "attached_disk" {
    for_each = var.attached_disks
    content {
      source      = attached_disk.value.source
      device_name = attached_disk.value.name
    }
  }

  provider = google-beta
}
