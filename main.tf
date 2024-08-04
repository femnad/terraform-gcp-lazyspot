locals {
  default_self_allow = {
    ""   = "icmp"
    "22" = "tcp"
  }
  public_ip = jsondecode(data.http.ipinfo.response_body).ip
  ip_prefix = format("%s/%s", local.public_ip, var.ip_mask)
  ips = {
    for host in range(var.ip_num) :
    "range" => {
      ip = cidrhost(local.ip_prefix, host)
    }...
  }

  default_ttl  = 600
  default_type = "A"
  name         = var.name == null ? random_pet.this[0].id : var.name

  ssh_user        = coalesce(var.ssh_user, var.github_user)
  ssh_format_spec = format("%s:%%s %s@host", local.ssh_user, local.ssh_user)
  ssh_keys_metadata = join("\n", formatlist(local.ssh_format_spec, [
    for key in jsondecode(data.http.github.response_body) : key.key
  ]))
  ssh_keys_metadata_map = {
    ssh-keys = local.ssh_keys_metadata
  }
}

data "google_compute_image" "this" {
  family  = var.image_family
  project = var.image_project
}

data "http" "github" {
  url = format("https://api.github.com/users/%s/keys", var.github_user)
}

data "http" "ipinfo" {
  url = "https://ipinfo.io/json"
}

resource "random_pet" "this" {
  count = var.name == null ? 1 : 0
}

resource "google_compute_network" "this" {
  name                    = local.name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "this" {
  name          = local.name
  network       = google_compute_network.this.name
  ip_cidr_range = "10.1.0.0/24"
}

resource "google_compute_instance" "instance" {
  name                      = local.name
  machine_type              = var.machine_type
  allow_stopping_for_update = true

  metadata = merge(local.ssh_keys_metadata_map, var.metadata)

  network_interface {
    subnetwork = google_compute_subnetwork.this.name
    access_config {
      network_tier = var.network_tier
    }
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.this.id
      size  = var.disk_size
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
}

resource "google_compute_firewall" "self" {
  name    = "${local.name}-self"
  network = google_compute_network.this.name
  count   = var.self_reachable_ports != null ? 1 : 0

  dynamic "allow" {
    for_each = length(var.self_reachable_ports) > 0 ? var.self_reachable_ports : local.default_self_allow

    content {
      protocol = allow.value
      ports    = allow.value == "icmp" ? null : split(",", allow.key)
    }
  }

  source_ranges = [for ip in local.ips.range : ip.ip]
}

resource "google_compute_firewall" "world" {
  name    = "${local.name}-world"
  network = google_compute_network.this.name
  count   = var.world_reachable_spec != null ? 1 : 0

  dynamic "allow" {
    for_each = var.world_reachable_spec.port_map

    content {
      protocol = allow.value
      ports    = allow.value == "icmp" ? null : split(",", allow.key)
    }
  }

  source_ranges = var.world_reachable_spec.remote_ips == null ? ["0.0.0.0/0"] : var.world_reachable_spec.remote_ips
}

resource "google_dns_record_set" "this" {
  count = var.dns_spec != null ? 1 : 0
  name  = var.dns_spec.name
  type  = coalesce(var.dns_spec.type, local.default_type)
  ttl   = coalesce(var.dns_spec.ttl, local.default_ttl)

  managed_zone = var.dns_spec.zone

  rrdatas = flatten(
    [
      for nic in google_compute_instance.instance.network_interface :
      [
        for cfg in nic.access_config :
        cfg.nat_ip
      ]
  ])
}