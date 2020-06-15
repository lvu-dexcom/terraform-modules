##########################################
# project global variables
##########################################
variable "project" {
  description = "GCP project id."
  type        = string
}

variable "regions" {
  description = "GCP region"
  type        = list(string)
}

variable "network" {
  description = "Network"
  type        = string
}