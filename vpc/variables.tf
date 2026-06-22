variable "env_name" {
  type        = string
  description = "Environment name (e.g., develop, stage, production)"
}

variable "zone" {
  type        = string
  description = "Availability zone (e.g., ru-central1-a)"
}

variable "cidr" {
  type        = string
  description = "CIDR block for subnet (e.g., 10.0.1.0/24)"
}
