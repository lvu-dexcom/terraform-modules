##########################################
# project global variables
##########################################
variable "existing_project" {
  description = "Existing GCP project id."
  type        = string
}

variable "existing_network" {
  description = "Existing Network"
  type        = string
}

variable "new_project" {
  description = "New GCP project id."
  type        = string
}

variable "new_network" {
  description = "New Network"
  type        = string
}

variable "existing_dest_ranges" {
  description = "existing_dest_ranges"
  type        = list(string)
}

variable "new_dest_ranges" {
  description = "new_dest_ranges"
  type        = list(string)
}

variable "region" {
  description = "GCP region"
  type        = string
}