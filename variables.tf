variable "disk_size" {
  type        = number
  default     = 10
  description = "Root disk size in GiB"
}

variable "disks" {
  type = list(object({
    source = string,
    name   = string,
  }))
  default     = []
  description = "List of disks to attach"
}

variable "dns" {
  type = object({
    name = string
    ttl  = optional(number)
    type = optional(string)
    zone = string
  })
  description = "DNS properties for the record to associate with the instance"
  default     = null
}

variable "github_user" {
  type        = string
  description = "A GitHub user to lookup allowed SSH keys"
}

variable "firewall" {
  type = object({
    ip_mask = optional(number)
    ip_num  = optional(number)
  })
  description = "Firewall specification"
  default     = null
}

variable "image" {
  type = object({
    project = string
    family  = string
  })
  default = {
    project = "ubuntu-os-cloud"
    family  = "ubuntu-2404-lts-amd64"
  }
  description = "Image specification"
}

variable "machine_type" {
  type        = string
  default     = "e2-micro"
  description = "Instance type"
}

variable "max_run_seconds" {
  type        = number
  default     = 86400 # 24 hours
  description = "Maximum run duration in seconds"
}

variable "metadata" {
  type        = map(string)
  default     = {}
  description = "A map of metadata values"
}

variable "name" {
  type        = string
  default     = null
  description = "Name of the instance"
}

variable "network_tier" {
  type        = string
  default     = "PREMIUM"
  description = "Network tier for the instance"
}

variable "self_reachable" {
  type        = map(string)
  default     = {}
  description = "Map of protocol to comma separated ports, reachable from current IP"
}

variable "service_account" {
  type        = string
  default     = null
  description = "Optional service account to associate with the instance"
}

variable "service_account_scopes" {
  type        = list(string)
  default     = ["cloud-platform"]
  description = "List of service account scopes"
}

variable "ssh_user" {
  type        = string
  default     = ""
  description = "A user name to set for authorized SSH keys, defaults to `github_user`"
}

variable "world_reachable" {
  type = object({
    remote_ips = optional(list(string))
    port_map   = map(string)
  })
  default = null
}