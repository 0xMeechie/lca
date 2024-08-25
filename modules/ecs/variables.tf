variable "db_instance_class" {
  description = "Instance class for the database"
  type        = string
  default     = "db.t3.micro"
}

variable "max_storage" {
  description = "max amount of space for the database"
  type        = number
  default     = 60
}

variable "db_name" {
  description = "name of the database"
  type        = string
  default     = "testdb"

}

variable "db_engine" {
  description = "Engine that is being used for the db"
  type        = string
  default     = "mysql"

}

variable "db_engine_version" {
  description = "version of the engine"
  type        = string
  default     = "8.0.35"

}

variable "db_username" {
  description = "master username for the databse"
  type        = string
  default     = "foobar"
}

variable "rds_subnets" {
  description = "subnets for the rds database"
  type        = list(string)

}


##################
## ECS Variables##
##################

variable "ecs_cluster_name" {
  description = "name for the ecs cluster"
  type        = string
  default     = "test-cluster"

}

variable "ecs_service_name" {
  description = "name of the service that is being deployed"
  type        = string
  default     = "wordpress"

}

variable "ecs_subnets" {
  description = "subnets to deploy ecs cluster"
  type        = list(string)

}


variable "vpc_id" {

  description = "ID of the vpc to deploy into"
  type        = string

}

variable "environment" {
  description = "environment to deploy"
  type        = string

}

variable "public_subnets" {
  description = "public subnets for public facing resources"
  type        = list(string)

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
