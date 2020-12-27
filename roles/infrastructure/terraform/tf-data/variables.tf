variable "domain" {
  type        = string
  description = "Top Level Domain"
}

variable "installation_image" {
  type        = string
  description = "Path to the installation images"
}

variable "master_count" {
  type        = number
  description = "Number of masters"
}

variable "worker_count" {
  type        = number
  description = "Number of workers"
}