variable "auto_create_subnetworks" {
  type        = bool
  default     = false
  description = "When creating a network, auto create subnetworks?"
}

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
  # Default value duplicated to allow setting `ip_mask` and `ip_name` without specifying `allow`.
  type = object({
    other = optional(map(map(list(string))), {})
    self = optional(object({
      allow = optional(map(list(string)), {
        icmp = []
        tcp  = ["22"]
      })
      ip_mask = optional(number)
      ip_num  = optional(number)
      }), {
      allow = {
        icmp = []
        tcp  = ["22"]
      }
      }
    )
  })
  description = "Firewall specification, passing null will prevent adding default rules"
  default     = {}
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

variable "network" {
  type        = string
  default     = null
  description = "Network name"
}

variable "service_account" {
  type = object({
    name   = string
    scopes = optional(list(string), ["cloud-platform"])
  })
  default     = null
  description = "Optional service account to associate with the instance"
}

variable "ssh_user" {
  type        = string
  default     = ""
  description = "A user name to set for authorized SSH keys, defaults to `github_user`"
}

variable "subnets" {
  type = list(object({
    cidr = string
    name = optional(string)
    tier = optional(string, "PREMIUM")
    })
  )
  default = [
    {
      cidr = "10.1.0.0/24"
    }
  ]
}
