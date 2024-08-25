variable "environment" {
  description = "Environment to deploy to"
  type        = string
  default     = "qa"
}

variable "ecs_cluster_name" {
  description = "name for the ecs cluster"
  type        = string

}

variable "container_name" {
  description = "name of the container"
  type        = string

}

variable "container_port" {
  description = "port of the container"
  type        = number
  default     = 80

}

variable "container_image" {
  description = "image of the container"
  type        = string

}

variable "container_image_version" {
  description = "container image version"
  type        = string
  default     = "latest"

}


